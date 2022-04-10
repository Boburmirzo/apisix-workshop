local core         =   require("apisix.core")
local plugin       =   require("apisix.plugin")
local ngx          =   ngx

local plugin_name = "file-logger"

local schema = {
    type = "object",
    properties = {
        path = {
            type = "string"
        },
    },
    required = {"path"}
}


local _M = {
    version = 1.0,
    priority = 100,
    name = plugin_name,
    schema = schema,
}

function _M.check_schema(conf)
    local ok, err = core.schema.check(schema, conf)
    if not ok then
        return false, err
    end

    return true
end

function _M.log(conf, ctx)
    core.log.warn("conf: ", core.json.encode(conf))
    core.log.warn("ctx: ", core.json.encode(ctx, true))
end


return _M
