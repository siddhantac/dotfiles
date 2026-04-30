return {
    cmd = { 'gopls' },
    root_markers = { 'go.mod', 'go.sum' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
        go = {
            linksInHover = false,
            docs = {
                description = [[
https://github.com/golang/tools/tree/master/gopls

Google's lsp server for golang.
]],
            },
        },
    },
}
