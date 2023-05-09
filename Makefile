include $(TOPDIR)/rules.mk

LUCI_TITLE:=ETECSA Nauta Plus Auto Login
PKG_NAME:=luci-app-nauta

PKG_LICENSE:=MIT License
PKG_MAINTAINER:=Dave Cuza <dave@cuza.dev>
PKG_VERSION:=v0.0.19

include $(TOPDIR)/feeds/luci/luci.mk

LUCI_DEPENDS:=@(aarch64||arm||i386||mips||mipsel||x86_64) +luci-compat +bash +curl
LUCI_PKGARCH:=all

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
/usr/bin/killall nauta_login
endef

$(eval $(call BuildPackage,luci-app-nauta))