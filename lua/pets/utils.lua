local M = {}

-- list all files in a directory
-- source: https://stackoverflow.com/a/11130774
function M.listdir(directory, suppress)
    suppress = suppress or false
    local i, t, popen = 0, {}, io.popen
    local pfile
    if suppress then
        pfile = popen('/bin/ls -a "' .. directory .. '" 2>/dev/null')
    else
        pfile = popen('/bin/ls -a "' .. directory .. '"')
    end
    if pfile == nil then
        error("Error getting assets for specified pet")
    end
    for filename in pfile:lines() do
        if filename ~= "." and filename ~= ".." then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

function M.warning(msg)
    vim.notify(msg, vim.log.levels.WARN)
end

return M
