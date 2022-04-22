import "scroller"
import "util"

local gfx <const> = playdate.graphics
local menu <const> = playdate.getSystemMenu()

local SHOW_GRID = false

gfx.setColor(gfx.kColorWhite)

PLAYDATE_MAX_WIDTH = 400
PLAYDATE_SCREEN_HEIGHT = 240

function playdate.cranked(change, acceleratedChange)
    scroll(change)
end

local labels = {
    "Welcome to Lipsum Simulator!",
    "lorem ipsum dolor sit amet",
    ".....lorem ipsum dolor sit amet! lorem ipsum dolor sit amet??",
    "Vestibulum tincidunt interdum tortor, at facilisis risus elementum eu.",
    "Praesent dictum, sapien placerat ullamcorper facilisis, odio lorem pretium sem, quis fermentum sem lacus sed turpis.",
    "Nulla vitae convallis enim. Donec pellentesque hendrerit ipsum a tincidunt.",
    "Vivamus dapibus eleifend urna, a porta mi aliquet quis. Pellentesque pulvinar, quam et tempor tristique, nulla arcu imperdiet arcu, et tincidunt erat lacus non nisi. Mauris tempus nunc vitae est posuere consectetur.",
    "Nam malesuada leo sed augue fermentum, vel gravida est consequat. Donec sit amet sem ullamcorper, tincidunt urna et, venenatis ligula. Nullam ut mi pellentesque, maximus arcu quis, mattis magna. Morbi lobortis vitae ligula et egestas. Morbi blandit pretium lorem quis faucibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla facilisi. Sed ligula orci, sagittis vel tellus eget, gravida efficitur erat.",
    "Nullam nisi risus, varius pellentesque sem ut, mattis bibendum elit. Donec at egestas quam. Nunc et ipsum id justo vestibulum mattis. Fusce leo massa, hendrerit at varius non, ultrices ac elit. Morbi ac est a risus pretium feugiat vel eu purus. Nullam at faucibus urna. Aliquam id porttitor justo, non dictum lorem. Cras finibus venenatis enim vel blandit. Nullam ultricies eu elit non hendrerit. Vestibulum eleifend accumsan leo vitae sagittis. Proin congue viverra risus, eget porttitor arcu iaculis quis. Donec id ipsum sit amet arcu sodales iaculis quis in mauris. Praesent ac sapien lobortis, tincidunt velit ut, dictum lorem. Ut ac bibendum magna. Nullam nisi risus, varius pellentesque sem ut, mattis bibendum elit. Donec at egestas quam. Nunc et ipsum id justo vestibulum mattis. Fusce leo massa, hendrerit at varius non, ultrices ac elit. Morbi ac est a risus pretium feugiat vel eu purus. Nullam at faucibus urna. Aliquam id porttitor justo, non dictum lorem. Cras finibus venenatis enim vel blandit. Nullam ultricies eu elit non hendrerit. Vestibulum eleifend accumsan leo vitae sagittis. Proin congue viverra risus, eget porttitor arcu iaculis quis. Donec id ipsum sit amet arcu sodales iaculis quis in mauris. Praesent ac sapien lobortis, tincidunt velit ut, dictum lorem. Ut ac bibendum magna.",
    "Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna.",
    "Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna. Cras malesuada magna id erat ullamcorper, sit amet lobortis eros pellentesque. Integer magna eros, aliquam vel bibendum placerat, venenatis tristique tortor. Nam ac nulla nec metus eleifend varius in et ligula. Etiam finibus euismod ultricies. Nullam hendrerit ante orci, quis feugiat libero ornare non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Phasellus mollis leo eget est sagittis ornare. Proin a viverra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas congue sapien non ipsum feugiat, ac auctor diam vehicula. Maecenas eget nisi sit amet leo elementum accumsan. Morbi tempor eu leo non mattis. Donec at suscipit mi, sit amet fringilla urna."
}

local labelIdx = 1

function playdate.AButtonDown()
	print("[Button] A button pressed down.")
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
    scrollerInit(labels)
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
    if SHOW_GRID then
        drawGrid()
    end
end

function playdate.keyPressed(key)
    if key == "0" then
        menuDumpCalled()
        SHOW_GRID = not SHOW_GRID
    end
end