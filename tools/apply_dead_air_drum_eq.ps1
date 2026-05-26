param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = "$SongPath.drumeq-pre-$stamp"
Copy-Item $SongPath $backup -Force

$tmp = Join-Path $env:TEMP ('deadair_drumeq_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

function Set-Param($preset, [string]$section, [string]$name, [double]$value) {
  $preset.parameters.$section.$name = $value
}

function Edit-ProEqPreset([string]$filePath, [scriptblock]$mutator) {
  if (-not (Test-Path $filePath)) {
    return
  }
  $raw = Get-Content $filePath -Raw
  $json = $raw | ConvertFrom-Json
  & $mutator $json
  $json | ConvertTo-Json -Depth 20 | Set-Content -Path $filePath -Encoding UTF8
}

$presetsRoot = Join-Path $tmp 'Presets\Channels'

# Kick: more weight + click, less cardboard
Edit-ProEqPreset (Join-Path $presetsRoot 'Kick\1 - Pro EQ.dsppreset') {
  param($p)
  Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 35; Set-Param $p 'lowcut' 'lcslope' 1
  Set-Param $p 'lowfrequency' 'lfactive' 1; Set-Param $p 'lowfrequency' 'lftype' 0; Set-Param $p 'lowfrequency' 'lffreq' 72; Set-Param $p 'lowfrequency' 'lfgain' 3.2; Set-Param $p 'lowfrequency' 'lfq' 1.15
  Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 320; Set-Param $p 'lowmidfrequency' 'lmfgain' -4.2; Set-Param $p 'lowmidfrequency' 'lmfq' 1.5
  Set-Param $p 'midfrequency' 'mfactive' 1; Set-Param $p 'midfrequency' 'mffreq' 3600; Set-Param $p 'midfrequency' 'mfgain' 2.8; Set-Param $p 'midfrequency' 'mfq' 1.2
}

# Snare: body + crack, tame boxiness
Edit-ProEqPreset (Join-Path $presetsRoot 'Snare\1 - Pro EQ.dsppreset') {
  param($p)
  Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 90; Set-Param $p 'lowcut' 'lcslope' 1
  Set-Param $p 'lowfrequency' 'lfactive' 1; Set-Param $p 'lowfrequency' 'lftype' 0; Set-Param $p 'lowfrequency' 'lffreq' 190; Set-Param $p 'lowfrequency' 'lfgain' 1.8; Set-Param $p 'lowfrequency' 'lfq' 1.1
  Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 520; Set-Param $p 'lowmidfrequency' 'lmfgain' -3.2; Set-Param $p 'lowmidfrequency' 'lmfq' 1.6
  Set-Param $p 'midfrequency' 'mfactive' 1; Set-Param $p 'midfrequency' 'mffreq' 2200; Set-Param $p 'midfrequency' 'mfgain' 3.0; Set-Param $p 'midfrequency' 'mfq' 1.25
  Set-Param $p 'highmidfrequency' 'hmfactive' 1; Set-Param $p 'highmidfrequency' 'hmffreq' 6700; Set-Param $p 'highmidfrequency' 'hmfgain' 2.0; Set-Param $p 'highmidfrequency' 'hmfq' 1.2
}

# Toms: tighten lows, reduce mud, add attack
$toms = @('High Tom','Mid Tom','Floor Tom 14','Floor Tom 16')
foreach ($tom in $toms) {
  Edit-ProEqPreset (Join-Path $presetsRoot "$tom\1 - Pro EQ.dsppreset") {
    param($p)
    Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 50; Set-Param $p 'lowcut' 'lcslope' 1
    Set-Param $p 'lowfrequency' 'lfactive' 1; Set-Param $p 'lowfrequency' 'lftype' 0; Set-Param $p 'lowfrequency' 'lffreq' 95; Set-Param $p 'lowfrequency' 'lfgain' 1.8; Set-Param $p 'lowfrequency' 'lfq' 1.0
    Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 360; Set-Param $p 'lowmidfrequency' 'lmfgain' -2.8; Set-Param $p 'lowmidfrequency' 'lmfq' 1.4
    Set-Param $p 'midfrequency' 'mfactive' 1; Set-Param $p 'midfrequency' 'mffreq' 4200; Set-Param $p 'midfrequency' 'mfgain' 2.0; Set-Param $p 'midfrequency' 'mfq' 1.15
  }
}

# Overheads: clear low clutter and top harshness
$ohs = @('OH L','OH R')
foreach ($oh in $ohs) {
  Edit-ProEqPreset (Join-Path $presetsRoot "$oh\1 - Pro EQ.dsppreset") {
    param($p)
    Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 180; Set-Param $p 'lowcut' 'lcslope' 2
    Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 380; Set-Param $p 'lowmidfrequency' 'lmfgain' -1.8; Set-Param $p 'lowmidfrequency' 'lmfq' 1.2
    Set-Param $p 'highmidfrequency' 'hmfactive' 1; Set-Param $p 'highmidfrequency' 'hmffreq' 7200; Set-Param $p 'highmidfrequency' 'hmfgain' -2.0; Set-Param $p 'highmidfrequency' 'hmfq' 1.3
    Set-Param $p 'highfrequency' 'hfactive' 1; Set-Param $p 'highfrequency' 'hftype' 1; Set-Param $p 'highfrequency' 'hffreq' 11000; Set-Param $p 'highfrequency' 'hfgain' -1.2; Set-Param $p 'highfrequency' 'hfq' 1.0
  }
}

# Cymbal close channels: remove harshness and low spill
$cymbalFiles = @(
  'Crash\1 - Pro EQ.dsppreset',
  'Crash\1 - Pro EQ(2).dsppreset',
  'Ride\1 - Pro EQ.dsppreset',
  'Ride\1 - Pro EQ(2).dsppreset',
  'China\1 - Pro EQ.dsppreset',
  'HH\1 - Pro EQ.dsppreset'
)
foreach ($rel in $cymbalFiles) {
  Edit-ProEqPreset (Join-Path $presetsRoot $rel) {
    param($p)
    Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 320; Set-Param $p 'lowcut' 'lcslope' 2
    Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 500; Set-Param $p 'lowmidfrequency' 'lmfgain' -2.0; Set-Param $p 'lowmidfrequency' 'lmfq' 1.3
    Set-Param $p 'highmidfrequency' 'hmfactive' 1; Set-Param $p 'highmidfrequency' 'hmffreq' 7600; Set-Param $p 'highmidfrequency' 'hmfgain' -2.6; Set-Param $p 'highmidfrequency' 'hmfq' 1.6
    Set-Param $p 'highfrequency' 'hfactive' 1; Set-Param $p 'highfrequency' 'hftype' 1; Set-Param $p 'highfrequency' 'hffreq' 12000; Set-Param $p 'highfrequency' 'hfgain' -1.0; Set-Param $p 'highfrequency' 'hfq' 1.0
  }
}

# Drum bus: mild glue tone shaping
Edit-ProEqPreset (Join-Path $presetsRoot 'Drum Bus\2 - Pro EQ.dsppreset') {
  param($p)
  Set-Param $p 'lowcut' 'lcactive' 1; Set-Param $p 'lowcut' 'lcfreq' 30; Set-Param $p 'lowcut' 'lcslope' 1
  Set-Param $p 'lowfrequency' 'lfactive' 1; Set-Param $p 'lowfrequency' 'lftype' 0; Set-Param $p 'lowfrequency' 'lffreq' 75; Set-Param $p 'lowfrequency' 'lfgain' 1.5; Set-Param $p 'lowfrequency' 'lfq' 0.9
  Set-Param $p 'lowmidfrequency' 'lmfactive' 1; Set-Param $p 'lowmidfrequency' 'lmffreq' 280; Set-Param $p 'lowmidfrequency' 'lmfgain' -1.8; Set-Param $p 'lowmidfrequency' 'lmfq' 1.2
  Set-Param $p 'midfrequency' 'mfactive' 1; Set-Param $p 'midfrequency' 'mffreq' 3900; Set-Param $p 'midfrequency' 'mfgain' 1.2; Set-Param $p 'midfrequency' 'mfq' 1.1
  Set-Param $p 'highfrequency' 'hfactive' 1; Set-Param $p 'highfrequency' 'hftype' 1; Set-Param $p 'highfrequency' 'hffreq' 10500; Set-Param $p 'highfrequency' 'hfgain' 0.6; Set-Param $p 'highfrequency' 'hfq' 1.0
}

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host "Applied drum EQ tuning to: $SongPath"
Write-Host "Safety snapshot: $backup"
