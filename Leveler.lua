local SLUtility = 0.13
local SLUPatchnew = nil
local Updater = true
if GetGameVersion():sub(3,4) >= "10" then
		SLUPatchnew = GetGameVersion():sub(1,5)
	else
		SLUPatchnew = GetGameVersion():sub(1,3)
end

require 'OpenPredict'

local charName = myHero.charName

Callback.Add("Load", function()	
	SLUtilityUpdater()
	Initi()
	
	PrintChat("<font color=\"#fd8b12\"><b>["..SLUPatchnew.."] [SL-Utility] v.: "..SLUtility.." - <font color=\"#F2EE00\"> Loaded </b></font>")
	
	if SLU.Load.LAL:Value() then
		AutoLevel()
	end


class 'Initi'

function Initi:__init()

	SLU = MenuConfig("SL-Utility", "["..SLUPatchnew.."][v.:"..SLUtility.."] SL-Utility")
	SLU:Menu("Load", "|SL| Loader")
	SLU.Load:Boolean("LAL", "Load AutoLevel", true)
	SLU.Load:Info("0.3", "")
	SLU.Load:Info("0.4.", "You will have to press 2f6")
	SLU.Load:Info("0.5.", "to apply the changes")
	
	SLU:Menu("Activator", "|SL| Activator")
	M = SLU["Activator"]
	
end

function AutoLevel:__init()
	SLU:SubMenu(charName.."AL", "|SL| Auto Level")
	SLU[charName.."AL"]:Boolean("aL", "Use AutoLvl", false)
	SLU[charName.."AL"]:DropDown("aLS", "AutoLvL", 1, {"Q-W-E","Q-E-W","W-Q-E","W-E-Q","E-Q-W","E-W-Q"})
	SLU[charName.."AL"]:Slider("sL", "Start AutoLvl with LvL x", 4, 1, 18, 1)
	SLU[charName.."AL"]:Boolean("hL", "Humanize LvLUP", true)
	SLU[charName.."AL"]:Slider("hT", "Humanize min delay", .5, 0, 1, .1)
	SLU[charName.."AL"]:Slider("hF", "Humanize time frame", .2, 0, .5, .1)
	
	--AutoLvl
	self.lTable={
	[1] = {_Q,_W,_E,_Q,_Q,_R,_Q,_W,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E}, 
	[2] = {_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W},
	[3] = {_W,_Q,_E,_W,_W,_R,_W,_Q,_W,_Q,_R,_Q,_Q,_E,_E,_R,_E,_E},
	[4] = {_W,_E,_Q,_W,_W,_R,_W,_E,_W,_E,_R,_E,_E,_Q,_Q,_R,_Q,_Q},
	[5] = {_E,_Q,_W,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W},
	[6] = {_E,_W,_Q,_E,_E,_R,_E,_W,_E,_W,_R,_W,_W,_Q,_Q,_R,_Q,_Q}, 
	}
	
	Callback.Add("Tick", function() self:Do() end)
end

function AutoLevel:Do()
	if SLU[charName.."AL"].aL:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= SLU[charName.."AL"].sL:Value() then
		if SLU[charName.."AL"].hL:Value() then
			DelayAction(function() LevelSpell(self.lTable[SLU[charName.."AL"].aLS:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]or nil) end, math.random(SLU[charName.."AL"].hT:Value(),SLU[charName.."AL"].hT:Value()+SLU[charName.."AL"].hF:Value()))
		else
			LevelSpell(self.lTable[SLU[charName.."AL"].aLS:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]or nil)
		end
	end
end

