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
    ["state"] = function(state)
        if state == '1' then
            if video_playing then
                video:stop() -- Stop the video if it's already playing
            end
            video:start() -- Start the video from the beginning
            video_playing = true
            print("Starting video")
        end
    end
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
