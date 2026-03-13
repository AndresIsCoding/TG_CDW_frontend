@echo off
setlocal
:: CONFIGURACION
set BRANCH=main
set PROJECT_DIR=C:\Users\Usuario\Documents\GitHub\TG_CDW_frontend
set INTERVAL=300
    
:loop
echo [%date% %time%] Revisando si hay cambios en Git...
cd /d "%PROJECT_DIR%"
   
:: 1. Traer informacion de los cambios (sin descargar aun)
git fetch origin %BRANCH%
   
:: 2. Comparar si la version local es distinta a la del servidor
FOR /F "tokens=*" %%i IN ('git rev-list HEAD..origin/%BRANCH% --count') DO SET CHANGES=%%i       
   
IF %CHANGES% GTR 0 (
     echo [!] Nuevos cambios detectados (%CHANGES% commits). Iniciando actualizacion...
   
     :: 3. Descargar los cambios
     git pull origin %BRANCH%
   
     :: 4. Llamar a tu script de rebuild que ya tienes listo
     call deploy\rebuild-and-restart.bat
   
     echo [%date% %time%] Actualizacion terminada con exito.
    ) ELSE (
       echo [.] El proyecto ya esta al dia.
    )
   
:: Esperar X segundos antes de volver a revisar (300 segundos = 5 minutos)
echo Esperando %INTERVAL% segundos para la proxima revision...
timeout /t %INTERVAL%
goto loop