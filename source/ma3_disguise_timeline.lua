-- BBLX Disguise Timeline Wizard v1
-- By Michael Fox
-- 17-04-24

-- ****************************************************************
-- USER CONFIG AREA - ONLY EDIT THIS BIT
-- ****************************************************************

local fixture = 7001 -- Timeline Fixture


-- ****************************************************************
-- local plugin variables
-- ****************************************************************

local C = Cmd
local E = Echo
local MB = MessageBox


-- ****************************************************************
-- clamp(number, number, number) : number
-- ****************************************************************
function clamp(input, min, max)
    local ErrorString = "clamp(number:input, number:min, number:max) "
    assert(type(input) == "number", ErrorString .. "- input, must be a number")
    assert(type(min) == "number", ErrorString .. "- min, must be a number")
    assert(type(max) == "number", ErrorString .. "- max, must be a number")
    assert(min <= max, ErrorString .. "- min must be less or equal to max")
    local i = input
    if i < min then i = min end
    if i > max then i = max end
    return i
end


-- ****************************************************************
-- main function
-- ****************************************************************

local function main()
    E("Disguise Wizard Started")
    local qNum, padNum, cueXX, cueYY, cueZZ

    -- input dialog for user input for cue number
    local inputCue = MB({
        title = "What Cue number?",
        commands = {{value = 1, name = "Ok"}},
        inputs = {{name = "Q", whiteFilter = "0123456789."}},
        backColor = "Global.Default",
        icon = "logo_small",
    });

    -- convert user input
    qNum = clamp(tonumber(inputCue.inputs['Q']), 0.01, 9999.99)
    padNum = qNum + 10000.001

    E(string.format("Cue Number: %s", qNum))

    -- extract relevant numbers
    cueXX = string.sub(padNum, -8,-7)
    cueYY = string.sub(padNum, -6,-5)
    cueZZ = string.sub(padNum, -3,-2)

    E(string.format("> XX: %s", cueXX))
    E(string.format("> YY: %s", cueYY))
    E(string.format("> ZZ: %s", cueZZ))

    C("BlindEdit On")
    C("ClearAll")

    -- put fixture at values
    C(string.format("Fixture %s", fixture))
    C(string.format("Attribute 'cueXX' at %s", cueXX))
    C(string.format("Attribute 'cueYY' at %s", cueYY))
    C(string.format("Attribute 'cueZZ' at %s", cueZZ))

    C(string.format("Store Cue %s Part 71 Time 0 /m /nc", qNum))
    C(string.format("Label Cue %s Part 71 'Video'", qNum))

    -- clear all values
    C("ClearAll")
    C("BlindEdit Off")
    E("Wizard Closed")
end

return main;