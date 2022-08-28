require("variables")


local counternoise = audio.loadSound("counternoise.mp3")
local boom = audio.loadSound("boom.mp3")


function drop(event)
    if (event.keyName == "space") then
        print ("down")
        bird:translate(0, 10)
    end

    if (event.keyName == "a") and (bird.x > 10) then
        print ("left")
        print("bird.y = "..bird.y)
        bird:translate(-10,0)
        
    end

    if (event.keyName == "d") and (bird.x < display.contentWidth) then
        print("right")
        bird:translate(10,0)
    end

    if (event.keyName == "w")  and (bird.y > 20)then
        print("up")
        bird:translate(0,-10)
    end
    
    if (event.keyName == "s") and (bird.y < display.contentHeight - 20) then
        print("down")
        bird:translate(0,10)
    end   
end

function update()
    if lives == 1 then
        for i = #pipes, 1, -1 do
            local object = pipes[i]
            object:translate( -2, 0 )


            if object.x < -10 then
                local child = table.remove(pipes , i)
            
                if child ~= nil then 
                    child:removeSelf()
                    child = nil
                end
            end

            if stopPipes < 0 then 
                local child = table.remove(pipes , i)
            end
        
            -- if checkCollisions(crate1, bird) or checkCollisions(crate2, bird) then
            --     composer.gotoScene("overlay")
            --     print("ow")
            --     print(lives)
            --     stopPipes = stopPipes + 1
            --     yPosition = 0
            --     pipes.alpha = 0
            -- end


            if checkCollisions(object, bird) then
                if object.type == "sensor" then
                    print("SSSSSCCCCOOORRREEEE")
                    counter = counter + 1
                    tapText.text = counter
                    counternoise = audio.loadSound("counternoise.mp3")
                    audio.play(counternoise , {channel = 2, loops=1})
                    
                
                
            
                    local child = table.remove(pipes , i)

                    if child ~= nil then
                        child:removeSelf()
                        child = nil
                    end
                else
                

                    lives = lives-1
                    
                    if lives == 0  then
                        boom = audio.loadStream("boom.mp3")
	                    audio.play(boom , {channel = 3, loops=1})
                    
                        composer.gotoScene("overlay")
                        print("ow")
                        print(lives)
                        stopPipes = stopPipes + 1
                        yPosition = 0
                        pipes.alpha = 0

                
                    end
                end
            end
        end
        
        if canAddPipe > 100 then
            addPipe()

            canAddPipe = 0
        end

        canAddPipe = canAddPipe + 3 
    end
end

function checkCollisions(obj1, obj2)

    local left  = (obj1.contentBounds.xMin) <= obj2.contentBounds.xMin and (obj1.contentBounds.xMax)>= obj2.contentBounds.xMin
    local right = (obj1.contentBounds.xMin) >= obj2.contentBounds.xMin and (obj1.contentBounds.xMin)<= obj2.contentBounds.xMax
    local up    = (obj1.contentBounds.yMin) <= obj2.contentBounds.yMin and (obj1.contentBounds.yMax) >= obj2.contentBounds.yMin
    local down  = (obj1.contentBounds.yMin) >= obj2.contentBounds.yMin and (obj1.contentBounds.yMin)<= obj2.contentBounds.xMax
  
    return (left or right) and (up or down)
end

function addPipe( )
    if lives == 1 then
        local yPosition = math.random( 0 , _H)
        
        local pSensor = display.newRect(_W + 100, _CY, 5, 10000)
        pSensor.alpha = 0
        pSensor.fill = { 0, 0, 0}
        pSensor.type = "sensor"
        pipes[#pipes+1] = pSensor
        
        audio.play( spacecadet, { channel=2, loops=-1 } )
    


        local p = display.newImageRect("asteroid.png", 64, 64)
        p:translate(400, yPosition)

        p.type = "pipe"
        pipes[#pipes+1] = p
    end
end

function clear()
    display.remove(tapText)
    display.remove(crate1)    
    display.remove(crate2)
    display.remove(bird)
    bird = display.newImageRect( "Hero.png", 64, 64 )
    bird.x = -604
    bird.y = 64
    
    for i = #pipes,1,-1 do
        display.remove(pipes[i])
    end
end

function reset()
    -- -- counter
	counter = 0 
	lives = 1
    --  f = true
	stopPipes = 0

    _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CY, relayout._CX

    canAddPipe = 0

    tapText = display.newText( counter, display.contentCenterX, 60, native.systemFont, 60)
    tapText:setFillColor(0, 1, 0)

    pipes = {}

    bird.x = 64
    bird.y = 64

    --The sensorfloor
    crate1 = display.newRect(0, 0 , 5000, 30 )
    crate1:setFillColor(0,0,0) 
    crate1.gravitySCale = 0
    crate1.myName = "roof"
    
    crate2 = display.newRect(0, display.contentHeight , 5000, 30)
    crate2:setFillColor(0,0,0) 
    crate2.gravitySCale = 0
    crate2.myName = "floor"
end

