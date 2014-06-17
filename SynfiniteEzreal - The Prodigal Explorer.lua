--Script Info--
local Version = "0.01"
local ScriptVersion = "0.01"
local AutoUpdate = true
local Author = "Timii"
local LoadedText = "SynfiniteEzreal"
local ServerData

 --         _____              __ _       _ _       ______                    _         --
 --        / ____|            / _(_)     (_) |     |  ____|                  | |        --
 --       | (___  _   _ _ __ | |_ _ _ __  _| |_ ___| |__   _____ __ ___  __ _| |        --
 --        \___ \| | | | '_ \|  _| | '_ \| | __/ _ \  __| |_  / '__/ _ \/ _` | |        --
 --        ____) | |_| | | | | | | | | | | | ||  __/ |____ / /| | |  __/ (_| | |        --
 --       |_____/ \__, |_| |_|_| |_|_| |_|_|\__\___|______/___|_|  \___|\__,_|_|        --
 --                __/ |                                                                --
 --               |___/                                                                 --
 --  _____ _          ___             _ _           _   ___          _                 
 -- |_   _| |_  ___  | _ \_ _ ___  __| (_)__ _ __ _| | | __|_ ___ __| |___ _ _ ___ _ _  --
 --   | | | ' \/ -_) |  _/ '_/ _ \/ _` | / _` / _` | | | _|\ \ / '_ \ / _ \ '_/ -_) '_| --
 --   |_| |_||_\___| |_| |_| \___/\__,_|_\__, \__,_|_| |___/_\_\ .__/_\___/_| \___|_|   --
 --                                      |___/                 |_|                      --

--Champion--
if myHero.charName ~= "Ezreal" then return end

--Auto-Update: Thanks to QQQ--
local UPDATE_FILE_PATH = SCRIPT_PATH.."SynfiniteEzreal - The Prodigal Explorer"
local UPDATE_NAME = "SynfiniteEzreal - The Prodigal Explorer"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/SynfiniteTimii/SynfinteScripts/master/SynfiniteEzreal%20-%20The%20Prodigal%20Explorer.lua?chunk="..math.random(1, 1000)
local UPDATE_FILE_PATH = SCRIPT_PATH.."SynfiniteEzreal - The Prodigal Explorer.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

--Message Display [AutoUpdate]--
function Messages(MSG) 
	print("<font color=\"#000000\">[</font><font color=\"#FFBF00\">"..LoadedText.."</font><font color=\"#000000\">]</font> "..MSG) 
end

function AUpdate()
	if AutoUpdate then
		ServerData = GetWebResult(UPDATE_HOST, UPDATE_PATH)
		if ServerData then
			local ServerVersion = string.match(ServerData, "ScriptVersion = \"%d.%d%d\"")
			ServerVersion = string.match(ServerVersion and ServerVersion or "", "%d.%d%d")
			if ServerVersion then
				if ScriptVersion ~= ServerVersion then
					Messages("<font color=\"#848484\"> Script is not updated. Current Version: </font> <font color=\"#8A0808\">"..ScriptVersion.."</font> <font color=\"#848484\">Latest Version: </font> <font color=\"#8A0808\">"..ServerVersion.."</font><font color=\"#848484\">.</font>")
					Messages("<font color=\"#848484\">Now Updating Script to </font><font color=\"#8A0808\">v."..ServerVersion.."</font><font color=\"#848484\">. Do not press [F9].</font>")
					DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function ()
					Messages("<font color=\"#848484\">Succesfully Updated </font><font color=\"#FFBF00\">"..LoadedText.."</font> <font color=\"#848484\"> to </font><font color=\"#8A0808\">v."..ServerVersion.."</font><font color=\"#848484\">.</font>") end) end, 3)
					Messages("<font color=\"#848484\">Please reload the script for changes to take effect.</font>")
				else 
					Messages("<font color=\"#848484\">Your script is updated to the latest version</font> <font color=\"#8A0808\">v"..ScriptVersion.."</font><font color=\"#848484\">.</font>")
				end
			end
		else
			Messages("<font color=\"#848484\">An error occured while checking version information.</font>")
		end
	end
end
--End Auto Update--

--Check for Required Libraries: Thanks to QQQ--
local VIP_LIBS = {
	["VPrediction"] = "https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua",
	["SOW"] = "https://raw.github.com/Hellsing/BoL/master/common/SOW.lua"
}
local NORMAL_LIBS = {
	["AoE_Skillshot_Position"] = "https://raw.github.com/SynfiniteTimii/SynfinteScripts/master/Common/AoE_Skillshot_Position.lua",
	["SOW"] = "https://raw.github.com/Hellsing/BoL/master/common/SOW.lua"
}
local DOWNLOADING_LIBS = false
local DOWNLOAD_COUNT = 0

--Checks if they are downloaded using DOWNLOAD_COUNT--
function AfterDownload()
	DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
	if DOWNLOAD_COUNT == 0 then
		DOWNLOADING_LIBS = false
		print("<font color=\"#000000\">[</font><font color=\"#FFBF00\">"..LoadedText.."</font><font color=\"#000000\">]</font> <font color=\"#848484\">All required libraries are now downloaded. Please reload for changes to take effect.</font>")
	end
end

if VIP_USER then
	for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(VIP_LIBS) do
		if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
			require(DOWNLOAD_LIB_NAME)
		else
			DOWNLOADING_LIBS = true
			DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1

			print("<font color=\"#000000\">[</font><font color=\"#FFBF00\">"..LoadedText.."</font><font color=\"#000000\">]</font> <font color=\"#848484\">Not all required libraries are installed. Downloading "..DOWNLOAD_LIB_NAME..".</font>")
			DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
		end
	end
	if DOWNLOADING_LIBS then return end
else
	for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(NORMAL_LIBS) do
		if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
			require(DOWNLOAD_LIB_NAME)
		else
			DOWNLOADING_LIBS = true
			DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1

			print("<font color=\"#000000\">[</font><font color=\"#FFBF00\">"..LoadedText.."</font><font color=\"#000000\">]</font> <font color=\"#848484\">Not all required libraries are installed. Downloading "..DOWNLOAD_LIB_NAME..".</font>")
			DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
		end
	end
	if DOWNLOADING_LIBS then return end
end
--End Check Req. Libs--

--Variables--
--Spells--
local Skills = {
	skillQ = {spellName = "Mystic Shot", range = 1200, speed = 2000, delay = .250, width = 60},
  skillW = {spellName = "Essence Flux", range = 1050, speed = 1600, delay = .250, width = 80},
  skillR = {spellName = "Trueshot Barrage", range = 2000, speed = 2000, delay = 1.0, width = 160},
}
local IR, QR, WR, ER, RR
local VPred = nil
--Target Selection Variables--
local targetSelect
targetSelect = TargetSelector(TARGET_LESS_CAST_PRIORITY, Skills.skillR.range, DAMAGE_PHYSICAL, true)
targetSelect.name = "[SE] Select Target"
local Target = nil
--Damage Calc Variables--
local IgniteD = 0
local UltD = 0

--OnLoad Function--
function OnLoad()
	AUpdate()
	CheckI()
	if VIP_USER then
    VPred = VPrediction()
		theSOW = SOW(VPred)
  else
		PredQ = TargetPrediction(Skills.skillQ.range, Skills.skillQ.speed / 1000, Skills.skillQ.delay * 1000, Skills.skillQ.width)
		PredW = TargetPrediction(Skills.skillW.range, Skills.skillW.speed / 1000, Skills.skillW.delay * 1000, Skills.skillW.width)
		PredR = TargetPrediction(Skills.skillR.range, Skills.skillR.speed / 1000, Skills.skillR.delay * 1000, Skills.skillR.width)
  end
	AddMenu()
	
	print("<font color=\"#000000\">[</font><font color=\"#FFBF00\">"..LoadedText.."</font><font color=\"#000000\">]</font> <font color=\"#8A0808\">v"..ScriptVersion.."</font> <font color=\"#848484\">successfully loaded.</font>")
end

--OnTick Function [Runs every tick]--
function OnTick()
	if myHero.dead then return end
	CheckCD()
	--CalculateDMG()
	Target = GetCustomTarget()
	theSOW:ForceTarget(Target)
	
	--Hotkey Toggles--
	if Menu.Hotkeys.LaneFarm then Farming() end
	if Menu.QuickCast.AutoE then AutoE() end
	if Menu.Orbwalk.Mode1 then Harass() end
	if Menu.Orbwalk.Mode0 then SBTWCombo() end
	if Menu.QuickCast.AutoR then AutoR() end
	
	--If Target: Thanks QQQ--
	if Target then
		--Ignite--
		if Menu.QuickCast.AutoI then
			local IgniteD = 50 + (20 * myHero.level)
			AutoIgnite(Target, IgniteD)
		end
	end
end

--OnDraw Function--
function OnDraw()

	if myHero.dead then return end
	--Lag Free Circles--
	if Menu.Drawings.NoLagToggle then
		local draw = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
		if OnScreen(draw.x, draw.y) then
			--Check AutoAttack--
			if Menu.Drawings.DrawA then
				DrawCircle3D(myHero.x, myHero.y, myHero.z, myHero.range + 25, 1, RGB(0,0,0)) 
			end
			--Check Q--
			if Menu.Drawings.DrawQ then
				if QR then 
					DrawCircle3D(myHero.x, myHero.y, myHero.z, Skills.skillQ.range - 60, 1, RGB(17,240,61)) 
				else 
					DrawCircle3D(myHero.x, myHero.y, myHero.z, Skills.skillQ.range - 60, 1, RGB(247,17,40))
				end
			end
			--Check W--
			if Menu.Drawings.DrawW then
				if WR then
					DrawCircle3D(myHero.x, myHero.y, myHero.z, Skills.skillW.range - 60, 1, RGB(17,240,61))
				else
					DrawCircle3D(myHero.x, myHero.y, myHero.z, Skills.skillW.range - 60, 1, RGB(247,17,40))
				end
			end
		end
	--Full Circles--
	else
		if Menu.Drawings.DrawA then
				DrawCircle(myHero.x, myHero.y, myHero.z, myHero.range + 65, ARGB(20,20,20,20)) 
		end
		--Check Q--
		if Menu.Drawings.DrawQ then
			if QR then 
				DrawCircle(myHero.x, myHero.y, myHero.z, Skills.skillQ.range + 25, ARGB(94,17,240,61)) 
			else
				DrawCircle(myHero.x, myHero.y, myHero.z, Skills.skillQ.range + 25, ARGB(97,247,17,40))
			end
		end
		--Check W--
		if Menu.Drawings.DrawW then
			if WR then
				DrawCircle(myHero.x, myHero.y, myHero.z, Skills.skillW.range + 25, ARGB(94,17,240,61))
			else
				DrawCircle(myHero.x, myHero.y, myHero.z, Skills.skillW.range + 25, ARGB(97,247,17,40))
			end
		end
	end
end

--Check Cooldown--
function CheckCD()
	IR = (SIgnite ~= nil and myHero:CanUseSpell(SIgnite) == READY)
	QR = (myHero:CanUseSpell(_Q) == READY)
	WR = (myHero:CanUseSpell(_W) == READY)
	ER = (myHero:CanUseSpell(_E) == READY)
	RR = (myHero:CanUseSpell(_R) == READY)
end

--Item Damage Bonus--
function ItemDamage()
	local BonusDamage = 0
	--Sheen--
	if GetInventoryHaveItem(3057) then
		BonusDamage = getDmg("Sheen", Target, myHero)
	--Trinity Force--
	elseif GetInventoryHaveItem(3078) then
		BonusDamage = getDmg("Trinity Force", Target, myHero)
	end
	
	return BonusDamage
end

--AutoE--
function AutoE()
	if ER then
		CastSpell(_E, mousePos.x, mousePos.z)
	end
end

--Harass Settings--
function Harass()
	--If Q Enabled--
	if ValidTarget(Target, Skills.skillQ.range, true) and QR then
		if Menu.Harass.HarassQ then
			QCast(Target)
		end
	end
	--If W Enabled--
	if ValidTarget(Target, Skills.skillW.range, true) and WR then
		if Menu.Harass.HarassW then
			WCast(Target)
		end
	end
end

--Auto Ultimate [WIP]--
function AutoR()
	if ValidTarget(Target, Skills.skillR.range, true) and RR then
		UltD = ((getDmg("R", Target, myHero)) or 0)	
			if Target.health < UltD *0.8 then
				RCast(Target)
			end
	end	
end

--SBTW Combo [WIP]--
function SBTWCombo()
	--If Q Enabled--
	if ValidTarget(Target, Skills.skillQ.range, true) and QR then
		if Menu.SBTWCombo.ComboQ then
			QCast(Target)
		end
	end
	--If W Enabled--
	if ValidTarget(Target, Skills.skillW.range, true) and WR then
		if Menu.SBTWCombo.ComboW then
			WCast(Target)
		end
	end
end

--Get Targets--
function GetCustomTarget()
	targetSelect:update()
    if _G.MMA_Target and _G.MMA_Target.type == myHero.type
		then return _G.MMA_Target
   	elseif _G.AutoCarry and _G.AutoCarry.Crosshair and _G.AutoCarry.Attack_Crosshair
		then return _G.AutoCarry.Attack_Crosshair.target
   	elseif targetSelect.target and not targetSelect.target.dead and targetSelect.target.type  == "obj_AI_Hero"
		then return targetSelect.target
    else
    	return nil
    end
end

--Q Cast--
function QCast (Target)
	if VIP_USER then
    local QPosition, QHitChance = VPred:GetLineCastPosition(Target, Skills.skillQ.delay, Skills.skillQ.width, Skills.skillQ.range, Skills.skillQ.speed, myHero, true)
    if QPosition ~= nil and myHero:CanUseSpell(_Q) == READY and GetDistance(QPosition) < Skills.skillQ.range and QHitChance >= 2 then
      CastSpell(_Q, QPosition.x, QPosition.z)
		end
  else
    local QPosition = PredQ:GetPrediction(Target)

    if QPosition ~= nil and GetDistance(QPosition) < Skills.skillQ.range and myHero:CanUseSpell(_Q) == READY and not GetMinionCollision(myHero, QPosition, Skills.skillQ.width) then
      CastSpell(_Q, QPosition.x, QPosition.z)
    end
  end
end

--W Cast--
function WCast (Target)
	if VIP_USER then
    local WPosition, WHitChance = VPred:GetLineCastPosition(Target, Skills.skillW.delay, Skills.skillW.width, Skills.skillW.range, Skills.skillW.speed, myHero, true)
    if WPosition ~= nil and myHero:CanUseSpell(_W) == READY and GetDistance(WPosition) < Skills.skillW.range and WHitChance >= 2 then
      CastSpell(_W, WPosition.x, WPosition.z)
		end
  else
    local WPosition = PredW:GetPrediction(Target)

    if WPosition ~= nil and GetDistance(WPosition) < Skills.skillW.range and myHero:CanUseSpell(_W) == READY then
      CastSpell(_W, WPosition.x, WPosition.z)
    end
  end
end

--R Cast--
function RCast (Target)
	if VIP_USER then
    local RPosition, RHitChance = VPred:GetLineCastPosition(Target, Skills.skillR.delay, Skills.skillR.width, Skills.skillR.range, Skills.skillR.speed, myHero, false)

    if RPosition ~= nil and GetDistance(RPosition) < Skills.skillR.range and myHero:CanUseSpell(_R) == READY and RHitChance >= 2 then
      CastSpell(_R, RPosition.x, RPosition.z)
    end
  else
    local RPosition = RPrediction:GetPrediction(Target)

    if RPosition ~= nil and GetDistance(RPosition) < Skills.skillR.range and myHero:CanUseSpell(_R) == READY then
      CastSpell(_R, RPosition.x, RPosition.z)
    end
  end
end

--Auto Ignite--
function AutoIgnite(Targ, IgniteDam)
	if GetDistance(Targ) <= 600 and Targ.health < IgniteDam and SIgnite ~= nil then
		if IR then 
			CastSpell(SIgnite, Targ) 
		end
	end
end

--Check If Ignite--
function CheckI()
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then
			SIgnite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
			SIgnite = SUMMONER_2
	end
end

--Damage Calculation & Display--
--To Be Added in v0.2--

--Construct Settings Menu--
function AddMenu()

	--Main Directory
	Menu = scriptConfig("SynfiniteEzreal [v"..Version.."]", "SynfiniteEzreal")
	
	--Sub Menus--
	Menu:addSubMenu("[SynfiniteEzreal] Drawing Settings", "Drawings")
	Menu:addSubMenu("[SynfiniteEzreal] QuickCast Settings", "QuickCast")
	Menu:addSubMenu("[SynfiniteEzreal] Harass Settings", "Harass")
	Menu:addSubMenu("[SynfiniteEzreal] SBTWCombo Settings", "SBTWCombo")
	Menu:addSubMenu("[SynfiniteEzreal] Orbwalk Settings", "Orbwalk")
	-- SOW-Orbwalking --
	theSOW:LoadToMenu(Menu.Orbwalk)
	
	--Drawing Menu--
	Menu.Drawings:addParam("DrawA", "   [A] Auto Attack Range", SCRIPT_PARAM_ONOFF, true)
	Menu.Drawings:addParam("DrawQ", "   [Q] Mystic Shot Range", SCRIPT_PARAM_ONOFF, true)
	Menu.Drawings:addParam("DrawW", "   [W] Essence Flux Range", SCRIPT_PARAM_ONOFF, true)
	Menu.Drawings:addParam("NoLagToggle", "   [Draw Lag-Free Circles]", SCRIPT_PARAM_ONOFF, false)
	
	--QuickCast Menu--
	Menu.QuickCast:addParam("AutoE", "   [QC] Arcane Shift", SCRIPT_PARAM_ONKEYDOWN, false,GetKey("E"))
	Menu.QuickCast:addParam("AutoI", "   [QC] Ignite Killables", SCRIPT_PARAM_ONOFF, true)
	Menu.QuickCast:addParam("AutoR", "   [QC] Auto Ult Killables", SCRIPT_PARAM_ONOFF, true)
	
	--Harass Menu--
	Menu.Harass:addParam("HarassQ", "   [Q] Use Mystic Shot", SCRIPT_PARAM_ONOFF, true)
	Menu.Harass:addParam("HarassW", "   [W] Use Essence Flux", SCRIPT_PARAM_ONOFF, false)
	
	--SBTWCombo Menu--
	Menu.SBTWCombo:addParam("ComboQ", "   [Q] Use Mystic Shot", SCRIPT_PARAM_ONOFF, true)
	Menu.SBTWCombo:addParam("ComboW", "   [W] Use Essence Flux", SCRIPT_PARAM_ONOFF, true)
	
	--Target Selector--
	Menu:addTS(targetSelect)
	
end
