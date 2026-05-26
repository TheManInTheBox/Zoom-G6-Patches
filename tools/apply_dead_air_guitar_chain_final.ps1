param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$tmp = Join-Path $env:TEMP ('deadair_guitar_final_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$guitarRoot = Join-Path $tmp 'Presets\Channels\Guitar'

# 1) Pro EQ - rhythm-focused cleanup and presence shaping.
$eqPath = Join-Path $guitarRoot '1 - Pro EQ.dsppreset'
if (Test-Path $eqPath) {
  $eq = Get-Content $eqPath -Raw | ConvertFrom-Json
  $p = $eq.parameters

  $p.lowcut.lcactive = 1.0
  $p.lowcut.lcfreq = 75.0
  $p.lowcut.lcslope = 1.0

  $p.lowfrequency.lfactive = 0.0
  $p.lowfrequency.lftype = 0.0
  $p.lowfrequency.lffreq = 110.0
  $p.lowfrequency.lfgain = 0.0
  $p.lowfrequency.lfq = 1.0

  $p.lowmidfrequency.lmfactive = 1.0
  $p.lowmidfrequency.lmffreq = 295.821655273438
  $p.lowmidfrequency.lmfgain = -2.40000152587891
  $p.lowmidfrequency.lmfq = 1.22472655773163

  $p.midfrequency.mfactive = 1.0
  $p.midfrequency.mffreq = 1552.49438476562
  $p.midfrequency.mfgain = 0.959999084472656
  $p.midfrequency.mfq = 0.70710700750351

  $p.highmidfrequency.hmfactive = 1.0
  $p.highmidfrequency.hmffreq = 3810.91748046875
  $p.highmidfrequency.hmfgain = -1.44000053405762
  $p.highmidfrequency.hmfq = 2.0011568069458

  $p.highfrequency.hfactive = 0.0
  $p.highfrequency.hftype = 1.0
  $p.highfrequency.hffreq = 10999.9990234375
  $p.highfrequency.hfgain = 0.0
  $p.highfrequency.hfq = 1.0

  $eq | ConvertTo-Json -Depth 20 | Set-Content -Path $eqPath -Encoding UTF8
}

# 2) Compressor - light glue, not obvious pumping.
$compPath = Join-Path $guitarRoot '2 - Compressor.fxpreset'
if (Test-Path $compPath) {
  $txt = Get-Content $compPath -Raw
  $m = [regex]::Match($txt, '<Attributes\s+x:id="ParameterData"[^>]*>')
  if ($m.Success) {
    $line = $m.Value
    $vals = @{
      linked = '1'
      lookAhead = '1'
      mix = '1'
      ratio = '0.75'
      threshold = '-20.159999847412109375'
      knee = '6'
      auto = '0'
      gain = '0'
      ingain = '1.69044077396392822265625'
      autospeed = '0'
      attack = '0.015000001527369022369384765625'
      release = '0.082148082554340362548828125'
      adaptive = '0'
      internalsidechain = '0'
      sidechainlisten = '0'
      sidechainfreqlow = '20'
      sidechainfreqhigh = '16000'
      swapfreqs = '0'
    }
    foreach ($k in $vals.Keys) {
      if ($line -match ($k + '="[^"]*"')) {
        $line = [regex]::Replace($line, $k + '="[^"]*"', $k + '="' + $vals[$k] + '"')
      } else {
        $line = $line.TrimEnd('>') + ' ' + $k + '="' + $vals[$k] + '">'
      }
    }
    $txt = $txt.Replace($m.Value, $line)
    Set-Content -Path $compPath -Value $txt -Encoding UTF8
  }
}

# 3) RedlightDist - subtle color only.
$distPath = Join-Path $guitarRoot '3 - RedlightDist.fxpreset'
if (Test-Path $distPath) {
  $txt = Get-Content $distPath -Raw
  $m = [regex]::Match($txt, '<Attributes\s+x:id="ParameterData"[^>]*>')
  if ($m.Success) {
    $line = $m.Value
    $vals = @{
      type = '0'
      stages = '1'
      ingain = '1.25863564014434814453125'
      bias = '1.7599999904632568359375'
      drive = '1.99580037593841552734375'
      outgain = '1'
      low = '20'
      high = '16000'
      mix = '0.15'
    }
    foreach ($k in $vals.Keys) {
      if ($line -match ($k + '="[^"]*"')) {
        $line = [regex]::Replace($line, $k + '="[^"]*"', $k + '="' + $vals[$k] + '"')
      } else {
        $line = $line.TrimEnd('>') + ' ' + $k + '="' + $vals[$k] + '">'
      }
    }
    $txt = $txt.Replace($m.Value, $line)
    Set-Content -Path $distPath -Value $txt -Encoding UTF8
  }
}

# 4) Guitar channel - make it audible and keep monitoring on.
$mxPath = Join-Path $tmp 'Devices\audiomixer.xml'
$mx = Get-Content $mxPath -Raw

if ($mx.Contains('$10.18" pan="0.5" lockPan="1">')) {
  $mx = $mx.Replace('$10.18" pan="0.5" lockPan="1">', 'level="0.18" pan="0.5" lockPan="1">')
}

if ($mx.Contains('</AudioTrackChannel>`r`n`t`t`t<Attributes x:id="InputFX" gain="-0.47999668121337890625" invertPhaseL="0" invertPhaseR="0"/>')) {
  $mx = $mx.Replace(
    '</AudioTrackChannel>`r`n`t`t`t<Attributes x:id="InputFX" gain="-0.47999668121337890625" invertPhaseL="0" invertPhaseR="0"/>',
    '</AudioTrackChannel>' + [Environment]::NewLine + ([char]9 + [char]9 + [char]9 + '<Attributes x:id="InputFX" gain="-0.47999668121337890625" invertPhaseL="0" invertPhaseR="0"/>')
  )
}

if ($mx -notmatch '<AudioMixer\s+xmlns:x=') {
  $mx = [regex]::Replace($mx, '<AudioMixer>', '<AudioMixer xmlns:x="http://www.w3.org/2001/XMLSchema-instance">', 1)
}

$mx = [regex]::Replace(
  $mx,
  '(?is)(<AudioTrackChannel\b[^>]*label="Guitar"[^>]*?)mute="[01]"\s+solo="[0-9]+"\s+soloSafe="[01]"',
  ('$1mute="0" solo="0" soloSafe="1"'),
  1
)

$mx = [regex]::Replace(
  $mx,
  '(?is)(<AudioTrackChannel\b[^>]*label="Guitar"[\s\S]*?<Attributes x:id="RecordUnit">[\s\S]*?<Attributes x:id="data"\s+)recordArmed="[01]"\s+monitorActive="[01]"',
  ('$1recordArmed="1" monitorActive="1"'),
  1
)

$mx = [regex]::Replace(
  $mx,
  '(?is)</AudioTrackChannel>\s*<Attributes name="Send01"[\s\S]*?<Attributes x:id="InputFX"',
  ('</AudioTrackChannel>' + [Environment]::NewLine + ([char]9 + [char]9 + [char]9 + '<Attributes x:id="InputFX"')),
  1
)

$send01Pattern = '(?is)(<Attributes name="Send01" bypass="0" prefader="0" level=")0\.5(" pan="0\.5" lockPan="1">)'
$send02Pattern = '(?is)(<Attributes name="Send02" bypass="0" prefader="0" level=")0\.5(" pan="0\.5" lockPan="1">)'

$mx = [regex]::Replace($mx, $send01Pattern, {
  param($match)
  $match.Groups[1].Value + '0.18' + $match.Groups[2].Value
}, 1)

$mx = [regex]::Replace($mx, $send02Pattern, {
  param($match)
  $match.Groups[1].Value + '0.20' + $match.Groups[2].Value
}, 1)

Set-Content -Path $mxPath -Value $mx -Encoding UTF8

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host 'Dead Air guitar chain final pass applied.'