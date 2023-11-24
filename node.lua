local video -- this will hold our video resource

function setup()
    video = resource.load_video{
        file = "1.mp4",
        looped = false,
        paused = true,
    }
end

function node.render()
    gl.clear(0, 0, 0, 1) -- clear the screen
    video:draw(0, 0, WIDTH, HEIGHT) -- draw the video
end

node.event("data", function(data, suffix)
    if data == "touch" then
        if video:state() == "paused" then
            video:start()
        elseif video:state() == "finished" then
            video:rewind()
            video:start()
        end
    end
end)

setup()
