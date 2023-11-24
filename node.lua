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
        if state == 'toggle' then
            if not video_playing then
                video:start() -- Start the video from the beginning
                video_playing = true
                print("Starting video for pin 16")
            end
        end
    end
    ["state/16"] = function(state)
        if state == 'toggleoff' then
            if not video_playing then
                video:stop() -- Start the video from the beginning
                video_playing = false
                print("Starting video for pin 16")
            end
        end
    end
}

function node.render()
    if video_playing then
        local state, w, h = video:state()
        if state == "finished" then
            video_playing = false
            video:stop()
            print("Video finished playing")
        else
            video:draw(0, 0, WIDTH, HEIGHT)
        end
    end
    -- When video is not playing, the screen remains empty
end
