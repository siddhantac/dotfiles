local sessions = require('mini.sessions')
sessions.setup()

local starter = require('mini.starter')
starter.setup({
    footer = '',
    items = {
        starter.sections.sessions(5, true),
        starter.sections.telescope(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
})

local splitstr = function (inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local result={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(result, str)
   end
   return result
end

MiniSessionWrite = function()
    local cwd = vim.fn.getcwd()
    local parts = splitstr(cwd, "/")

    -- use the last directory name in the path
    -- as session name, for prettier session names
    local session_name = parts[#parts]
    sessions.write(session_name)
end
