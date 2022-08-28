local composer = require( "composer" )

local scene = composer.newScene()
local listener = {}



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


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        print "working"
		-- local overlayBackground = display.newRect(100, 100, 1000 , 3000, 3000)
		-- overlayBackground:setFillColor(0,0,0)
	
		-- overlayBackground.alpha = 1
	myText = display.newText( "Game Over", display.contentCenterX, 200, native.systemFont, 40)
	myText:setFillColor(1,0,0)
	
	
	
	pipes = 0



	-- button


	widget = require( "widget" )
 
	-- Function to handle button events
	function handleButtonEvent( event )
	 
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			composer.removeScene("overlay")
			composer.gotoScene("game")
		end
	end

	function goToMainMenu( event )
	 
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			composer.removeScene("overlay")
			composer.gotoScene("main menu")
		end
	end
	 
	-- Create the widget
	button1 = widget.newButton(
		{
			label = "button",
			onEvent = handleButtonEvent,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,0,1}, over={1,0.1,0.7,0.4} },
			strokeColor = { default={1,1,0,1}, over={0.8,0.8,1,1} },
			strokeWidth = 4
		}
	)
	 
	-- Center the button
	button1.x = display.contentCenterX
	button1.y = display.contentCenterY
	 
	-- Change the button's label text
	button1:setLabel( "Restart" )

	button2 = widget.newButton(
		{
			label = "button",
			onEvent = goToMainMenu,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,0,1}, over={1,0.1,0.7,0.4} },
			strokeColor = { default={1,1,0,1}, over={0.8,0.8,1,1} },
			strokeWidth = 4
			
		}
	)
	 
	-- Center the button
	button2.x = display.contentCenterX
	button2.y = display.contentCenterY - 60
	 
	-- Change the button's label text
	button2:setLabel( "Main Menu" )





function listener:timer( event )
    print( "listener called" )
	
end
  
timer.performWithDelay( 1000, listener )
end
end


-- hide()
function scene:hide( event )



	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		print("overlay hide")
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	print("overlay destroy")
	display.remove(button1)
	display.remove(myText)
	display.remove(button2)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "cancelled", scene)
-- -----------------------------------------------------------------------------------

return scene