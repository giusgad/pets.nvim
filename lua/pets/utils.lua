local M = {}
M.available_pets = {}

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

local wd = debug.getinfo(1).source:sub(2):match("(.*nvim/)") .. "media/"
for _, pet in pairs(M.listdir(wd)) do
    local styles = M.listdir(wd .. pet)
    M.available_pets[pet] = styles
end

function M.validate_type_style(pet, style)
    if M.available_pets[pet] == nil then
        M.warning('The pet "' .. pet .. '" does not exist')
        return false
    end
    if not vim.tbl_contains(M.available_pets[pet], style) then
        M.warning('The style "' .. style .. '" for "' .. pet .. '" does not exist')
        return false
    end
    return true
end

function M.complete_typestyle(_, cmdline)
    local matches = {}
    local words = vim.split(cmdline, " ", { trimempty = true })

    if not vim.endswith(cmdline, " ") then
        table.remove(words, #words)
    end

    if #words == 1 then
        for k, _ in pairs(M.available_pets) do
            table.insert(matches, k)
        end
    elseif #words == 2 then
        local styles = M.available_pets[words[2]]
        if styles == nil then
            return {}
        end
        for _, v in pairs(styles) do
            table.insert(matches, v)
        end
    end
    return matches
end

function M.complete_name()
    local matches = {}
    for k, _ in pairs(require("pets").pets) do
        table.insert(matches, k)
    end
    return matches
end

function M.warning(msg)
    vim.notify(msg, vim.log.levels.WARN)
end

function M.parse_popup_hl(highlight)
    return table.concat(
        vim.tbl_map(function(key)
            return key .. ":" .. highlight[key]
        end, vim.tbl_keys(highlight)),
        ","
    )
end

return M
