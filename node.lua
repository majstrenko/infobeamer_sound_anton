gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local current_video = nil
local video_playing = false
local video_files = {
    [16] = "1.mp4",
    [17] = "2.mp4",
    [18] = "3.mp4",
    [19] = "4.mp4",
    [20] = "3.mp4",
    [21] = "4.mp4",
}

local function start_video(pin)
    if current_video and video_playing then
        current_video:dispose()
    end

    local video_file = video_files[pin]
    if video_file then
        current_video = resource.load_video{
            file = video_file,
            looped = false,
            audio = true,
            paused = true
        }
        current_video:start()
        video_playing = true
    else
    end
end

local function stop_video()
    if current_video then
        current_video:dispose()
        
    end
    current_video = nil
    video_playing = false
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
    ["state/20"] = function(state) --pridané
        if state == '1' then -- pridané
            start_video(20) -- pridané
        end -- pridané
    end, -- pridané
    ["state/21"] = function(state) -- pridané
        if state == '1' then -- pridané
            start_video(21) -- pridané
        end -- pridané
    end, -- pridané
}

function node.render()
    if video_playing and current_video then
        local video_state, w, h = current_video:state()
        if video_state == "finished" then
            stop_video()
            gl.clear(1, 0, 0, 1) -- red, default state
        else
            current_video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
