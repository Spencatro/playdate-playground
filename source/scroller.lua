import "lib/AnimatedSprite"
import "util"

local gfx <const> = playdate.graphics

local t_lineTarget = 0
local t_lineCurrent = 0
local t_yOffsetTarget = 0
local t_yOffsetCurrent = 0

local g_textLineCount = 0
local g_textLineTable = {}
local g_blurbCount = 0
local standardFont
local halvedFont

local cursorTable = gfx.imagetable.new('img/cursor')
local cursorSprite = AnimatedSprite.new(cursorTable)
cursorSprite:addState("left", 1, 9, {tickStep = 2, yoyo = true}, true)
cursorSprite:moveTo(20,20)

-- SET THIS TO YOUR FONT'S HEIGHT
local fontHeight = 20

local function fprint(line)
    frameDebug(line, "[Scroller]")
end

local function splitLine(line)
    local words = {}
    for word in string.gmatch(line, "[^%s]+") do
        table.insert(words, word)
    end
    return words
end

function scrollerInit()
    standardFont = gfx.font.new('fonts/font-full-circle')
    halvedFont = gfx.font.new('fonts/font-full-circle-halved')
end

function addTextLine(line)
    print("adding: ", line)
    if line ~= "<br>" then
        g_blurbCount += 1
     end
     local words = splitLine(line)
     printTable(words)
     local nextWord = table.remove(words, 1)
     print(nextWord)
     while nextWord ~= nil do
        local currentLineWidth = 0
        local currentLine = ""
        while currentLineWidth < (PLAYDATE_MAX_WIDTH - 60) do
             local currentLineTemp = currentLine .. nextWord .. " "
             local w, h = gfx.getTextSize(currentLineTemp)
             if w < PLAYDATE_MAX_WIDTH - 60 then
                currentLine = currentLineTemp
                currentLineWidth = w
             else
                table.insert(words, 1, nextWord)
                break
             end
             nextWord = table.remove(words, 1)
             if nextWord == nil then
                break
             end
         end
         table.insert(g_textLineTable, currentLine)
         g_textLineCount += 1
     end
 end

function makeScreenLines()
    local m_lineCount = 0
    local m_brOffset = 0
    local curBlurb = 0
    for idx, line in ipairs(g_textLineTable) do
        fprint(curBlurb .. " == " .. g_blurbCount .. " -1 ?")
        fprint(line)
        if curBlurb == g_blurbCount - 1 then
            fprint("setting standard font")
            gfx.setFont(standardFont)
        else
            fprint("setting halved font")
            gfx.setFont(halvedFont)
        end
        if line == "<br> " then
            m_brOffset += fontHeight / 2
            curBlurb += 1
        else
            gfx.drawText(line, 50, 15 + m_lineCount * fontHeight + t_lineCurrent + m_brOffset)
            m_lineCount += 1
        end
    end
 end

function scroll(amount)
    t_lineCurrent -= (amount * 0.3)
end

local cursorVisible = true
function toggleCursor()
    if cursorVisible then
        cursorSprite:remove()
    else
        cursorSprite:add()
    end
    cursorVisible = not cursorVisible
end