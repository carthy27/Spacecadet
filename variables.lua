relayout = require("relayout")

counter = 0 
lives = 1
-- f = true
stopPipes = 0

_W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CY, relayout._CX
pipes = {}


canAddPipe = 0

tapText = nil

bird = display.newImageRect( "hero.png", 64, 64 )
bird:translate( 100, 100)

bird.myName = "bird"



--The sensorfloor
crate1 = display.newRect(0, -200 , 5000, 30 )
crate1:setFillColor(0,0,0)  
crate1.gravitySCale = 0
crate1.myName = "roof"

crate2 = display.newRect(0, display.contentHeight + 100 , 5000, 30)
crate2:setFillColor(0,0,0) 
crate2.gravitySCale = 0
crate2.myName = "floor"

audio.reserveChannels( 1 )
audio.play( musicTrack, { channel=1, loops=-1 } )
