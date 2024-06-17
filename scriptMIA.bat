@echo off
setlocal

:: Obtener el nombre del usuario actual
set USER=%USERNAME%

:: Configurar el servicio VmwareAutostartService
sc config VmwareAutostartService start=auto
sc config VmwareAutostartService obj= ".\%USER%" password= "1234"

:: Abrir el administrador de servicios
start services.msc

:: Modificar permisos del archivo vmautostart.xml
icacls "C:\ProgramData\VMware\VMware Workstation\vmautostart.xml" /grant %USER%:(F)

:: Eliminar el archivo START VM - Sonda.bat en la carpeta de inicio
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
del "START VM - Sonda.bat"

endlocal
pause