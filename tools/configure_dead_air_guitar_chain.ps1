param(
  [string]$SongPath = 'C:\Users\aaron\OneDrive\Documents\Studio One\Songs\Fat Man\Dead Air\Dead Air.song'
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = "$SongPath.guitar-chain-pre-$stamp"
Copy-Item $SongPath $backup -Force

$tmp = Join-Path $env:TEMP ('deadair_guitar_chain_' + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmp | Out-Null

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($SongPath, $tmp)

$mxPath = Join-Path $tmp 'Devices\audiomixer.xml'
$mx = Get-Content $mxPath -Raw

if ($mx -notmatch '<AudioMixer\s+xmlns:x=') {
  $mx = [regex]::Replace($mx, '<AudioMixer>', '<AudioMixer xmlns:x="http://www.w3.org/2001/XMLSchema-instance">', 1)
}

$guitarDir = Join-Path $tmp 'Presets\Channels\Guitar'
New-Item -ItemType Directory -Path $guitarDir -Force | Out-Null

# Guitar Pro EQ preset
$eqObj = [ordered]@{
  cid = '{D9AE9ACD-69B4-4B43-B8D5-983E39C559A5}'
  classname = 'Pro EQ'
  parameters = [ordered]@{
    lowcut = [ordered]@{ lcfreq = 75.0; lcslope = 1.0; lcactive = 1.0 }
    lowfrequency = [ordered]@{ lfgain = 0.0; lffreq = 110.0; lfq = 1.0; lftype = 0.0; lfactive = 0.0 }
    lowmidfrequency = [ordered]@{ lmffreq = 295.821655273438; lmfgain = -2.40000152587891; lmfq = 1.22472655773163; lmfactive = 1.0 }
    midfrequency = [ordered]@{ mffreq = 1552.49438476562; mfgain = 0.959999084472656; mfq = 0.70710700750351; mfactive = 1.0 }
    highmidfrequency = [ordered]@{ hmffreq = 3810.91748046875; hmfgain = -1.44000053405762; hmfq = 2.0011568069458; hmfactive = 1.0 }
    highfrequency = [ordered]@{ hffreq = 10999.9990234375; hfgain = 0.0; hfq = 1.0; hftype = 1.0; hfactive = 0.0 }
  }
}
$eqObj | ConvertTo-Json -Depth 25 | Set-Content -Path (Join-Path $guitarDir '1 - Pro EQ.dsppreset') -Encoding UTF8

# Guitar Compressor preset
$compXml = @'
<?xml version="1.0" encoding="UTF-8"?>
<AudioEffectPreset cid="{54F19B72-352C-4AA5-A2AF-67F86F30D6BE}" version="1" algorithmVersion="1">
  <Attributes x:id="ParameterData" linked="1" lookAhead="1" resetmin="0" mix="1" ratio="0.75" threshold="-20.159999847412109375" knee="6" auto="0" gain="0" ingain="1.69044077396392822265625" autospeed="0" attack="0.015000001527369022369384765625" release="0.082148082554340362548828125" adaptive="0" internalsidechain="0" sidechainlisten="0" sidechainfreqlow="20" sidechainfreqhigh="16000" swapfreqs="0"/>
</AudioEffectPreset>
'@
Set-Content -Path (Join-Path $guitarDir '2 - Compressor.fxpreset') -Value $compXml -Encoding UTF8

# Guitar RedlightDist preset
$distXml = @'
<?xml version="1.0" encoding="UTF-8"?>
<AudioEffectPreset cid="{EB8C4ED5-615C-44EA-8F93-757181647AC8}" version="1" algorithmVersion="0">
  <Attributes x:id="ParameterData" type="0" stages="1" ingain="1.25863564014434814453125" bias="1.7599999904632568359375" drive="1.99580037593841552734375" outgain="1" low="20" high="16000" mix="0.15"/>
</AudioEffectPreset>
'@
Set-Content -Path (Join-Path $guitarDir '3 - RedlightDist.fxpreset') -Value $distXml -Encoding UTF8

$gMatch = [regex]::Match($mx, '(?is)<AudioTrackChannel\b[^>]*label="Guitar"[\s\S]*?</AudioTrackChannel>')
if (-not $gMatch.Success) {
  throw 'Guitar channel block not found in audiomixer.xml'
}

$g = $gMatch.Value

$g = [regex]::Replace($g, '(?is)(<AudioTrackChannel\b[^>]*?)mute="[01]"\s+solo="[0-9]+"\s+soloSafe="[01]"', '$1mute="0" solo="0" soloSafe="1"', 1)
$g = [regex]::Replace($g, '(?is)(<Attributes x:id="data"\s+)recordArmed="[01]"\s+monitorActive="[01]"', '$1recordArmed="1" monitorActive="1"', 1)

$insertsBlock = @'
<Attributes x:id="Inserts">
                                        <Attributes name="FX01">
                                                <UID x:id="uniqueID" uid="{BEBB59D0-586C-477C-AE1B-9ED6801A432E}"/>
                                                <UID x:id="deviceClassID" uid="{D9AE9ACD-69B4-4B43-B8D5-983E39C559A5}"/>
                                                <Attributes x:id="deviceData" name="Pro EQ">
                                                        <UID x:id="uniqueID" uid="{C945FE61-FC85-418D-9E28-8EA7252D43BE}"/>
                                                </Attributes>
                                                <Attributes x:id="ghostData" presetType="dsppreset">
                                                        <Attributes x:id="classInfo" classID="{D9AE9ACD-69B4-4B43-B8D5-983E39C559A5}" name="Pro EQ" category="AudioEffect" subCategory="(Native)/EQ"/>
                                                        <Attributes x:id="IO">
                                                                <List x:id="audioInputs">
                                                                        <PortDescription subType="1" label="Input"/>
                                                                        <PortDescription type="1" subType="1" label="SC"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription subType="1" label="Output"/>
                                                                </List>
                                                        </Attributes>
                                                </Attributes>
                                                <Attributes x:id="Presets" pname="default" dirty="1">
                                                        <Attributes x:id="url" type="1" url="file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Pro EQ/default.preset"/>
                                                </Attributes>
                                                <String x:id="presetPath" text="Presets/Channels/Guitar/1 - Pro EQ.dsppreset"/>
                                        </Attributes>
                                        <Attributes name="FX02">
                                                <UID x:id="uniqueID" uid="{2F0AB86A-CE5E-43D8-AE73-ADE4C9B06C7E}"/>
                                                <UID x:id="deviceClassID" uid="{54F19B72-352C-4AA5-A2AF-67F86F30D6BE}"/>
                                                <Attributes x:id="deviceData" name="Compressor">
                                                        <UID x:id="uniqueID" uid="{48AD47B9-A040-4EA5-B78C-93DA46CA9D33}"/>
                                                </Attributes>
                                                <Attributes x:id="ghostData" presetType="fxpreset">
                                                        <Attributes x:id="classInfo" classID="{54F19B72-352C-4AA5-A2AF-67F86F30D6BE}" name="Compressor" category="AudioEffect" subCategory="(Native)/Dynamics"/>
                                                        <Attributes x:id="IO">
                                                                <List x:id="audioInputs">
                                                                        <PortDescription flags="3" subType="1" label="Input"/>
                                                                        <PortDescription type="1" subType="1" label="SC"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription flags="3" subType="1" label="Output"/>
                                                                </List>
                                                        </Attributes>
                                                </Attributes>
                                                <Attributes x:id="Presets" pname="default" dirty="1">
                                                        <Attributes x:id="url" type="1" url="file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/Compressor/default.preset"/>
                                                </Attributes>
                                                <String x:id="presetPath" text="Presets/Channels/Guitar/2 - Compressor.fxpreset"/>
                                        </Attributes>
                                        <Attributes name="FX03">
                                                <UID x:id="uniqueID" uid="{4B04FB70-6975-4A8F-866E-1B692EFBF261}"/>
                                                <UID x:id="deviceClassID" uid="{EB8C4ED5-615C-44EA-8F93-757181647AC8}"/>
                                                <Attributes x:id="deviceData" name="RedlightDist">
                                                        <UID x:id="uniqueID" uid="{22840DE1-D9A7-4E82-8C14-C2C01D20E0F7}"/>
                                                </Attributes>
                                                <Attributes x:id="ghostData" presetType="fxpreset">
                                                        <Attributes x:id="classInfo" classID="{EB8C4ED5-615C-44EA-8F93-757181647AC8}" name="RedlightDist" category="AudioEffect" subCategory="(Native)/Distortion"/>
                                                        <Attributes x:id="IO">
                                                                <List x:id="audioInputs">
                                                                        <PortDescription flags="3" subType="1" label="Input"/>
                                                                </List>
                                                                <List x:id="audioOutputs">
                                                                        <PortDescription flags="3" subType="1" label="Output"/>
                                                                </List>
                                                        </Attributes>
                                                </Attributes>
                                                <Attributes x:id="Presets" pname="default" dirty="1">
                                                        <Attributes x:id="url" type="1" url="file:///C:/Program Files/Fender/Studio Pro 8/Presets/Fender/RedlightDist/default.preset"/>
                                                </Attributes>
                                                <String x:id="presetPath" text="Presets/Channels/Guitar/3 - RedlightDist.fxpreset"/>
                                        </Attributes>
                                        <Attributes x:id="Presets" pname="Fat Channel" dirty="0">
                                                <Attributes x:id="url" type="1" url="file:///C:/Program Files/PreSonus/Studio One 7/Presets/PreSonus/FX Chains/Mixing/Fat Channel.multipreset"/>
                                        </Attributes>
                                        <Attributes x:id="Combinator" name="Combinator">
                                                <UID x:id="uniqueID" uid="{69999FBB-B10E-4584-9939-8074EE833F89}"/>
                                        </Attributes>
                                </Attributes>
'@

$g = [regex]::Replace($g, '(?is)<Attributes x:id="Inserts">[\s\S]*?</Attributes>\s*(?=<Attributes x:id="Panner")', $insertsBlock, 1)

$mx = $mx.Substring(0, $gMatch.Index) + $g + $mx.Substring($gMatch.Index + $gMatch.Length)
Set-Content -Path $mxPath -Value $mx -Encoding UTF8

Remove-Item $SongPath -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tmp, $SongPath)
Remove-Item -Recurse -Force $tmp

Write-Host 'Configured Guitar chain in live song.'
Write-Host "Safety snapshot: $backup"