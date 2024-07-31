@echo off
setlocal

:: Obtener el nombre del usuario actual
set USER=%USERNAME%

ping -n 2 10.10.0.6
ping -n 2 10.10.0.7
ping -n 2 10.10.0.8

echo SONDA 2
ping -n 2 10.10.0.5
ping -n 2 10.10.0.4
ping -n 2 10.10.0.3

:: Configurar el servicio VmwareAutostartService
sc config VmwareAutostartService start=auto
sc config VmwareAutostartService obj= ".\%USER%" password= "1234"

:: Abrir el administrador de servicios
start services.msc

:: Eliminar el archivo START VM - Sonda.bat en la carpeta de inicio
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
del "START VM - Sonda.bat"

::Eliminar archivos anteriores
cd "C:\Virtual Machines"
rmdir /s /q "C:\Virtual Machines\MIA+PROMETHEUS"
del "C:\Virtual Machines\MIA+PROMETHEUS-disk1.vmdk"
del "C:\Virtual Machines\MIA+PROMETHEUS.vmx"

:: Modificar permisos del archivo vmautostart.xml
icacls "C:\ProgramData\VMware\VMware Workstation\vmautostart.xml" /grant "%USER%":(F)

::Ejecucar VMware
"C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"
:: Eliminar el archivo START VM - Sonda.bat en la carpeta de inicio
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
del "START VM - Sonda.bat"

:: Correr el Vmware con permisos de admin
::PowerShell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -Command \"Start-Process \\\"C:\\Program Files (x86)\\VMware\\VMware Workstation\\vmware.exe\\\" -Verb RunAs\"' -Verb RunAs"
"C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"

endlocal
pause