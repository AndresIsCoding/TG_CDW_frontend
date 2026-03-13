@echo off
echo [1/4] Limpiando archivos temporales para ahorrar espacio...
call flutter clean

echo [2/4] Descargando ultimas dependencias...
call flutter pub get
    
echo [3/4] Generando build de produccion (Web)...
call flutter build web --release --strip-res-info
   
echo [4/4] Reiniciando el servicio en Servy...
:: Si el servicio se llama "TraumaRegister", usamos comandos de Windows:
net stop "InvTraumaFrontend"
net start "InvTraumaFrontend"

echo ¡Despliegue completado con exito!
pause