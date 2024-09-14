require("noice").setup({
    routes = {
        {
            filter = {
                event = "msg_show",
		kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
		kind = "",
                find = "INSERT",
            },
            opts = { skip = true },
        },
    },
})
