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

local function write_file_data(conf, log_message)
    local msg, err = core.json.encode(log_message)
    if err then
        return core.log.error("message json serialization failed, error info : ", err)
    end

    local file, err = io_open(conf.path, 'a+')

    if not file then
        core.log.error("failed to open file: ", conf.path, ", error info: ", err)
    else
        local ok, err = file:write(msg, '\n')
        if not ok then
            core.log.error("failed to write file: ", conf.path, ", error info: ", err)
        else
            file:flush()
        end
        file:close()
    end
end

function _M.log(conf, ctx)
    local metadata = plugin.plugin_metadata(plugin_name)
    local entry

    if metadata and metadata.value.log_format
            and core.table.nkeys(metadata.value.log_format) > 0
    then
        entry = log_util.get_custom_format_log(ctx, metadata.value.log_format)
    else
        entry = log_util.get_full_log(ngx, conf)
    end

    write_file_data(conf, entry)
end


return _M
