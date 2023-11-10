-- gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

-- local font = resource.load_font "font.ttf"

-- function node.render()
--     font:write(250, 300, "Hello world", 64, 1,1,1,1)
--     gl.clear(0, 1, 0, 1) -- green
-- end

gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local on = false

util.data_mapper{
    state = function(state)
        on = state == '1'
    end,
}

function node.render()
    if on then
        gl.clear(0, 1, 0, 1) -- green
    else
        gl.clear(1, 0, 0, 1) -- red
    end
end
