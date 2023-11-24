gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local video = resource.load_video{
    file = "1.mp4",
    looped = false,
    audio = true,
    paused = true
}

util.data_mapper{
    ["state/16"] = function(state)
        if state == 'restart' then
            video:stop() -- Stop the video if it's playing
            video:start() -- Start the video from the beginning
            print("Restarting video for pin 16")
        end
    end
    -- Add similar handlers for other pins if needed
}

function node.render()
    local video_state, w, h = video:state()
    if video_state ~= "finished" then
        video:draw(0, 0, WIDTH, HEIGHT)
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
