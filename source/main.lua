import "scroller"
import "util"

local gfx <const> = playdate.graphics
local menu <const> = playdate.getSystemMenu()

gfx.setColor(gfx.kColorWhite)

PLAYDATE_MAX_WIDTH = 400
PLAYDATE_SCREEN_HEIGHT = 240

function playdate.cranked(change, acceleratedChange)
    scroll(change)
end

local labels = {
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Donec eu efficitur ante. Curabitur semper leo arcu, ac dictum justo suscipit vel.",
    "Suspendisse potenti. Aliquam vestibulum ut orci eu egestas. Phasellus vel lacus tellus.",
    "Vestibulum tincidunt interdum tortor, at facilisis risus elementum eu.",
    "Praesent dictum, sapien placerat ullamcorper facilisis, odio lorem pretium sem, quis fermentum sem lacus sed turpis.",
    "Nulla vitae convallis enim. Donec pellentesque hendrerit ipsum a tincidunt.",
}

local labelIdx = 1

function playdate.AButtonDown()
	print("[Button] A button pressed down.")
    addTextLine(labels[labelIdx])
    addTextLine("<br>")
    labelIdx += 1
    toggleCursor()
end

local function drawGrid()

    gfx.setColor(gfx.kColorBlack)
    gfx.setLineWidth(1)

    for x = 1, 40 do
        gfx.drawLine(x*100, 0, x*100, 800)
    end
    
    for y = 1, 40 do
        gfx.drawLine(0, y*100, 800, y*100)
    end

end

local function gameDidLaunch()
    print(" launched!")
    scrollerInit()
end
gameDidLaunch()

local function menuDumpCalled()
    print("dumping:")
    printTable(getFrameDebug())
end

menu:addMenuItem("Debug dump", menuDumpCalled)

function playdate.update()
    clearFrameDebug()
    gfx.sprite.update()
    gfx.setColor(gfx.kColorWhite)
    playdate.drawFPS(0,0)
    makeScreenLines()
    -- drawGrid()
end

function playdate.keyPressed(key)
    if key == "0" then
        menuDumpCalled()
    end
end