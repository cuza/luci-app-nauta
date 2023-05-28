include $(TOPDIR)/rules.mk

include $(TOPDIR)/feeds/luci/luci.mk

include makefiles/variables.Makefile

define Package/$(PKG_NAME)/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -e "/etc/config/etecsa" ]; then
  echo "ETECSA config exists"
else
  echo "config service 'nauta'" > /etc/config/etecsa
fi
chmod +x /usr/bin/nauta_login
(crontab -l ; echo "* * * * * /usr/bin/nauta_login 2>&1 | /usr/bin/logger -t nauta_login") | sort | uniq | crontab -
/etc/init.d/cron restart
/etc/init.d/cron enable
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
(crontab -l ; echo "* * * * * /usr/bin/nauta_login 2>&1 | /usr/bin/logger -t nauta_login") | grep -v nauta_login | sort | uniq | crontab -
/etc/init.d/cron restart
/usr/bin/killall nauta_login || true
endef

$(eval $(call BuildPackage,luci-app-nauta))