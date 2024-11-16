# https://github.com/frgnca/AudioDeviceCmdlets
#
# Preparation:
# Run as Administrator
# Install-Module -Name AudioDeviceCmdlets
# Edit the array $devices to match your audio devices to switch between. 
#     You can get the names from Get-AudioDevice -List
#
# Useful commands
# Get list of IDs: Get-AudioDevice -List
# Set default device: Set-AudioDevice -Id "ID" -ErrorAction SilentlyContinue

Get-ExecutionPolicy

$devices = @(
    "VXD-G324KP (2- NVIDIA High Definition Audio)",
    "Smart M70D (2- NVIDIA High Definition Audio)",
    "Headset Earphone (HyperX Virtual Surround Sound)"
)

$deviceID = @()
$currentDefault = @()

foreach ($device in $devices) {
    $deviceID += (Get-AudioDevice -List | Where-Object { $_.Name -eq $device }).ID # Get the ID of the device
    $currentDefault += (Get-AudioDevice -List | Where-Object { $_.Name -eq $device }).Default # Get the default status of the device
}

foreach ($defaultStatus in $currentDefault) {
    if ($defaultStatus -eq "true") { # Find the current default device
        $currentIndex = $currentDefault.IndexOf($defaultStatus)
        $nextIndex = ($currentIndex + 1) % $currentDefault.Count # Wrap around
        Set-AudioDevice -Id $deviceID[$nextIndex] -ErrorAction SilentlyContinue # Set the next device as default. Names and ID's can both change
        Write-Output "Old default was $($devices[$currentIndex])"
        Write-Output "Setting to $($devices[$nextIndex])"
    }
}

Start-Sleep 5 # This can be removed if you don't want to see the output
