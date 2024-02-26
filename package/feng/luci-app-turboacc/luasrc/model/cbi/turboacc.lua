local kernel_version = luci.sys.exec("echo -n $(uname -r)")

m = Map("turboacc")
m.title	= translate("Turbo ACC Acceleration Settings")
m.description = translate("Opensource Flow Offloading driver (Fast Path or Hardware NAT)")

m:append(Template("turboacc/turboacc_status"))

s = m:section(TypedSection, "turboacc", "")
s.addremove = false
s.anonymous = true


if nixio.fs.access("/lib/modules/" .. kernel_version .. "/tcp_bbr.ko") then
bbr_cca = s:option(Flag, "bbr_cca", translate("BBR CCA"))
bbr_cca.default = 0
bbr_cca.description = translate("Using BBR CCA can improve TCP network performance effectively")
end

fullcone_nat = s:option(ListValue, "fullcone_nat", translate("FullCone NAT"))
fullcone_nat.default = 0
fullcone_nat:value("0", translate("Disable"))
fullcone_nat:value("1", translate("Compatible Mode"))
fullcone_nat:value("2", translate("High Performing Mode"))
fullcone_nat.description = translate("Using FullCone NAT can improve gaming performance effectively")

if nixio.fs.access("/usr/sbin/pdnsd") or nixio.fs.access("/usr/bin/dnsforwarder") or nixio.fs.access("/usr/bin/dnsproxy") then
dns_caching = s:option(Flag, "dns_caching", translate("DNS Caching"))
dns_caching.default = 0
dns_caching.rmempty = false
dns_caching.description = translate("Enable DNS Caching and anti ISP DNS pollution")
end

dns_caching_mode = s:option(ListValue, "dns_caching_mode", translate("Resolve DNS Mode"), translate("DNS Program"))
if nixio.fs.access("/usr/sbin/pdnsd") then
dns_caching_mode:value("1", translate("Using PDNSD to query and cache"))
end
if nixio.fs.access("/usr/bin/dnsforwarder") then
dns_caching_mode:value("2", translate("Using DNSForwarder to query and cache"))
end
if nixio.fs.access("/usr/bin/dnsproxy") then
dns_caching_mode:value("3", translate("Using DNSProxy to query and cache"))
end
dns_caching_mode.default = 1
dns_caching_mode:depends("dns_caching", 1)

dns_caching_dns = s:option(Value, "dns_caching_dns", translate("Upsteam DNS Server"))
dns_caching_dns.default = "114.114.114.114,114.114.115.115,223.5.5.5,223.6.6.6,180.76.76.76,119.29.29.29,119.28.28.28,1.2.4.8,210.2.4.8"
dns_caching_dns.description = translate("Muitiple DNS server can saperate with ','")
dns_caching_dns:depends("dns_caching", 1)

return m