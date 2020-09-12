local crel = require("CREL.crel")

local function onInitialized()
	crel.initializeFramework()
end

event.register("initialized", onInitialized)