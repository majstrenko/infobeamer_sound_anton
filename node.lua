gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {
    [16] = resource.load_video{file = "video_for_pin_16.mp4", looped = false, audio = true},
    [17] = resource.load_video{file = "video_for_pin_17.mp4", looped = false, audio = true},
    [18] = resource.load_video{file = "video_for_pin_18.mp4", looped = false, audio = true},
    [19] = resource.load_video{file = "video_for_pin_19.mp4", looped = false, audio = true},
}

local current_video = nil
local video_playing = false

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            current_video = videos[16]
            current_video:start()
            video_playing = true
        end
    end,
    ["state/17"] = function(state)
        if state == '1' then
            current_video = videos[17]
            current_video:start()
            video_playing = true
        end
    end,
    ["state/18"] = function(state)
        if state == '1' then
            current_video = videos[18]
            current_video:start()
            video_playing = true
        end
    end,
    ["state/19"] = function(state)
        if state == '1' then
            current_video = videos[19]
            current_video:start()
            video_playing = true
        end
    end,
}

function node.render()
    if video_playing and current_video then
        local state, w, h = current_video:state()
        if state == "finished" then
            video_playing = false
            current_video = nil
            gl.clear(1, 0, 0, 1) -- red, default state
        else
            current_video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
