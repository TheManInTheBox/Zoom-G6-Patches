param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = "$SongPath.hhride-audibility-pre-$stamp"
Copy-Item $SongPath $backup -Force

$tmp = Join-Path $env:TEMP ('deadair_hhride_audibility_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$xmlPath = Join-Path $tmp 'Devices\audiomixer.xml'
$xml = Get-Content $xmlPath -Raw

function ToLinear([double]$db) {
  [math]::Pow(10, $db / 20.0).ToString('R', [Globalization.CultureInfo]::InvariantCulture)
}

function Set-GainInOpenTag([string]$tag, [double]$db) {
  $g = ToLinear $db
  if ($tag -match 'gain="[^"]*"') {
    return ($tag -replace 'gain="[^"]*"', ('gain="' + $g + '"'))
  }
  return ($tag.TrimEnd('>') + ' gain="' + $g + '">')
}

function Set-AllSynthByLabel([string]$x, [string]$label, [double]$db) {
  $rx = '(?is)(<AudioSynthChannel\b[^>]*label="' + [regex]::Escape($label) + '"[^>]*>)'
  [regex]::Replace($x, $rx, { param($m) Set-GainInOpenTag $m.Groups[1].Value $db })
}

function Set-FirstTrackByLabel([string]$x, [string]$label, [double]$db) {
  $rx = '(?is)(<AudioTrackChannel\b[^>]*label="' + [regex]::Escape($label) + '"[^>]*>)'
  [regex]::Replace($x, $rx, { param($m) Set-GainInOpenTag $m.Groups[1].Value $db }, 1)
}

# Bring HH/Ride back into audibility
$xml = Set-AllSynthByLabel $xml 'Ride' -3.5
$xml = Set-FirstTrackByLabel $xml 'HH' -3.0
$xml = Set-FirstTrackByLabel $xml 'Ride' -3.5

Set-Content -Path $xmlPath -Value $xml -Encoding UTF8

function Edit-ProEq([string]$presetPath, [scriptblock]$mutator) {
  if (-not (Test-Path $presetPath)) { return }
  $j = Get-Content $presetPath -Raw | ConvertFrom-Json
  & $mutator $j
  $j | ConvertTo-Json -Depth 20 | Set-Content -Path $presetPath -Encoding UTF8
}

$root = Join-Path $tmp 'Presets\Channels'

# HH close mic EQ: less severe HPF/cuts
Edit-ProEq (Join-Path $root 'HH\1 - Pro EQ.dsppreset') {
  param($p)
  $p.parameters.lowcut.lcactive = 1.0
  $p.parameters.lowcut.lcfreq = 180.0
  $p.parameters.lowcut.lcslope = 2.0
  $p.parameters.lowmidfrequency.lmfactive = 1.0
  $p.parameters.lowmidfrequency.lmffreq = 420.0
  $p.parameters.lowmidfrequency.lmfgain = -1.0
  $p.parameters.lowmidfrequency.lmfq = 1.2
  $p.parameters.highmidfrequency.hmfactive = 1.0
  $p.parameters.highmidfrequency.hmffreq = 7300.0
  $p.parameters.highmidfrequency.hmfgain = -1.2
  $p.parameters.highmidfrequency.hmfq = 1.3
  $p.parameters.highfrequency.hfactive = 1.0
  $p.parameters.highfrequency.hffreq = 12000.0
  $p.parameters.highfrequency.hfgain = 0.8
  $p.parameters.highfrequency.hftype = 1.0
  $p.parameters.highfrequency.hfq = 1.0
}

# Ride EQ for both synth and mic ride channels
$ridePresets = @(
  (Join-Path $root 'Ride\1 - Pro EQ.dsppreset'),
  (Join-Path $root 'Ride\1 - Pro EQ(2).dsppreset')
)
foreach ($rp in $ridePresets) {
  Edit-ProEq $rp {
    param($p)
    $p.parameters.lowcut.lcactive = 1.0
    $p.parameters.lowcut.lcfreq = 180.0
    $p.parameters.lowcut.lcslope = 2.0
    $p.parameters.lowmidfrequency.lmfactive = 1.0
    $p.parameters.lowmidfrequency.lmffreq = 450.0
    $p.parameters.lowmidfrequency.lmfgain = -1.2
    $p.parameters.lowmidfrequency.lmfq = 1.2
    $p.parameters.highmidfrequency.hmfactive = 1.0
    $p.parameters.highmidfrequency.hmffreq = 7000.0
    $p.parameters.highmidfrequency.hmfgain = -1.0
    $p.parameters.highmidfrequency.hmfq = 1.2
    $p.parameters.highfrequency.hfactive = 1.0
    $p.parameters.highfrequency.hffreq = 11500.0
    $p.parameters.highfrequency.hfgain = 1.0
    $p.parameters.highfrequency.hftype = 1.0
    $p.parameters.highfrequency.hfq = 1.0
  }
}

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host "Applied HH/Ride audibility patch to: $SongPath"
Write-Host "Safety snapshot: $backup"
