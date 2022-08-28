-- -----------------------------------------------------------------------------------------
-- --
-- -- main.lua
-- --
-- -----------------------------------------------------------------------------------------
-- -- source
-- --https://www.youtube.com/watch?v=zjxJDW6LSEU

composer = require( "composer" )

-- scene = composer.newScene()
relayout = require("relayout")
-- -- layout

counter = 0 
lives = 1
-- f = true
stopPipes = 0

_W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CY, relayout._CX
pipes = {}
canAddPipe = 0
-- -- variables
pipes = {}
canAddPipe = 0

tapText = display.newText( counter, display.contentCenterX, 60, native.systemFont, 60)
tapText:setFillColor(0, 1, 0)

bird = display.newImageRect( "Hero.png", 64, 64 )
bird:translate( 100, 100)
bird:setFillColor(1, 0, 0)
bird.velocity = 0
bird.gravityScale = 0
bird.myName = "bird"



--The sensorfloor
crate1 = display.newRect(0, 0 , 5000, 30 )
crate1:setFillColor(0,0,0)  
crate1.gravitySCale = 0
crate1.myName = "roof"

crate2 = display.newRect(0, display.contentHeight , 5000, 30)
crate2:setFillColor(0,0,0) 
crate2.gravitySCale = 0
crate2.myName = "floor"

local function checkCollisions(obj1, obj2)

    local left  = (obj1.contentBounds.xMin) <= obj2.contentBounds.xMin and (obj1.contentBounds.xMax)>= obj2.contentBounds.xMin
    local right = (obj1.contentBounds.xMin) >= obj2.contentBounds.xMin and (obj1.contentBounds.xMin)<= obj2.contentBounds.xMax
    local up    = (obj1.contentBounds.yMin) <= obj2.contentBounds.yMin and (obj1.contentBounds.yMax) >= obj2.contentBounds.yMin
    local down  = (obj1.contentBounds.yMin) >= obj2.contentBounds.yMin and (obj1.contentBounds.yMin)<= obj2.contentBounds.xMax
  
    return (left or right) and (up or down)
end

local function addPipe( )
    if lives == 1 then
        local yPosition = math.random( 0 , _H)
        
        local pSensor = display.newRect(_W + 100, _CY, 5, 10000)
        pSensor.alpha = 0
        pSensor.fill = { 0, 0, 0}
        pSensor.type = "sensor"
        pipes[#pipes+1] = pSensor


        local p = display.newImageRect("asteroid.png", 64, 64)
        p:translate(400, yPosition)

        p.type = "pipe"
        pipes[#pipes+1] = p
    end
end

local function drop(event)
    if (event.keyName == "space") then
        print ("down")
        bird:translate(0, 10)
    end

    if (event.keyName == "a") then
        print ("left")
        bird:translate(-10,0)
        
    end

    if (event.keyName == "d") then
        print("right")
        bird:translate(10,0)
    end

    if (event.keyName == "w") then
        print("up")
        bird:translate(0,-10)
    end
    
    if (event.keyName == "s") then
        print("down")
        bird:translate(0,10)
    end   
end

local function update()
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
        
            if checkCollisions(crate1, bird) or checkCollisions(crate2, bird) then
                Runtime:removeEventListener("enterFrame", update)     
               clear()

                composer.showOverlay( "overlay" , overlayOptions)
            end


            if checkCollisions(object, bird) then
                if object.type == "sensor" then
                    print("SSSSSCCCCOOORRREEEE")
                    counter = counter + 1
                    tapText.text = counter
                    
                
                
            
                    local child = table.remove(pipes , i)

                    if child ~= nil then
                        child:removeSelf()
                        child = nil
                    end
                else
                

                    lives = lives-1
                    
                    if lives == 0  then
                       clear()
                    
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

function clear()
    Runtime:removeEventListener("enterFrame", update)     
    Runtime:removeEventListener("key" , drop)

end

function reset()
 

    display.remove(tapText)
    display.remove(crate1)    
    display.remove(crate2)
    display.remove(bird)
end

Runtime:addEventListener("enterFrame", update)     
Runtime:addEventListener("key" , drop)
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
   --reset()
    Runtime:addEventListener("enterFrame", update)     
    Runtime:addEventListener("key" , drop)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
       --reset()
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- -- counter

        Runtime:addEventListener("enterFrame", update)     
        Runtime:addEventListener("key" , drop)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
