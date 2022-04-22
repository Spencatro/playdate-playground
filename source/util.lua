local m_frameDebug = {}

function frameDebug(line, caller)
    table.insert(m_frameDebug, caller .. " " .. line)
end

function getFrameDebug()
    return m_frameDebug
end

function clearFrameDebug()
    m_frameDebug = {}
end