# valid key names can be ASCII codes:
while ($true)
{
    $key = 175  #VolumeUp   
    
$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@

# Add-Type compiles the source code and adds the type [PsOneApi.Keyboard]:
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
    
Write-Host "Press VolumeUp Key to Lock the computer!"
##Start-Sleep -Seconds 3

# the public static method GetAsyncKeyState() is now availabe from
# within PowerShell and tests whether the key is pressed.
# Actually, one bit is reporting whether the key is pressed,
# and the result is always either 0 or 1, which can easily
# be converted to bool:
$flag = $true
while ($flag)
{
$result = [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($key) -eq -32767)
if ($result)
    {
    $flag = $false
    $result = $true
    Write-Host "Found key - Start locking computer"
    } 
}
if ( $result )
{
    Write-Host "Found key - Start locking computer"
    Write-Output "Locking screen in 5 seconds"
    Start-Sleep -Seconds 5
    $lockscreen = $(rundll32.exe user32.dll, LockWorkStation)
    $lockscreen
    $PlayWav=New-Object System.Media.SoundPlayer
    $PlayWav.SoundLocation=’C:\Sound\CarLock.wav'
    $PlayWav.playsync()
  }
}
