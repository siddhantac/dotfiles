return {
    name = "Create pull request",
    builder = function()
        return {
            cmd = { "gh" },
            args = { "pr", "create", "-a", "@me", "-w" },
            components = { { "on_exit_set_status" }, { "on_complete_notify" } },
            -- components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
}
