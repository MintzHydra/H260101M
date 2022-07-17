--langsung geser ngesor ae
local function MemoryPatch(libname, offset, hex)
  local start = 0
  ---------- FUNCTIONS ----------
  local function check_hex_symbol(sym)
    local hexdigts = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f"}
    for _,v in pairs(hexdigts) do
      if v == sym then
        return true
      end
    end
    return false
  end
  local function check_hex(hex)
    if #hex == 0 then return false end
    for i = 1, #hex do
      if not check_hex_symbol(hex:sub(i, i)) then return false end
    end
    return true
  end
  local function getHexFromMem(offsetFrom, offsetTo)
    local length = (offsetTo - offsetFrom) / 4
    local str = ""
    local num = 0
    for i = 1, length, 1 do
      local h = {}
      h[1] = {}
      h[1].address = start + offsetFrom + num
      h[1].flags = gg.TYPE_DWORD
      local output = string.format("%x", gg.getValues(h)[1].value)
      str = str..string.gsub(output,"ffffffff","")
      num = num + 4
    end
    return str
  end
  local function revers_hex(hex)
    local newhex = ""
    if #hex == 0 then return false end
    for g=1, #hex, 8 do 
      local curhex = string.sub(hex, g, g+7)
      for i=#curhex, 1, -2 do
        newhex = newhex..string.sub(curhex, i-1, i)
      end
    end
    return newhex:upper()
  end
  local function hex2gg_list(hex)
    local lst = {}
    for i=1, #hex, 8 do
      table.insert(lst, "h"..hex:sub(i, i+7))
    end
    return lst
  end
  ---------- DO WORK ----------
  hex = hex:gsub(" ", "")
  if not check_hex(hex) then print("Hex has error") return nil end
  local i = 0
  if not libname:sub(1, 3) == "lib" then
    libname = "lib"..libname
  end
  local result = gg.getRangesList(libname)
  
  while true do
    i = i + 1
    if result[i].type == "r-xp" then
      start = result[i].start
	  break
    end
	
  end
  local this = {}
  local inmemsize = 0
  if #hex % 4 ~= 0 then
    inmemsize = #hex / 2 + (16 - #hex % 4)
  else
    inmemsize = #hex / 2
  end
  local original_hex = revers_hex(getHexFromMem(offset, offset+inmemsize, false))
  local original_hex_gg = hex2gg_list(original_hex)
  local newhex = hex
  if #hex < #original_hex then
    newhex = hex..original_hex:sub(#hex+1)
  end
  local hex_gg_list = hex2gg_list(newhex)
  ---------- Modify and Restore functions ----------
  this.Modify = function()
    local num = 0
    for g,v in ipairs(hex_gg_list) do
      local h = {}
      h[1] = {}
      h[1].address = start + offset + num
      h[1].flags = gg.TYPE_DWORD
      h[1].value = v
      gg.setValues(h)
      num = num + 4
    end
  end
  this.Restore = function()
    local num = 0
    for g,v in ipairs(original_hex_gg) do
      local h = {}
      h[1] = {}
      h[1].address = start + offset + num
      h[1].flags = gg.TYPE_DWORD
      h[1].value = v
      gg.setValues(h)
      num = num + 4
    end
  end
  return this
end

--YOLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

--json--
local json = {
 decode = function(js)
  local L="return "..js:gsub('%[','{'):gsub('%]','}'):gsub('("[^"]+")%s*:','[%1]=')
  local T = load(L)()
  return T
 end,
 encode = function (tbl)
  return (dump or tostring)(tbl)
  :gsub("%['(%w+)'%] = ([%{'%w])", "\"%1\": %2")
  :gsub("%-%- table%b()", "")
  :gsub(": '(.-)'", ": \"%1\"")
  :gsub("([\"%w]),(%s*%})", "%1%2")
 end
}
--end json--

--ARM CONVERTER--
function armConvert(value)
local urlReq = "https://armconverter.com/api/convert"
data = gg.makeRequest(urlReq, nil, '{"asm":"MOV w0, #'..value..'","offset":"","arch":["arm64","arm","thumb"]}').content
result = {}
local example = data
local nb = 0
for i in string.gmatch(example, "%S+") do
    nb = nb + 1
    result[nb] = i
end
return result[14]
end
--END--

--RETURN ASPD--
function sliders20000()
local input = gg.prompt({"Select value :[0;20000]"},{0},{"number"})
if input == nil then return
else
local a = armConvert(input[1])
local b = a:gsub('%"]},', '')
local c = b:gsub('%"', '')
return c
end
end
--END--

--Mulaine ko kene
local on = '[ON]'
local off = '[OFF]'
local aspdval = ""
local loggedIn = false

--tambahono status
cstatus = off
cstatus2 = off
cstatus3 = off
cstatus4 = off
cstatus5 = off
cstatus6 = off
cstatus7 = off
cstatus8 = off
cstatus9 = off
cstatus10 = off
cstatus11 = off
cstatus12 = off
cstatus13 = off
cstatus14 = off
cstatus15 = off
cstatus16 = off
cstatus17 = off
cstatus18 = off
cstatus19 = off
cstatus20 = off
cstatus21 = off
cstatus22 = off
cstatus23 = off
cstatus24 = off
cstatus25 = off
cstatus26 = off
cstatus27 = off
cstatus28 = off
cstatus29 = off
cstatus30 = off
cstatus31 = off
cstatus32 = off
cstatus33 = off
cstatus34 = off

local targetLib = "libil2cpp.so"

--fitur e
godmode = MemoryPatch(targetLib, 0x1FFDAD4, "20008052")
godmode_ret = MemoryPatch(targetLib, 0x1FFDAD8, "C0035FD6")
alwayscrit = MemoryPatch(targetLib, 0x24C4BEC,"20008052")
alwayscrit_ret = MemoryPatch(targetLib, 0x24C4BF0, "C0035FD6")
aspd = MemoryPatch(targetLib, 0x21C3528, "00C48952")
aspd_ret = MemoryPatch(targetLib, 0x21C352C, "C0035FD6")
stable = MemoryPatch(targetLib, 0x21C2590, "800C8052")
stable_ret = MemoryPatch(targetLib, 0x21C2594, "C0035FD6")
nograze = MemoryPatch(targetLib, 0x21CDEA8, "00008052")
noeva = MemoryPatch(targetLib, 0x21DA5FC, "00008052")
noguard = MemoryPatch(targetLib, 0x21DA5F4, "00008052")
bosslowdef = MemoryPatch(targetLib, 0x1F55170, "800C8052")
bosslowdef_ret = MemoryPatch(targetLib, 0x1F55174, "800C8052")
bosslowmdef = MemoryPatch(targetLib, 0x1F55584, "800C8052")
bosslowmdef_ret = MemoryPatch(targetLib, 0x1F55588, "800C8052")
highdef = MemoryPatch(targetLib, 0x21C342C, "00A38252")
highdef_ret = MemoryPatch(targetLib, 0x21C3430, "C0035FD6")
highmdef = MemoryPatch(targetLib, 0x21C3480, "00A38252")
highmdef_ret = MemoryPatch(targetLib, 0x21C3484, "C0035FD6")
autoguard = MemoryPatch(targetLib, 0x1E627AC, "20008052")
autoguard_ret = MemoryPatch(targetLib, 0x1E627B0, "C0035FD6")
bigradius = MemoryPatch(targetLib, 0x21DA61C, "E0E18452")
instantcast = MemoryPatch(targetLib, 0x21C70D4, "00008052")
instantcast_ret = MemoryPatch(targetLib, 0x21C70D8, "C0035FD6")
unlockboss = MemoryPatch(targetLib, 0x21ED610, "E0E18452")
cutscene = MemoryPatch(targetLib, 0x1C0A33C, "80008052")
nodomination = MemoryPatch(targetLib, 0x1D63304, "00008052")
nodomination_ret = MemoryPatch(targetLib, 0x1D63308, "C0035FD6")
ailment100 = MemoryPatch(targetLib, 0x24D25FC, "20008052")
ailment100_ret = MemoryPatch(targetLib, 0x24D2600,"C0035FD6")
buffunli = MemoryPatch(targetLib, 0x21BC3D4, "00008052")
buffunl2 = MemoryPatch(targetLib, 0x21BC3E8, "00008052")
buffunl3 = MemoryPatch(targetLib, 0x21BC46C, "1F2003D5")
cf1 = MemoryPatch(targetLib, 0x21BC8B4, "EA031E32")
cf2 = MemoryPatch(targetLib, 0x21BCC88, "A0160011")
cf2 = MemoryPatch(targetLib, 0x21BC840, "1F2003D5")
mobinv = MemoryPatch(targetLib, 0x2298FAC, "00008052")
mobinv_ret = MemoryPatch(targetLib, 0x2298FB0, "C0035FD6")
fire = MemoryPatch(targetLib, 0x2620930, "20008052")
water = MemoryPatch(targetLib, 0x2620930, "40008052")
wind = MemoryPatch(targetLib, 0x2620930, "60008052")
earth = MemoryPatch(targetLib, 0x2620930, "80008052")
light = MemoryPatch(targetLib, 0x2620930, "A0008052")
dark = MemoryPatch(targetLib, 0x2620930, "C0008052")
neutral = MemoryPatch(targetLib, 0x2620930, "E0008052")
nomove = MemoryPatch(targetLib, 0x21DA644, "00008052")
nomove_ret = MemoryPatch(targetLib, 0x21DA648, "C0035FD6")
instantfinal1 = MemoryPatch(targetLib, 0x1E378EC, "08008052")
instantfinal2 = MemoryPatch(targetLib, 0x1E378F0, "1F2003D5")
skillburst = MemoryPatch(targetLib, 0x1F24DF0, "02E28452")
str = MemoryPatch(targetLib, 0x21C164C, "803E8052")
str_ret = MemoryPatch(targetLib, 0x21C1650, "C0035FD6")
dex = MemoryPatch(targetLib, 0x21C19CC, "803E8052")
dex_ret = MemoryPatch(targetLib, 0x21C19D0, "C0035FD6")
dmgboost = MemoryPatch(targetLib, 0x24CB314, "19328052")
bypass1 = MemoryPatch(targetLib, 0x0, "00000000")
bypass2 = MemoryPatch(targetLib, 0x10, "00000000")


local oStr
L0_0 = gg.alert
oStr = (os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
L0_0(oStr)

function LogMeIn(device_id)
local urlReq = "https://hydramodz-api.herokuapp.com/api/user/getbydeviceid/"
data = gg.makeRequest(urlReq, {['Authorization']='Basic YWRtaW5AaHlkcmFtb2R6LmNvbTpBZG1pbkAxMjM=', ['Content-Type']='application/json; charset=utf-8'}, '{"device_id":"'..device_id..'"}').content
if data == nil then
gg.alert("Cannot connect to hydra server!")
end
r = {}
local res = json.decode(data)
loggedIn = res.status
--return res.status
end

function showMenu()
local choices = gg.choice({
	cstatus31..'BYPASS WOYYYY',
	'Player Menu',
	'Monster Menu',
	'Skill Menu',
	'Other Menu',
	'Element Menu',
	'Exit',
},nil,
os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
--------------------------------------------------
if choices == 1 then
	if cstatus31 == on then
		cstatus31 = off
	else
		cstatus31 = on
	end
	if cstatus31 == on then
		bypasson()
	else
		bypassoff()
	end
end

if choices == 2 then PlayerMenu() end

if choices == 3 then MonsterMenu() end
	
if choices == 4 then SkillMenu() end

if choices == 5 then OtherMenu() end

if choices == 6 then ElementMenu() end
	
if choices == 7 then
gg.alert(os.date('HydraModz Logout \n Today %Y/%m/%d Time %H:%M:%S'))
os.exit() end
end

function PlayerMenu()
local player = gg.choice({
	                cstatus..' God Mode',
					cstatus2..' Always Crit',
					cstatus3..' Attack Speed',
					cstatus4..' Damage Stable',
					cstatus9..' High Def',
					cstatus10..' High MDef',
					cstatus32..' Damage Booster',
					cstatus33..' STR UP 400 Point',
					cstatus34..' DEX Up 400 Point',
					'Back',
	},nil,
	os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
if player == 1 then
	if cstatus == on then
		cstatus = off
	else
		cstatus = on
	end
	if cstatus == on then
		godmodeon()
	else
		godmodeoff()
	end
end

if player == 2 then
	if cstatus2 == on then
		cstatus2 = off
	else
		cstatus2 = on
	end
	if cstatus2 == on then
		alwayscriton()
	else
		alwayscritoff()
	end
end

if player == 3 then
	if cstatus3 == on then
		cstatus3 = off
	else
		cstatus3 = on
	end
	if cstatus3 == on then
		--aspdval = sliders20000()
		aspdon()
	else
		aspdoff()
	end
end

if player == 4 then
	if cstatus4 == on then
		cstatus4 = off
	else
		cstatus4 = on
	end
	if cstatus4 == on then
		stableon()
	else
		stableoff()
	end
end

if player == 5 then
	if cstatus9 == on then
		cstatus9 = off
	else
		cstatus9 = on
	end
	if cstatus9 == on then
		highdefon()
	else
		highdefoff()
	end
end

if player == 6 then
	if cstatus10 == on then
		cstatus10 = off
	else
		cstatus10 = on
	end
	if cstatus10 == on then
		highmdefon()
	else
		highmdefoff()
	end
end

if player == 7 then
	if cstatus32 == on then
		cstatus32 = off
	else
		cstatus32 = on
	end
	if cstatus32 == on then
		dmgbooston()
	else
		dmgboostoff()
	end
end

if player == 8 then
	if cstatus33 == on then
		cstatus33 = off
	else
		cstatus33 = on
	end
	if cstatus33 == on then
		stron()
	else
		stroff()
	end
end

if player == 9 then
	if cstatus34 == on then
		cstatus34 = off
	else
		cstatus34 = on
	end
	if cstatus34 == on then
		dexon()
	else
		dexoff()
	end
end

if player == 10 then
	showMenu()
end
end

function MonsterMenu()
local monster = gg.choice({
					cstatus20..' Boss No Immune',
	                cstatus5..' Boss No Graze',
					cstatus6..' Boss No Eva',
					cstatus7..' Boss No Guard',
					cstatus22..' No Move',
					cstatus8..' Boss Lowdef/mdef',
					'Back',
	},nil,
	os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
if monster == 1 then
	if cstatus20 == on then
		cstatus20 = off
	else
		cstatus20 = on
	end
	if cstatus20 == on then
		mobinvon()
	else
		mobinvoff()
	end
end

if monster == 2 then
	if cstatus20 == on then
		cstatus20 = off
	else
		cstatus20 = on
	end
	if cstatus20 == on then
		nograzeon()
	else
		nograzeoff()
	end
end

if monster == 3 then
	if cstatus6 == on then
		cstatus6 = off
	else
		cstatus6 = on
	end
	if cstatus6 == on then
		noevaon()
	else
		noevaoff()
	end
end
	
if monster == 4 then
	if cstatus7 == on then
		cstatus7 = off
	else
		cstatus7 = on
	end
	if cstatus7 == on then
		noguardon()
	else
		noguardoff()
	end
end
	
if monster == 5 then
	if cstatus22 == on then
		cstatus22 = off
	else
		cstatus22 = on
	end
	if cstatus22 == on then
		nomoveon()
	else
		nomoveoff()
	end
end
	
if monster == 6 then
	if cstatus8 == on then
		cstatus8 = off
	else
		cstatus8 = on
	end
	if cstatus8 == on then
		bosslowdefmdefon()
	else
		bosslowdefmdefoff()
	end
end

if monster == 7 then
	showMenu()
end
end

function SkillMenu()
local skill = gg.choice({
					cstatus24..' All Skill Burst',
	                cstatus18..' Buff Unlimited',
					cstatus23..' Instant Finale',
					cstatus13..' Instant Cast',
					cstatus12..' Big Radius',
					cstatus17..' Ailment 100%',
					cstatus19..' Instant CF',
					'Back',
	},nil,
	os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
if skill == 1 then
	if cstatus24 == on then
		cstatus24 = off
	else
		cstatus24 = on
	end
	if cstatus24 == on then
		skillburston()
	else
		skillburstoff()
	end
end

if skill == 2 then
	if cstatus18 == on then
		cstatus18 = off
	else
		cstatus18 = on
	end
	if cstatus18 == on then
		buffunlion()
	else
		buffunlioff()
	end
end

if skill == 3 then
	if cstatus23 == on then
		cstatus23 = off
	else
		cstatus23 = on
	end
	if cstatus23 == on then
		instantfinalon()
	else
		instantfinaloff()
	end
end

if skill == 4 then
	if cstatus13 == on then
		cstatus13 = off
	else
		cstatus13 = on
	end
	if cstatus13 == on then
		instantcaston()
	else
		instantcastoff()
	end
end

if skill == 5 then
	if cstatus12 == on then
		cstatus12 = off
	else
		cstatus12 = on
	end
	if cstatus12 == on then
		bigradiuson()
	else
		bigradiusoff()
	end
end

if skill == 6 then
	if cstatus17 == on then
		cstatus17 = off
	else
		cstatus17 = on
	end
	if cstatus17 == on then
		ailment100on()
	else
		ailment100off()
	end
end

if skill == 7 then
	if cstatus19 == on then
		cstatus19 = off
	else
		cstatus19 = on
	end
	if cstatus19 == on then
		cfon()
	else
		cfoff()
	end
end

if skill == 8 then
showMenu()
end
end

function OtherMenu()
local other = gg.choice({
					cstatus15..' Skip Cutscene',
					cstatus14..' Unlock Boss No MQ',
					cstatus16..' No Domination',
					cstatus11..' Autoguard',
					'Back',
	},nil,
	os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
if other == 1 then
	if cstatus15 == on then
		cstatus15 = off
	else
		cstatus15 = on
	end
	if cstatus15 == on then
		cutsceneon()
	else
		cutsceneoff()
	end
end

if other == 2 then
	if cstatus14 == on then
		cstatus14 = off
	else
		cstatus14 = on
	end
	if cstatus14 == on then
		unlockbosson()
	else
		unlockbossoff()
	end
end

if other == 3 then
	if cstatus16 == on then
		cstatus16 = off
	else
		cstatus16 = on
	end
	if cstatus16 == on then
		nodominationon()
	else
		nodominationoff()
	end
end

if other == 4 then
	if cstatus11 == on then
		cstatus11 = off
	else
		cstatus11 = on
	end
	if cstatus11 == on then
		autoguardon()
	else
		autoguardoff()
	end
end

if other == 5 then
showMenu()
end
end

function ElementMenu()
local element = gg.choice({
					cstatus21..' Fire',
					cstatus25..' Water',
					cstatus26..' Wind',
					cstatus27..' Earth',
					cstatus28..' Light',
					cstatus29..' Dark',
					cstatus30..' Neutral',
					'Back',
	},nil,
	os.date('HydraModz TORAM ONLINE \n Today %Y/%m/%d Time %H:%M:%S'))
if element == 1 then
	if cstatus21 == on then
		cstatus21 = off
	else
		cstatus21 = on
		cstatus25 = off
		cstatus26 = off
		cstatus27 = off
		cstatus28 = off
		cstatus29 = off
		cstatus30 = off
	end
	if cstatus21 == on then
		fireon()
	else
		fireoff()
	end
end

if element == 2 then
	if cstatus25 == on then
		cstatus25 = off
	else
		cstatus25 = on
		cstatus21 = off
		cstatus26 = off
		cstatus27 = off
		cstatus28 = off
		cstatus29 = off
		cstatus30 = off
	end
	if cstatus25 == on then
		wateron()
	else
		wateroff()
	end
end

if element == 3 then
	if cstatus26 == on then
		cstatus26 = off
	else
		cstatus26 = on
		cstatus25 = off
		cstatus21 = off
		cstatus27 = off
		cstatus28 = off
		cstatus29 = off
		cstatus30 = off
	end
	if cstatus26 == on then
		windon()
	else
		windoff()
	end
end

if element == 4 then
	if cstatus27 == on then
		cstatus27 = off
	else
		cstatus27 = on
		cstatus26 = off
		cstatus25 = off
		cstatus21 = off
		cstatus28 = off
		cstatus29 = off
		cstatus30 = off
	end
	if cstatus27 == on then
		earthon()
	else
		earthoff()
	end
end

if element == 5 then
	if cstatus28 == on then
		cstatus28 = off
	else
		cstatus28 = on
		cstatus27 = off
		cstatus26 = off
		cstatus25 = off
		cstatus21 = off
		cstatus29 = off
		cstatus30 = off
	end
	if cstatus28 == on then
		lighton()
	else
		lightoff()
	end
end

if element == 6 then
	if cstatus29 == on then
		cstatus29 = off
	else
		cstatus29 = on
		cstatus27 = off
		cstatus26 = off
		cstatus25 = off
		cstatus21 = off
		cstatus28 = off
		cstatus30 = off
	end
	if cstatus29 == on then
		darkon()
	else
		darkoff()
	end
end

if element == 7 then
	if cstatus30 == on then
		cstatus30 = off
	else
		cstatus30 = on
		cstatus29 = off
		cstatus27 = off
		cstatus26 = off
		cstatus25 = off
		cstatus21 = off
		cstatus28 = off
	end
	if cstatus30 == on then
		neutralon()
	else
		neutraloff()
	end
end

if element == 8 then
showMenu()
end
end

--Terus iki function dingge on off e
function godmodeon()
godmode.Modify()
godmode_ret.Modify()
gg.alert("GodMode On")
end

function godmodeoff()
godmode.Restore()
godmode_ret.Restore()
gg.alert("GodMode Off")
end

function alwayscriton()
alwayscrit.Modify()
alwayscrit_ret.Modify()
gg.alert("Always Crit On")
end

function alwayscritoff()
alwayscrit.Restore()
alwayscrit_ret.Restore()
gg.alert("Always Crit Off")
end

function stableon()
stable.Modify()
stable_ret.Modify()
gg.alert("Damage Stable On")
end

function stableoff()
stable.Restore()
stable_ret.Restore()
gg.alert("Damage Stable Off")
end

function nograzeon()
nograze.Modify()
gg.alert("Boss No Graze On")
end

function nograzeoff()
nograze.Restore()
gg.alert("Boss No Graze Off")
end

function noevaon()
noeva.Modify()
gg.alert("Boss No Eva On")
end

function noevaoff()
noeva.Restore()
gg.alert("Boss No Eva Off")
end

function noguardon()
noguard.Modify()
gg.alert("Boss No Guard On")
end

function noguardoff()
noguard.Restore()
gg.alert("Boss No Guard Off")
end

function bosslowdefmdefon()
bosslowdef.Modify()
bosslowdef_ret.Modify()
bosslowmdef.Modify()
bosslowmdef_ret.Modify()
gg.alert("Boss Low Def/MDef On")
end

function bosslowdefmdefoff()
bosslowdef.Restore()
bosslowdef_ret.Restore()
bosslowmdef.Restore()
bosslowmdef_ret.Restore()
gg.alert("Boss Low Def/MDef Off")
end

function highdefon()
highdef.Modify()
highdef_ret.Modify()
gg.alert("High Def On")
end

function highdefoff()
highdef.Restore()
highdef_ret.Restore()
gg.alert("High Def Off")
end

function highmdefon()
highmdef.Modify()
highmdef_ret.Modify()
gg.alert("High MDef On")
end

function highmdefoff()
highmdef.Restore()
highmdef_ret.Restore()
gg.alert("High MDef Off")
end

function autoguardon()
autoguard.Modify()
autoguard_ret.Modify()
gg.alert("Auto Guard On")
end

function autoguardoff()
autoguard.Restore()
autoguard_ret.Restore()
gg.alert("Auto Guard Off")
end

function bigradiuson()
bigradius.Modify()
gg.alert("Big Radius On")
end

function bigradiusoff()
bigradius.Restore()
gg.alert("Big Radius Off")
end

function instantcaston()
instantcast.Modify()
instantcast_ret.Modify()
gg.alert("Instant Cast On")
end

function instantcastoff()
instantcast.Restore()
instantcast_ret.Restore()
gg.alert("Instant Cast Off")
end

function unlockbosson()
unlockboss.Modify()
gg.alert("Unlock Boss No MQ On")
end

function unlockbossoff()
unlockboss.Restore()
gg.alert("Unlock Boss No MQ Off")
end

function cutsceneon()
cutscene.Modify()
gg.alert("Skip Cutscene On")
end

function cutsceneoff()
cutscene.Restore()
gg.alert("Skip Cutscene Off")
end

function nodominationon()
nodomination.Modify()
nodomination_ret.Modify()
gg.alert("No Domination On")
end

function nodominationoff()
nodomination.Restore()
nodomination_ret.Restore()
gg.alert("No Domination Off")
end

function ailment100on()
ailment100.Modify()
ailment100_ret.Modify()
gg.alert("Ailment 100% On")
end

function ailment100off()
ailment100.Restore()
ailment100_ret.Restore()
gg.alert("Ailment 100% Off")
end

function buffunlion()
buffunli.Modify()
buffunl2.Modify()
buffunl3.Modify()
gg.alert("Buff Unlimited On")
end

function buffunlioff()
buffunli.Restore()
buffunl2.Restore()
buffunl3.Modify()
gg.alert("Buff Unlimited")
end

function cfon()
cf1.Modify()
cf2.Modify()
cf3.Modify()
gg.alert("Instant CF On")
end

function cfoff()
cf1.Restore()
cf2.Restore()
cf3.Restore()
gg.alert("Instant CF Off")
end

function mobinvon()
mobinv.Modify()
mobinv_ret.Modify()
gg.alert("Boss No Immune On")
end

function mobinvoff()
mobinv.Restore()
mobinv_ret.Restore()
gg.alert("Boss No Immune Off")
end

function fireon()
fire.Modify()
gg.alert("Element Fire On")
end

function fireoff()
fire.Restore()
gg.alert("Element Fire Off")
end

function wateron()
water.Modify()
gg.alert("Element Water On")
end

function wateroff()
water.Restore()
gg.alert("Element Water Off")
end

function windon()
wind.Modify()
gg.alert("Element Wind On")
end

function windoff()
wind.Restore()
gg.alert("Element Wind Off")
end

function earthon()
earth.Modify()
gg.alert("Element Earth On")
end

function earthoff()
earth.Restore()
gg.alert("Element Earth Off")
end

function lighton()
lignt.Modify()
gg.alert("Element Light On")
end

function lightoff()
light.Restore()
gg.alert("Element Light Off")
end

function darkon()
dark.Modify()
gg.alert("Element Dark On")
end

function darkoff()
dark.Restore()
gg.alert("Element Dark Off")
end

function neutralon()
neutral.Modify()
gg.alert("Element Neutral On")
end

function neutraloff()
neutral.Restore()
gg.alert("Element Neutral Off")
end

function nomoveon()
nomove.Modify()
nomove_ret.Modify()
gg.alert("Monster No Move On")
end

function nomoveoff()
nomove.Restore()
nomove_ret.Restore()
gg.alert("Monster No Move Off")
end

function instantfinalon()
instantfinal1.Modify()
instantfinal2.Modify()
gg.alert("Instant Finale On")
end

function instantfinaloff()
instantfinal1.Restore()
instantfinal2.Restore()
gg.alert("Instant Finale Off")
end

function skillburston()
skillburst.Modify()
gg.alert("All Skill Burst On")
end

function skillburstoff()
skillburst.Restore()
gg.alert("All Skill Burst Off")
end

function bypasson()
bypass1.Modify()
bypass2.Modify()
gg.alert("BYPASS On")
end

function bypassoff()
bypass1.Restore()
bypass2.Restore()
gg.alert("BYPASS Off")
end

function aspdon()
aspd.Modify()
aspd_ret.Modify()
gg.alert("ASPD On")
end

function aspdoff()
aspd.Restore()
aspd_ret.Restore()
gg.alert("ASPD Off")
end

function dmgbooston()
dmgboost.Modify()
gg.alert("Damage Booster On")
end

function dmgboostoff()
dmgboost.Restore()
gg.alert("Damage Booster Off")
end

function stron()
str.Modify()
str_ret.Modify()
gg.alert("STR Up 400 Point On")
end

function stroff()
str.Restore()
str_ret.Restore()
gg.alert("STR Up 400 Point Off")
end

function dexon()
dex.Modify()
dex_ret.Modify()
gg.alert("DEX Up 400 Point On")
end

function dexoff()
dex.Restore()
dex_ret.Restore()
gg.alert("DEX Up 400 Point Off")
end

function openzFile()
file = io.open("/sdcard/hydraconfig.txt")
if file == nil then
gg.alert("Hydra Initialize Error")
end
local number_of_loop = 0
local extracted = {}
repeat 
  text = file:read("l*")
  number_of_loop = number_of_loop + 1
  extracted[number_of_loop] = text
until number_of_loop == 1
return extracted[1]
end

while true do
  if gg.isVisible() then
    gg.setVisible(false)
	if loggedIn == false then 
	LogMeIn(openzFile()) 
	else
    showMenu()
	end
  else
    gg.sleep(100) 
    end
end