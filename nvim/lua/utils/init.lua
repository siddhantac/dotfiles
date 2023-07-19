local M = {}

function M.get_icon(name)
    local nf_ok, nf = pcall(require, "icons.nerd_font")
    if nf_ok then
        return nf[name] .. " "
    else
        local tx_ok, tx = pcall(require, "icons.text")
        if tx_ok then
            return tx[name] .. " "
        end
    end
    return ""
end

return M
