return {
    name = "go mod vendor",
    builder = function()
        return {
            cmd = { "go" },
            args = { "mod", "vendor" },
            components = { { "on_exit_set_status" }, { "on_complete_notify" } },
            -- components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
}
