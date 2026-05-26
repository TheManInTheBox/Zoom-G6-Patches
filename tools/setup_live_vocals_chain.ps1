param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$tmp = Join-Path $env:TEMP ('deadair_vocals_chain_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$root = Join-Path $tmp 'Presets\Channels\Vocals'
New-Item -ItemType Directory -Path $root -Force | Out-Null

# Write tuned preset payloads expected by the inserts.
@'
<?xml version="1.0" encoding="UTF-8"?>
<AudioEffectPreset cid="{54F19B72-352C-4AA5-A2AF-67F86F30D6BE}" version="1" algorithmVersion="1">
        <Attributes x:id="ParameterData" linked="0" lookAhead="0" resetmin="0" mix="1" ratio="0.56"
                    threshold="-20.0" knee="10" auto="0" gain="6.0"
                    ingain="1" autospeed="0" attack="0.008"
                    release="0.090" adaptive="1" internalsidechain="0" sidechainlisten="0" sidechainfreqlow="20"
                    sidechainfreqhigh="12000" swapfreqs="0"/>
</AudioEffectPreset>
'@ | Set-Content -Path (Join-Path $root '1 - Compressor.fxpreset') -Encoding UTF8

@'
{
  "cid": "{D9AE9ACD-69B4-4B43-B8D5-983E39C559A5}",
  "classname": "Pro EQ",
  "parameters": {
    "linearlowcut": {"linearphasesoft": 0.0, "linearphasefreq": 2.0, "linearphaseactive": 0.0},
    "lowcut": {"lcfreq": 85.0, "lcslope": 1.0, "lcactive": 1.0},
    "lowfrequency": {"lfgain": -3.0, "lffreq": 120.0, "lfq": 2.0, "lftype": 1.0, "lfactive": 1.0, "lfsolo": 0.0, "lfdynamic": 0.0, "lfdynthreshold": 0.0, "lfdynrange": 0.0},
    "lowmidfrequency": {"lmfgain": -2.4, "lmffreq": 340.0, "lmfq": 1.4, "lmfactive": 1.0, "lmfsolo": 0.0, "lmfdynamic": 0.0, "lmfdynthreshold": 0.0, "lmfdynrange": 0.0},
    "midfrequency": {"mfgain": 2.2, "mffreq": 2800.0, "mfq": 1.6, "mfactive": 1.0, "mfsolo": 0.0, "mfdynamic": 0.0, "mfdynthreshold": 0.0, "mfdynrange": 0.0},
    "highmidfrequency": {"hmfgain": 1.2, "hmffreq": 5200.0, "hmfq": 1.8, "hmfactive": 1.0, "hmfsolo": 0.0, "hmfdynamic": 0.0, "hmfdynthreshold": 0.0, "hmfdynrange": 0.0},
    "highfrequency": {"hfgain": 2.0, "hffreq": 10500.0, "hfq": 1.0, "hftype": 1.0, "hfactive": 1.0, "hfsolo": 0.0, "hfdynamic": 0.0, "hfdynthreshold": 0.0, "hfdynrange": 0.0},
    "highcut": {"hcfreq": 20000.0, "hcslope": 0.0, "hcactive": 0.0},
    "gain": {"gain": 0.0, "autogain": 0.0, "highqual": 1.0},
    "opt": {"viewmode": 1.0, "showControls": 1.0, "showDynamics": 0.0, "solo": 0.0},
    "ui": {"showfft": 2.0, "analyzerRangeMin": 3.0, "analyzerRangeMax": 2.0, "sidehold": 0.0, "displayRange": 2.0}
  },
  "component": {"autogaincomponent": {"legacyAutoGain": 0}}
}
'@ | Set-Content -Path (Join-Path $root '2 - Pro EQ.dsppreset') -Encoding UTF8

@'
<?xml version="1.0" encoding="UTF-8"?>
<AudioEffectPreset cid="{29C71194-B29A-40C0-9A35-9053DB6F596C}" version="1" algorithmVersion="0">
        <Attributes x:id="ParameterData" perfmode="0" roomsize="2.50" roomwidth="0.80"
                    roomheight="0.80" distance="0.14" asymmetry="0.00" plane="0"
                    predelayoffset="-0.08" lengthoffset="-0.45" roomtype="0" population="0.46"
                    smoothness="0.49" damping="0.25" erlrbalance="0.29" mix="0.16"/>
        <Attributes x:id="ComponentData" isLockMix="0"/>
</AudioEffectPreset>
'@ | Set-Content -Path (Join-Path $root '3 - Room Reverb.fxpreset') -Encoding UTF8

@'
{
  "cid": "{9F3AF9D1-3820-46CF-A675-2F382D6D334E}",
  "classname": "Voice FX",
  "parameters": {
    "voicefx": {
      "on": 0.0,
      "detune": 0.0,
      "mix": 0.0,
      "__classid": "{E857B5E3-C40B-47C5-B180-C13ADB24D20D}"
    }
  }
}
'@ | Set-Content -Path (Join-Path $root '4 - Voice FX.dsppreset') -Encoding UTF8

function NewUid {
  '{' + [guid]::NewGuid().ToString().ToUpperInvariant() + '}'
}

function NewInsert([int]$index,[string]$name,[string]$classId,[string]$presetType,[string]$category,[string]$subCategory,[string]$url,[string]$presetPath,[string]$ioBlock) {
@"
                                        <Attributes name="FX$('{0:D2}' -f $index)">
                                                <UID x:id="uniqueID" uid="$(NewUid)"/>
                                                <UID x:id="deviceClassID" uid="$classId"/>
                                                <Attributes x:id="deviceData" name="$name">
                                                        <UID x:id="uniqueID" uid="$(NewUid)"/>
                                                </Attributes>
                                                <Attributes x:id="ghostData" presetType="$presetType">
                                                        <Attributes x:id="classInfo" classID="$classId" name="$name"
                                                                    category="AudioEffect" subCategory="$subCategory"/>
                                                        <Attributes x:id="IO">
$ioBlock
                                                        </Attributes>
                                                </Attributes>
                                                <Attributes x:id="Presets" pname="default" dirty="1">
                                                        <Attributes x:id="url" type="1" url="$url"/>
                                                </Attributes>
                                                <String x:id="presetPath" text="$presetPath"/>
                                        </Attributes>
"@
}

$ioComp = @"
                                                                <List x:id="audioInputs">
                                                                        <PortDescription flags="3" subType="1" label="Input"/>
                                                                        <PortDescription type="1" subType="1" label="SC"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription flags="3" subType="1" label="Output"/>
                                                                </List>
"@

$ioEq = @"
                                                                <List x:id="audioInputs">
                                                                        <PortDescription subType="1" label="Input"/>
                                                                        <PortDescription type="1" subType="1" label="SC"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription subType="1" label="Output"/>
                                                                </List>
"@

$ioSimple = @"
                                                                <List x:id="audioInputs">
                                                                        <PortDescription flags="3" subType="1" label="Input"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription flags="3" subType="1" label="Output"/>
                                                                </List>
"@

$insertPayload = (
  (NewInsert 1 'Compressor' '{54F19B72-352C-4AA5-A2AF-67F86F30D6BE}' 'fxpreset' 'AudioEffect' '(Native)/Dynamics' 'file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Compressor/default.preset' 'Presets/Channels/Vocals/1 - Compressor.fxpreset' $ioComp) +
  (NewInsert 2 'Pro EQ' '{D9AE9ACD-69B4-4B43-B8D5-983E39C559A5}' 'dsppreset' 'AudioEffect' '(Native)/EQ' 'file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Pro EQ/default.preset' 'Presets/Channels/Vocals/2 - Pro EQ.dsppreset' $ioEq) +
  (NewInsert 3 'Room Reverb' '{29C71194-B29A-40C0-9A35-9053DB6F596C}' 'fxpreset' 'AudioEffect' '(Native)/Reverb' 'file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Room Reverb/default.preset' 'Presets/Channels/Vocals/3 - Room Reverb.fxpreset' $ioSimple) +
  (NewInsert 4 'Voice FX' '{9F3AF9D1-3820-46CF-A675-2F382D6D334E}' 'dsppreset' 'AudioEffect' '(Native)/Pitch' 'file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Voice FX/default.preset' 'Presets/Channels/Vocals/4 - Voice FX.dsppreset' $ioSimple)
)

$newInsertsBlock = @"
                                <Attributes x:id="Inserts">
$insertPayload                                        <Attributes x:id="Presets" pname="default" dirty="0"/>
                                        <Attributes x:id="Combinator" name="Combinator">
                                                <UID x:id="uniqueID" uid="$(NewUid)"/>
                                        </Attributes>
                                </Attributes>
"@

$mxPath = Join-Path $tmp 'Devices\audiomixer.xml'
$mx = Get-Content $mxPath -Raw
$chanMatch = [regex]::Match($mx, '(?is)<AudioTrackChannel\b[^>]*label="Vocals".*?</AudioTrackChannel>')
if (-not $chanMatch.Success) {
  throw 'Vocals channel not found in audiomixer.xml'
}

$chan = $chanMatch.Value
$insertsMatch = [regex]::Match($chan, '(?is)<Attributes\s+x:id="Inserts">.*?</Attributes>\s*')
if (-not $insertsMatch.Success) {
  throw 'Inserts block not found in Vocals channel'
}

$chan = $chan.Replace($insertsMatch.Value, $newInsertsBlock)

# Normalize active vocal channel gain near unity +0.5 dB.
$targetGain = [math]::Pow(10, 0.5 / 20.0).ToString('R', [Globalization.CultureInfo]::InvariantCulture)
$chan = [regex]::Replace($chan, '(?is)(<AudioTrackChannel\b[^>]*?)gain="[^"]*"', ('$1gain="' + $targetGain + '"'), 1)

$mx = $mx.Substring(0, $chanMatch.Index) + $chan + $mx.Substring($chanMatch.Index + $chanMatch.Length)
Set-Content -Path $mxPath -Value $mx -Encoding UTF8

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host 'Live song vocals chain rebuilt.'
