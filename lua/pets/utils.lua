local M = {}

-- list all files in a directory
-- source: https://stackoverflow.com/a/11130774
function M.listdir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('/bin/ls -a "' .. directory .. '"')
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

return M
