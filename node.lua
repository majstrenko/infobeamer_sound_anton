gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local video = resource.load_video{
    file = "1.mp4",
    looped = false,
    audio = true,
    paused = true
}

local video_playing = false

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            video:stop() -- Stop the video if it's playing
            video:start() -- Start the video from the beginning
            video_playing = true
            print("Starting video for pin 16")
        elseif state == '0' then
            video_playing = false
            print("Resetting state for pin 16")
        end
    end
    -- Add similar handlers for other pins if needed
}

function node.render()
    if video_playing then
        local state, w, h = video:state()
        if state == "finished" then
            print("Video finished playing")
            video_playing = false
            gl.clear(1, 0, 0, 1) -- red, default state
        else
            video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
