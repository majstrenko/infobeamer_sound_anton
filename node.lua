gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {
    [16] = {
        resource.load_video{file = "1.mp4"; looped = false; audio = true; paused = true},
        loaded = false,
    },
    [17] = {
        resource.load_video{file = "1.mp4"; looped = false; audio = true; paused = true},
        loaded = false,
    },
    [18] = {
        resource.load_video{file = "1.mp4"; looped = false; audio = true; paused = true},
        loaded = false,
    },
}

local current_video = nil

local function start_video(pin)
    if current_video then
        current_video:dispose()
        current_video = nil
    end

    if not videos[pin].loaded then
        videos[pin][1]:start()
        videos[pin].loaded = true
    else
        videos[pin][1]:seek(0)
        videos[pin][1]:start()
    end

    current_video = videos[pin][1]
end

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            start_video(16)
        end
    end,
    ["state/17"] = function(state)
        if state == '1' then
            start_video(17)
        end
    end,
    ["state/18"] = function(state)
        if state == '1' then
            start_video(18)
        end
    end,
    ["state/19"] = function(state)
        if state == '1' then
            start_video(19)
        end
    end,
}

function node.render()
    gl.clear(0, 0, 0, 1) -- Black clear color

    if current_video then
        local video_state, w, h = current_video:state()
        if video_state ~= "finished" then
            current_video:draw(0, 0, WIDTH, HEIGHT)
        else
            current_video:dispose()
            current_video = nil
        end
    end
end
