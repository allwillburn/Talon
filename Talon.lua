local ver = "0.01"


if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end


if GetObjectName(GetMyHero()) ~= "Talon" then return end


require("DamageLib")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/Talon/master/Talon.lua', SCRIPT_PATH .. 'Talon.lua', function() PrintChat('<font color = "#00FFFF">Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/Talon/master/Talon.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local TalonMenu = Menu("Talon", "Talon")

TalonMenu:SubMenu("Combo", "Combo")

TalonMenu.Combo:Boolean("Q", "Use Q in combo", true)
TalonMenu.Combo:Boolean("W", "Use W in combo", true)
TalonMenu.Combo:Boolean("R", "Use R in combo", true)
TalonMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
TalonMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
TalonMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
TalonMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
TalonMenu.Combo:Boolean("RHydra", "Use RHydra", true)
TalonMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
TalonMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
TalonMenu.Combo:Boolean("Randuins", "Use Randuins", true)


TalonMenu:SubMenu("AutoMode", "AutoMode")
TalonMenu.AutoMode:Boolean("Level", "Auto level spells", false)
TalonMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
TalonMenu.AutoMode:Boolean("Q", "Auto Q", false)
TalonMenu.AutoMode:Boolean("W", "Auto W", false)
TalonMenu.AutoMode:Boolean("R", "Auto R", false)

TalonMenu:SubMenu("LaneClear", "LaneClear")
TalonMenu.LaneClear:Boolean("Q", "Use Q", true)
TalonMenu.LaneClear:Boolean("W", "Use W", true)
TalonMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
TalonMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

TalonMenu:SubMenu("Harass", "Harass")
TalonMenu.Harass:Boolean("Q", "Use Q", true)
TalonMenu.Harass:Boolean("W", "Use W", true)

TalonMenu:SubMenu("KillSteal", "KillSteal")
TalonMenu.KillSteal:Boolean("Q", "KS w Q", true)


TalonMenu:SubMenu("AutoIgnite", "AutoIgnite")
TalonMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

TalonMenu:SubMenu("Drawings", "Drawings")
TalonMenu.Drawings:Boolean("DQ", "Draw Q Range", true)

TalonMenu:SubMenu("SkinChanger", "SkinChanger")
TalonMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
TalonMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)

	--AUTO LEVEL UP
	if TalonMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
          if Mix:Mode() == "Harass" then
            if TalonMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 550) then
				if target ~= nil then 
                                      CastTargetSpell(target, _Q)
                                end
            end

            if TalonMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 700) then
				CastSkillShot(_W, target)
            end     
          end

	--COMBO
	  if Mix:Mode() == "Combo" then
            if TalonMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if TalonMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if TalonMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if TalonMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 700) then
			 CastTargetSpell(target, Cutlass)
            end

            

            if TalonMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 550) then
		     if target ~= nil then 
                         CastTargetSpell(target, _Q)
                     end
            end

            if TalonMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if TalonMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end

            if TalonMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if TalonMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 700) then
			CastSkillShot(_W, target)
	    end
	    
	    
            if TalonMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 500) and (EnemiesAround(myHeroPos(), 500) >= TalonMenu.Combo.RX:Value()) then
			CastSpell(_R)
            end

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 550) and TalonMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastTargetSpell(target, _Q)
		         end
                end 

                
      end

      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if TalonMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 550) then
	        	CastTargetSpell(closeminion, _Q)
                end

                if TalonMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 700) then
	        	CastSkillShot(_W, target)
	        end

                

                if TalonMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if TalonMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end
        --AutoMode
        if TalonMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 550) then
		      CastTargetSpell(target, _Q)
          end
        end 
        if TalonMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 700) then
	  	      CastSkillShot(_W, target)
          end
        end
        
        if TalonMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, 500) then
		      CastSpell(_R)
	  end
        end
                
	--AUTO GHOST
	if TalonMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if TalonMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 550, 0, 200, GoS.Red)
	end

end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
       
        if unit.isMe and spell.name:lower():find("Talonempowertwo") then 
		Mix:ResetAA()	
	end        

        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	
               
        if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		Mix:ResetAA()
	end

end) 


local function SkinChanger()
	if TalonMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Talon</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')





