param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = "$SongPath.levelmatch-pre-$stamp"
Copy-Item $SongPath $backup -Force

$tmp = Join-Path $env:TEMP ('deadair_levelmatch_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$xmlPath = Join-Path $tmp 'Devices\audiomixer.xml'
$xml = Get-Content $xmlPath -Raw

function To-Linear([double]$db) {
  [math]::Pow(10, $db / 20.0).ToString('R', [Globalization.CultureInfo]::InvariantCulture)
}

function Set-GainInOpenTag([string]$tag, [double]$db) {
  $g = To-Linear $db
  if ($tag -match 'gain="[^"]*"') {
    return ($tag -replace 'gain="[^"]*"', ('gain="' + $g + '"'))
  }
  return ($tag.TrimEnd('>') + ' gain="' + $g + '">')
}

function Set-FirstBusByLabel([string]$x, [string]$label, [double]$db) {
  $rx = '(?is)(<AudioSynthBusChannel\b[^>]*label="' + [regex]::Escape($label) + '"[^>]*>)'
  [regex]::Replace($x, $rx, { param($m) Set-GainInOpenTag $m.Groups[1].Value $db }, 1)
}

function Set-AllSynthByLabel([string]$x, [string]$label, [double]$db) {
  $rx = '(?is)(<AudioSynthChannel\b[^>]*label="' + [regex]::Escape($label) + '"[^>]*>)'
  [regex]::Replace($x, $rx, { param($m) Set-GainInOpenTag $m.Groups[1].Value $db })
}

function Set-FirstTrackByLabel([string]$x, [string]$label, [double]$db) {
  $rx = '(?is)(<AudioTrackChannel\b[^>]*label="' + [regex]::Escape($label) + '"[^>]*>)'
  [regex]::Replace($x, $rx, { param($m) Set-GainInOpenTag $m.Groups[1].Value $db }, 1)
}

# Target level map (dB)
$xml = Set-FirstBusByLabel $xml 'Drum Bus' -2.0

$xml = Set-AllSynthByLabel $xml 'Kick' 0.0
$xml = Set-AllSynthByLabel $xml 'Snare' -0.5
$xml = Set-AllSynthByLabel $xml 'High Tom' -1.5
$xml = Set-AllSynthByLabel $xml 'Mid Tom' -1.5
$xml = Set-AllSynthByLabel $xml 'Floor Tom 14' -1.0
$xml = Set-AllSynthByLabel $xml 'Floor Tom 16' -1.0

$xml = Set-AllSynthByLabel $xml 'OH L' -2.5
$xml = Set-AllSynthByLabel $xml 'OH R' -2.5
$xml = Set-AllSynthByLabel $xml 'Crash' -6.0
$xml = Set-AllSynthByLabel $xml 'Crash L' -6.0
$xml = Set-AllSynthByLabel $xml 'Crash R' -6.0
$xml = Set-AllSynthByLabel $xml 'Ride' -6.5
$xml = Set-AllSynthByLabel $xml 'China' -5.5

$xml = Set-FirstTrackByLabel $xml 'HH' -6.0
$xml = Set-FirstTrackByLabel $xml 'Ride' -6.5

Set-Content -Path $xmlPath -Value $xml -Encoding UTF8

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host "Applied level match to: $SongPath"
Write-Host "Safety snapshot: $backup"
