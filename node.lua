gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local video1 -- Video to be played when 'on' is true
local video2 -- Video to be played when 'on' is false
local on = false

function load_videos()
    video1 = resource.load_video{
        file = "path/to/your/first/video.mp4",
        looped = true,
        paused = true,
    }
    video2 = resource.load_video{
        file = "path/to/your/second/video.mp4",
        looped = true,
        paused = true,
    }
end

util.data_mapper{
    state = function(state)
        on = state == '1'
        if on then
            video1:start()
            video2:stop()
        else
            video1:stop()
            video2:start()
        end
    end,
}

function node.render()
    if on then
        video1:draw(0, 0, WIDTH, HEIGHT)
    else
        video2:draw(0, 0, WIDTH, HEIGHT)
    end
end

load_videos()
