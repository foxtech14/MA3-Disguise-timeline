-- BBLX Disguise Timeline Wizard v1
-- By Michael Fox
-- 17-04-24

-- ****************************************************************
-- USER CONFIG AREA - ONLY EDIT THIS BIT
-- ****************************************************************

local fixture = 7001; -- Timeline Fixture

-- ****************************************************************
-- main plugin
-- ****************************************************************
local C = Cmd;local E = Echo;local MB = MessageBox;
local function clamp(a,b,c)local d="clamp(number:input, number:min, number:max) "assert(type(a)=="number",d.."- input, must be a number")assert(type(b)=="number",d.."- min, must be a number")assert(type(c)=="number",d.."- max, must be a number")assert(b<=c,d.."- min must be less or equal to max")local e=a;if e<b then e=b end;if e>c then e=c end;return e end
local function main()E("Disguise Wizard Started")local a,b,c,d,e;local f=MB({title="What Cue number?",commands={{value=1,name="Ok"}},inputs={{name="Q",whiteFilter="0123456789."}},backColor="Global.Default",icon="logo_small"})a=clamp(tonumber(f.inputs['Q']),0.01,9999.99)b=a+10000.001;E(string.format("Cue Number: %s",a))c=string.sub(b,-8,-7)d=string.sub(b,-6,-5)e=string.sub(b,-3,-2)E(string.format("> XX: %s",c))E(string.format("> YY: %s",d))E(string.format("> ZZ: %s",e))C("BlindEdit On")C("ClearAll")C(string.format("Fixture %s",fixture))C(string.format("Attribute 'cueXX' at %s",c))C(string.format("Attribute 'cueYY' at %s",d))C(string.format("Attribute 'cueZZ' at %s",e))C(string.format("Store Cue %s Part 71 Time 0 /m /nc",a))C(string.format("Label Cue %s Part 71 'Video'",a))C("ClearAll")C("BlindEdit Off")E("Wizard Closed")end
return main;