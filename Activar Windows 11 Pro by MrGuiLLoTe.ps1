# Comprueba si el usuario actual es un administrador elevado
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Si el usuario no es un administrador elevado, relanza el script con privilegios elevados
if (-not $isAdmin)
{
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Verificar la configuración actual de la directiva de ejecución
Get-ExecutionPolicy

# Establecer la directiva de ejecución en RemoteSigned
Set-ExecutionPolicy RemoteSigned -Force '-Command', 
'slmgr.vbs -upk'

# Establecer la directiva de ejecución en Unrestricted para permitir la ejecución de scripts 
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force '-Command', 
'slmgr.vbs -upk'

Start-Process powershell.exe -Verb runAs -ArgumentList '-Command', 
'slmgr.vbs -upk'

Start-Process powershell.exe -Verb runAs -ArgumentList '-Command',
'slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX' -Wait

Start-Process powershell.exe -Verb runAs -ArgumentList '-Command',
'slmgr /skms kms.digiboy.ir' -Wait

Start-Process powershell.exe -Verb runAs -ArgumentList '-Command',
'slmgr /ato' -Wait

Set-ExecutionPolicy Restricted
