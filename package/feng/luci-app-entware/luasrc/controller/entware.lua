
module("luci.controller.entware", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/entware") then
		return
	end

	local page
	page = entry({"admin", "services", "entware"}, cbi("entware"), _("entware"), 199)
	page.i18n = "entware"
	page.dependent = true
end
