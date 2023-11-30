gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local current_video = nil
local video_playing = false
local video_queue = {}

local function start_video(pin)
    local videos = {
        [16] = resource.load_video{file = "1.mp4"; looped = false; audio = true; paused = true},
        [17] = resource.load_video{file = "2.mp4"; looped = false; audio = true; paused = true},
        [18] = resource.load_video{file = "3.mp4"; looped = false; audio = true; paused = true},
        [19] = resource.load_video{file = "4.mp4"; looped = false; audio = true; paused = true},
    }
    if current_video then
        current_video:dispose()
    end
    current_video = videos[pin]
    current_video:start()
    video_playing = true
end

local function stop_video()
    if current_video then
        current_video:dispose()
    end
    current_video = nil
    video_playing = false
end

local function process_video_queue()
    if #video_queue > 0 and not video_playing then
        local next_video = table.remove(video_queue, 1)
        start_video(next_video)
    end
end

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            table.insert(video_queue, 16)
            process_video_queue()
        end
    end,
    ["state/17"] = function(state)
        if state == '1' then
            table.insert(video_queue, 17)
            process_video_queue()
        end
    end,
    ["state/18"] = function(state)
        if state == '1' then
            table.insert(video_queue, 18)
            process_video_queue()
        end
    end,
    ["state/19"] = function(state)
        if state == '1' then
            table.insert(video_queue, 19)
            process_video_queue()
        end
    end,
}

function node.render()
    if video_playing and current_video then
        local video_state, w, h = current_video:state()
        if video_state == "finished" then
            stop_video()
            process_video_queue()
        else
            current_video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
