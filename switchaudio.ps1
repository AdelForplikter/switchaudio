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
    # "VXD-G324KP (2- NVIDIA High Definition Audio)",
    # "Smart M70D (NVIDIA High Definition Audio)",
	 "Smart M70D",
     "Headset Earphone"

)

$deviceID = @()
$currentDefault = @()

foreach ($device in $devices) {
	$deviceID += (Get-AudioDevice -List | where-object { $_.Name -Match $device }).id # get the id of the device. Use -Match instead of -eq since device names sometimes changes eg: "Smart M70D (NVIDIA...)","Smart M70D (1- NVIDIA...)"
    $currentDefault += (Get-AudioDevice -List | Where-Object { $_.Name -Match $device }).Default # Get the default status of the device
}

$defaultFound = $false
foreach ($defaultStatus in $currentDefault) {
    if ($defaultStatus -eq "True") { # Find the current default device
        $currentIndex = $currentDefault.IndexOf($defaultStatus)
        $nextIndex = ($currentIndex + 1) % $currentDefault.Count # Wrap around
		Set-AudioDevice -Id $deviceID[$nextIndex] -ErrorAction SilentlyContinue # Set the next device as default. Names and ID's can both change
        $defaultFound = $true
        Write-Output "Old default was $($devices[$currentIndex])"
        Write-Output "Setting to $($devices[$nextIndex])"
    } 
}
if (!$defaultFound) {
        # If none of the $devices were selected, just set the first one in $devices as the current audiodevice. 
        Set-AudioDevice -Id $deviceID[0]
}

# Start-Sleep 5 # Enable if you want to see the output
