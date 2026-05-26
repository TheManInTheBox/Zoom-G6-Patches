param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$tmp = Join-Path $env:TEMP ('deadair_vocals_final_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$root = Join-Path $tmp 'Presets\Channels\Vocals'

# 1) Compressor - controlled rock vocal compression
$compPath = Join-Path $root '1 - Compressor.fxpreset'
if (Test-Path $compPath) {
  $txt = Get-Content $compPath -Raw
  $m = [regex]::Match($txt, '<Attributes\s+x:id="ParameterData"[^>]*>')
  if ($m.Success) {
    $line = $m.Value
    $vals = @{
      linked = '0'
      lookAhead = '0'
      ratio = '0.56'
      threshold = '-20.0'
      knee = '10'
      gain = '6.0'
      attack = '0.008'
      release = '0.090'
      adaptive = '1'
      sidechainfreqhigh = '12000'
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

# 2) Pro EQ - de-mud, presence, controlled air
$eqPath = Join-Path $root '2 - Pro EQ.dsppreset'
if (Test-Path $eqPath) {
  $j = Get-Content $eqPath -Raw | ConvertFrom-Json
  $p = $j.parameters

  $p.lowcut.lcactive = 1.0
  $p.lowcut.lcfreq = 85.0
  $p.lowcut.lcslope = 1.0

  $p.lowfrequency.lfactive = 1.0
  $p.lowfrequency.lftype = 1.0
  $p.lowfrequency.lffreq = 120.0
  $p.lowfrequency.lfgain = -3.0
  $p.lowfrequency.lfq = 2.0

  $p.lowmidfrequency.lmfactive = 1.0
  $p.lowmidfrequency.lmffreq = 340.0
  $p.lowmidfrequency.lmfgain = -2.4
  $p.lowmidfrequency.lmfq = 1.4

  $p.midfrequency.mfactive = 1.0
  $p.midfrequency.mffreq = 2800.0
  $p.midfrequency.mfgain = 2.2
  $p.midfrequency.mfq = 1.6

  $p.highmidfrequency.hmfactive = 1.0
  $p.highmidfrequency.hmffreq = 5200.0
  $p.highmidfrequency.hmfgain = 1.2
  $p.highmidfrequency.hmfq = 1.8

  $p.highfrequency.hfactive = 1.0
  $p.highfrequency.hftype = 1.0
  $p.highfrequency.hffreq = 10500.0
  $p.highfrequency.hfgain = 2.0
  $p.highfrequency.hfq = 1.0

  $j | ConvertTo-Json -Depth 20 | Set-Content -Path $eqPath -Encoding UTF8
}

# 3) Room Reverb - subtle support only
$revPath = Join-Path $root '3 - Room Reverb.fxpreset'
if (Test-Path $revPath) {
  $txt = Get-Content $revPath -Raw
  $m = [regex]::Match($txt, '<Attributes\s+x:id="ParameterData"[^>]*>')
  if ($m.Success) {
    $line = $m.Value
    $vals = @{
      mix = '0.16'
      predelayoffset = '-0.08'
      lengthoffset = '-0.45'
      distance = '0.14'
      damping = '0.25'
    }
    foreach ($k in $vals.Keys) {
      if ($line -match ($k + '="[^"]*"')) {
        $line = [regex]::Replace($line, $k + '="[^"]*"', $k + '="' + $vals[$k] + '"')
      } else {
        $line = $line.TrimEnd('>') + ' ' + $k + '="' + $vals[$k] + '">'
      }
    }
    $txt = $txt.Replace($m.Value, $line)
    Set-Content -Path $revPath -Value $txt -Encoding UTF8
  }
}

# 4) Voice FX - disabled for clean lead vocal
$vfxPath = Join-Path $root '4 - Voice FX.dsppreset'
if (Test-Path $vfxPath) {
  $j = Get-Content $vfxPath -Raw | ConvertFrom-Json
  $j.parameters.voicefx.on = 0.0
  $j.parameters.voicefx.mix = 0.0
  $j.parameters.voicefx.detune = 0.0
  $j | ConvertTo-Json -Depth 20 | Set-Content -Path $vfxPath -Encoding UTF8
}

# Slight vocal fader normalization on the active Vocals channel
$mxPath = Join-Path $tmp 'Devices\audiomixer.xml'
$mx = Get-Content $mxPath -Raw
$targetGain = [math]::Pow(10, 0.5 / 20.0).ToString('R', [Globalization.CultureInfo]::InvariantCulture)
$mx = [regex]::Replace(
  $mx,
  '(?is)(<AudioTrackChannel\b[^>]*label="Vocals"[^>]*?)gain="[^"]*"',
  ('$1gain="' + $targetGain + '"'),
  1
)
Set-Content -Path $mxPath -Value $mx -Encoding UTF8

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host 'Vocal chain setup applied directly to live song.'
