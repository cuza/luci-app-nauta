# luci-app-nauta

<img width="956" alt="image" src="https://github.com/cuza/luci-app-nauta/assets/10126324/96d0a5df-0814-4f9e-b092-0a34e580a9e7">

Una app de LuCI que contiene un bash script ejecutandose cada minuto mediante un crobjob y garantiza que la conexión a Internet mediate portales captivos de ETECSA siempre se matenga activa.
Olvídate de volver a iniciar sesión y disfruta la tarifa plana de Nauta PLUS!!!

Espero sea de ayuda!!!

## Building
Puede usar el Makefile para compilar localmente el paquete, esta operacion necesita docker instalado, para ello solo basta con correr:

```bash
make luci-app-nauta.ipk
```

## Acknowledgments
 - Agradecimiento especial a **@Magdiel1985** ( [GitHub](https://github.com/Magdiel1985) | [Telegram](https://t.me/mhramos85) ) por [el cron job original](https://github.com/Magdiel1985/login_nauta_etecsa) en el cual se basa este proyecto
