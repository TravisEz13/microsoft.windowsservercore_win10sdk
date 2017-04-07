Add-Type -OutputAssembly net.exe -OutputType ConsoleApplication -TypeDefinition @"
class Program 
{
  static void Main(string[] args)
  {
  }
}
"@

Copy-Item C:\Windows\System32\net.exe C:\Windows\System32\net.exe.bak
Copy-Item C:\Windows\SysWOW64\net.exe C:\Windows\SysWOW64\net.exe.bak
$acl1 = Get-Acl C:\Windows\System32\net.exe
$acl11 = Get-Acl C:\Windows\System32\net.exe
$acl2 = Get-Acl C:\Windows\SysWOW64\net.exe
$acl21 = Get-Acl C:\Windows\SysWOW64\net.exe
$permission = 'BUILTIN\Administrators','FullControl','Allow'
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl11.SetAccessRule($accessRule)
Set-Acl C:\Windows\System32\net.exe -AclObject $acl11
$acl21.SetAccessRule($accessRule)
Set-Acl C:\Windows\SysWOW64\net.exe -AclObject $acl21
Copy-Item .\net.exe C:\Windows\System32\net.exe
Copy-Item .\net.exe C:\Windows\SysWOW64\net.exe

Write-Verbose "Installing win10 sdk..." -Verbose
Install-PackageProvider -Name Chocolatey -Force
Install-Package -Name windows-sdk-10.1 -ProviderName Chocolatey -Force

Remove-Item C:\Windows\System32\net.exe
Remove-Item C:\Windows\SysWOW64\net.exe
Rename-Item C:\Windows\System32\net.exe.bak C:\Windows\System32\net.exe
Rename-Item C:\Windows\SysWOW64\net.exe.bak C:\Windows\SysWOW64\net.exe
Set-Acl C:\Windows\System32\net.exe -AclObject $acl1
Set-Acl C:\Windows\SysWOW64\net.exe -AclObject $acl2