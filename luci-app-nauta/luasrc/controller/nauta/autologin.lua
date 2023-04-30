module("luci.controller.nauta.autologin", package.seeall)

function index()
    entry({"admin", "services", "nauta"}, cbi("nauta/nautalogin"), "Nauta Plus", 30)
end