local fs = require "nixio.fs"
local util = require "nixio.util"

local ariarun=(luci.sys.call("pidof aria2c> /dev/null") == 0)
local qBittorrentrun=(luci.sys.call("pidof qbittorrent-nox > /dev/null") == 0)
local verysyncrun =(luci.sys.call("pidof verysync > /dev/null") == 0)
local button=""

if verysyncrun then
	statusverysyncrun =  translate("<strong><font color=\"green\">verysync 运行中</font></strong>")
else
	statusverysyncrun = translate("<strong><font color=\"red\">verysync 未运行</font></strong>")
end

if qBittorrentrun then
	statusqBittorrentrun =  translate("<strong><font color=\"green\">qBittorrent 运行中</font></strong>")	
else
	statusqBittorrentrun = translate("<strong><font color=\"red\">qBittorrent 未运行</font></strong>")
end

m = Map("entware", translate("entware"))

s = m:section(TypedSection, "entware","entware 设置")
s.anonymous = true
s:tab("basic",  translate("设置"))

enable = s:taboption("basic", Flag, "enable", "启用 entware")
enable.rmempty = false

path = s:taboption("basic", Value, "path", "安装位置")
path.placeholder = "/mnt/sda1"
path.default     = "/mnt/sda1"
path.rmempty     = false

verysync = s:taboption("basic", Flag, "verysync", "启用微力同步",statusverysyncrun)
verysync.rmempty = false
verysyncpath = s:taboption("basic", Value, "verysyncpath", "微力同步程序路径")
verysyncpath.placeholder = "/mnt/sda1"
verysyncpath.default     = "/mnt/sda1"
verysyncpath.rmempty     = false

qBittorrent = s:taboption("basic", Flag, "qBittorrent", "启用qBittorrent",statusqBittorrentrun)
qBittorrent.rmempty = false

swap = s:taboption("basic", Flag, "swap", "启用swap")
swap.rmempty = false

e=s:taboption("basic",Button,"update")
e.inputtitle=translate("update")
e.inputstyle="reload"
e.write = function()
  luci.sys.call("opkg update > /tmp/entware.log")
  luci.http.redirect(luci.dispatcher.build_url("admin", "services", "entware"))
end

e=s:taboption("basic",TextValue,"log")
e.rows=26
e.wrap="off"
e.readonly=true
e.cfgvalue = function()
	return luci.sys.exec("cat /tmp/verysync.log")
end


return m
