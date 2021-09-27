local module = {}
local lfs = require "lfs"
local toml = require "toml"

module._VERSION = "0.1"

function module.init(root, sites)
	for name in lfs.dir(root) do
		if name:sub(-5) == ".toml" then
			local confFile = io.open(root .. name)
			local conf = toml.parse(confFile:read("*a"))
			confFile:close()
			local domain = conf.site:match('^([^:]+)')
			ngx.log(ngx.INFO, "domain: " .. domain .. " > " .. conf.listen)
			sites:set(domain, conf.listen)
		end
	end
end

return module
