-- BBLX Disguise Timeline Wizard v2
-- By Michael Fox
-- 27-02-26

-- ****************************************************************
-- local plugin variables
-- ****************************************************************

-- global function cache
local C = Cmd;
local E = Echo;
local MB = MessageBox;

-- function lookup table
local functions = {};


-- ****************************************************************
-- macro creation function
-- ****************************************************************

local function createMacros()
    -- input dialog for user input for cue number
    local macroNum = MB({
        title = "Start Macro number?",
        commands = {{value = 1, name = "Ok"}},
        inputs = {{name = "Macro", whiteFilter = "0123456789"}},
        backColor = "Global.Default",
        icon = "logo_small",
    });

    -- convert user input
    local num = clamp(tonumber(macroNum.inputs['Macro']), 1, 9999);
    local cmd1 = 'Call Plugin "BBLX Disguise Cue Trigger" "create"';
    local cmd2 = 'Call Plugin "BBLX Disguise Cue Trigger" "delete"';
    local cmd3 = 'Call Plugin "BBLX Disguise Cue Trigger" "setfixture"';

    C(string.format("Store Macro %s.1", num));
    C(string.format("Set Macro %s.1 Property \"Command\" \"%s\"", num, cmd1));
    C(string.format("Label Macro %s \"%s\"", num, "Store Disgusie Trigger"));

    num = num + 1;
    C(string.format("Store Macro %s.1", num));
    C(string.format("Set Macro %s.1 Property \"Command\" \"%s\"", num, cmd2));
    C(string.format("Label Macro %s \"%s\"", num, "Delete Disgusie Trigger"));

    num = num + 1;
    C(string.format("Store Macro %s.1", num));
    C(string.format("Set Macro %s.1 Property \"Command\" \"%s\"", num, cmd3));
    C(string.format("Label Macro %s \"%s\"", num, "Set Disguise Fixture Number"));
end

-- ****************************************************************
-- cue input function
-- ****************************************************************

-- clamp(number, number, number) : number
local function clamp(input, min, max)
    local ErrorString = "clamp(number:input, number:min, number:max) ";
    assert(type(input) == "number", ErrorString .. "- input, must be a number");
    assert(type(min) == "number", ErrorString .. "- min, must be a number");
    assert(type(max) == "number", ErrorString .. "- max, must be a number");
    assert(min <= max, ErrorString .. "- min must be less or equal to max");
    local i = input;
    if i < min then i = min end
    if i > max then i = max end
    return i;
end

local function getQ()
    -- input dialog for user input for cue number
    local inputCue = MB({
        title = "What Cue number?",
        commands = {{value = 1, name = "Ok"}},
        inputs = {{name = "Q", whiteFilter = "0123456789."}},
        backColor = "Global.Default",
        icon = "logo_small",
    });

    -- convert user input
    local num = clamp(tonumber(inputCue.inputs['Q']), 0.01, 9999.99);
    return num;
end


-- ****************************************************************
-- cue function
-- ****************************************************************

functions['create'] = function()
    local qNum, padNum, cueXX, cueYY, cueZZ;
    local fixture = GetVar(UserVars(),'d3fixture');

    qNum = getQ();
    padNum = qNum + 10000.001;
    -- extract relevant numbers
    cueXX = string.sub(padNum, -8,-7);
    cueYY = string.sub(padNum, -6,-5);
    cueZZ = string.sub(padNum, -3,-2);

    E(string.format("Cue Number: %s", qNum));
    E(string.format("> XX: %s", cueXX));
    E(string.format("> YY: %s", cueYY));
    E(string.format("> ZZ: %s", cueZZ));

    C("ClearAll");

    -- put fixture at values
    C(string.format("Fixture %s", fixture));
    C(string.format("Attribute 'cueXX' at %s", cueXX));
    C(string.format("Attribute 'cueYY' at %s", cueYY));
    C(string.format("Attribute 'cueZZ' at %s", cueZZ));

    C(string.format("Store Cue %s Part 71 Time 0 /m /nc", qNum));
    C(string.format("Label Cue %s Part 71 'Video'", qNum));
    C(string.format("Assign Appearance 'd3' at Cue %s Part 71", qNum));

    -- clear all values
    C("ClearAll");
end

functions['delete'] = function()
    local qNum = getQ();
    C(string.format("Delete Cue %s Part 71 /nc", qNum));
end

-- ****************************************************************
-- caller function
-- ****************************************************************

local function main(display,argument)
    E("Disguise Q Wizard");
    if argument then
        functions[spiltString(argument,",",1)]();
    else
        functions['create']();
    end
    E("Complete");
end

return main;