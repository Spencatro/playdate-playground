import "lib/AnimatedSprite"
import "util"

local gfx <const> = playdate.graphics

local LINE_MIN <const> = -85
local t_lineCurrent = LINE_MIN
local t_lineMax = t_lineCurrent
local t_lineThreshold = t_lineCurrent
local g_textLineTable = {}
local g_preparedTextLineTable = {}
local g_blurbCount = 0

local standardFont
local halvedFont

local cursorTable = gfx.imagetable.new('img/cursor')
local cursorSprite = AnimatedSprite.new(cursorTable)
cursorSprite:addState("left", 1, 9, {tickStep = 2, yoyo = true}, true)
cursorSprite:moveTo(20,20)

-- SET THIS TO YOUR FONT'S HEIGHT
local fontHeight = 0

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

function scrollerInit(lines)
    standardFont = gfx.font.new('fonts/font-full-circle')
    halvedFont = gfx.font.new('fonts/font-full-circle-halved')
    gfx.setFont(standardFont)
    _, fontHeight = gfx.getTextSize("aA!09gp")
    fontHeight += 5

    local initialLine = table.remove(lines, 1)
    addTextLine(initialLine)
    for idx, line in ipairs(lines) do
        prepareLine(line)
    end

    t_lineThreshold += nextLineHeight()
end

function addTextLine(line, dontBreak)
    print(line)
    print(calcTotalHeight(line))
    dontBreak = dontBreak or false
    g_blurbCount += 1
    local words = splitLine(line)
    local nextWord = table.remove(words, 1)
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
    end
    table.insert(g_textLineTable, "<br>")
end

function prepareLine(line)
    table.insert(g_preparedTextLineTable, line)
end

function addNextPreparedLine()
    local nextLine = table.remove(g_preparedTextLineTable, 1)
    if nextLine then
        addTextLine(nextLine)
    end
end

function calcTotalHeight(line)
    local totalHeight = fontHeight
    local words = splitLine(line)
    local nextWord = table.remove(words, 1)
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
                print("calc: adding " .. fontHeight)
                totalHeight += fontHeight
                break
            end
            nextWord = table.remove(words, 1)
            if nextWord == nil then
                break
            end
        end
    end
    print("calc: returning " .. totalHeight)
    return totalHeight
end

function nextLineHeight()
    local nextLine = g_preparedTextLineTable[1]
    if nextLine then
        return calcTotalHeight(nextLine)
    else
        return nil
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
        if line == "<br>" then
            m_brOffset += fontHeight / 2
            curBlurb += 1
        else
            gfx.drawText(line, 50, 15 + m_lineCount * fontHeight - t_lineCurrent + m_brOffset)
            m_lineCount += 1
        end
    end
 end

function scroll(amount)
    local newLineCurrent = t_lineCurrent + (amount * 0.3)
    if newLineCurrent > LINE_MIN then
        t_lineCurrent = newLineCurrent
    end
    t_lineMax = math.max(t_lineCurrent, t_lineMax)
    if t_lineMax - t_lineThreshold > 0 then
        t_lineThreshold = t_lineMax + nextLineHeight()
        addNextPreparedLine()
    end
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