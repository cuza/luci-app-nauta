# login_nauta_etecsa

Este bash script permite correrlo mediante un crobjob dentro de su ordenador Linux o dentro de un router con OpenWRT y garantiza que la conexión a Internet con etecsa siempre se matenga activa.
Es reomendado ejecutarlo cada 1 minuto.
Olvídate de volver a iniciar sesión y disfruta la tarifa plana de NAUTAPLUS!!!

Es importante darle permiso de ejecución al script una vez ubicado dentro de su equipo: `chmod +x login.sh`

En el ejemplo el archivo fue colocado en la carpeta /etc/crontabs/ .El cronjob pudiese ser configurado para ejecutarse cada 1 minuto: 

```shell
* * * * * NOMBRE_USUARIO="usuario@nautaplus" PASSWORD="su_password" /etc/crontabs/login.sh
```

Si el script detecta que hay enlace con etecsa (responde secure.etecsa.net) pero luego de postear el usuario/contraseña, no detecta internet (no responde 8.8.8.8) entonces, detiene el servicio de cronjobs. 

Este ejemplo es para ser utilizando dentro de un router con OpenWRT. Pero puede funcionar en calquier ambiente Linux, ajustando apropiadamente el comando para detener el servicio de cronjobs.

Espero sea ayuda!!! 

Mi Telegram: @mhramos85
