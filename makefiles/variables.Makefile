LUCI_TITLE:=ETECSA Nauta Plus Auto Login
PKG_NAME:=luci-app-nauta

PKG_LICENSE:=MIT License
PKG_MAINTAINER:=Dave Cuza <dave@cuza.dev>
PKG_VERSION:=v0.0.24

LUCI_DEPENDS:=@(aarch64||arm||i386||mips||mipsel||x86_64) +luci-compat +bash +curl
LUCI_PKGARCH:=all