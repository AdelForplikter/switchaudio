# Powershell script to switch between audio outputs. 

## Description
Powershell script to change audio output based on name of the outut device and the cmdlet "AudioDeviceCmdlets"
The script can then be called via autohotkey or similar programs. I mainly use it to switch between audiodevices with one key on a macropad. 

## Flow
<b>Macropad</b> -> via macropad software, creating key combination shift+ctrl+j -> <b>autohotkey</b> when recieving shift+ctrl+j runs <b>powershell</b> script -> <b>switchaudio.ps1</b>
