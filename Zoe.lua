if GetObjectName(GetMyHero()) ~= "Zoe" then return end

require("OpenPredict")

Illaoi = Menu("Illaoi", "Illaoi")
Illaoi:SubMenu("QWER", "Cast QWER")
Illaoi.QWER:Key("Q", "Cast Q", string.byte("/"))
Illaoi.QWER:Slider("pQ", "Q Pred", 20, 0, 100, 5)
Illaoi.QWER:Key("W", "Cast W", string.byte("*"))
Illaoi.QWER:Key("E", "Cast E", string.byte("C"))
Illaoi.QWER:Slider("pE", "E Pred", 20, 0, 100, 5)
Illaoi.QWER:Key("R", "Cast R", string.byte("-"))
Illaoi.QWER:Slider("pR", "R Pred", 20, 0, 100, 5)
Illaoi.QWER:Slider("eR", "# Enemies to Cast", 1, 1, 5, 1)

local IllQ = {delay = 0.75, speed = math.huge, width = 160, range = 750}
local IllE = {delay = 0.25, speed = 2000, width = 60, range = 800}
local IllR = {delay = 0.5, speed = math.huge, width = 450, range = 0}

OnTick(function()
	local target = GetCurrentTarget()
	local QPred = GetLinearAOEPrediction(target, IllQ)
	local EPred = GetPrediction(target, IllE)
	local RPred = GetCircularAOEPrediction(target, IllR)
	
	if Illaoi.QWER.Q:Value() and Ready(_Q) and ValidTarget(target, 750) then
		if QPred and QPred.hitChance >= (Illaoi.QWER.pQ:Value()/100) then
			CastSkillShot(_Q, QPred.castPos)
		end
	end
	if Illaoi.QWER.W:Value() and Ready(_W) and ValidTarget(target, 350) then
		CastSpell(_W)
		AttackUnit(target)
	end
	if Illaoi.QWER.E:Value() and Ready(_E) and ValidTarget(target, 800) then
		if EPred and EPred.hitChance >= (Illaoi.QWER.pE:Value()/100) then
			CastSkillShot(_E, EPred.castPos)
		end
	end
	if Illaoi.QWER.R:Value() and Ready(_R) and ValidTarget(target, 450) and EnemiesAround(myhero, 450) >= Illaoi.QWER.eR:Value() then
		if RPred and RPred.hitChance >= (Illaoi.QWER.pR:Value()/100) then
			CastSkillShot(_R, RPred.castPos)
		end
	end
end)
