gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {
    [16] = resource.load_video{file = "1.mp4", looped = false, audio = true, paused = true},
    [17] = resource.load_video{file = "2.mp4", looped = false, audio = true, paused = true},
    [18] = resource.load_video{file = "3.mp4", looped = false, audio = true, paused = true},
    [19] = resource.load_video{file = "4.mp4", looped = false, audio = true, paused = true},
}

local current_video = nil
local video_playing = false

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            current_video = videos[16]
            current_video:start()
            video_playing = true
            if state == '0' then
                current_video:dispose()
                video_playing = false
            end
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
