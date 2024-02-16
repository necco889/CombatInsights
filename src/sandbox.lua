CombatInsightsSandbox = CombatInsightsSandbox or {}
local Sandbox = CombatInsightsSandbox
local CompareTable = CombatInsightsCompareTable
local Analysis = CombatInsightsAnalysis
local Targets = CombatInsightsTargets
local Fights = CombatInsightsFights
local Player = CombatInsightsPlayer
local Calculation = CombatInsightsCalculation
-- local Consts = CombatInsightsConsts
local Hit = CombatInsightsHit
-- local UI = CombatInsightsUI
local Utils = CombatInsightsUtils
local Async = LibAsync
local self = CombatInsightsSandbox

local function debugPrint(message, ...)
    df("[CiSandbox]: %s", message:format(...))
end


function Sandbox.Init()
    SLASH_COMMANDS["/ci2"] = Sandbox.Test2
    SLASH_COMMANDS["/ci3"] = Sandbox.Test3
    SLASH_COMMANDS["/ci4"] = Sandbox.Test4
    SLASH_COMMANDS["/ci5"] = Sandbox.Test5
    SLASH_COMMANDS["/ci6"] = Sandbox.Test6
    SLASH_COMMANDS["/ci7"] = Sandbox.Test7
    SLASH_COMMANDS["/ci8"] = Sandbox.Test8
    SLASH_COMMANDS["/ciasd1"] = Sandbox.asd1
    SLASH_COMMANDS["/ciasd2"] = Sandbox.asd2
    SLASH_COMMANDS["/ciasdr1"] = Sandbox.asdr1
    SLASH_COMMANDS["/ciasdr2"] = Sandbox.asdr2
end




local function Test()



    
    local function customiter(a, i)
        local tbl1 = a[2]
        local tbl2 = a[3]
        i[2] = i[2] + 1
        local v1 = tbl1[i[1]]
        local v2 = tbl2[i[2]]
        if v1 and v2 then
            return i,{a[1], v1, v2}
        else
            i[1] = i[1] + 1
            i[2] = 1
            v1 = tbl1[i[1]]
            v2 = tbl2[i[2]]
            if v1 and v2 then
                return i,{a[1], v1, v2}
            end
        end
    end


    local function doubleIpairs(o, t1, t2)
        return customiter, {o, t1, t2}, {1,0}
    end

    local t1 = {0,1,2}
    local t2 = {"a", "b", "c"}
    local o = {}

    print(o)

    print(doubleIpairs(o, t1, t2))


    local function consume(o1,o2,o3)
        print(o)
        print(o2)
        print(o3)
    end

    for i,v in doubleIpairs(o, t1, t2) do
        consume(unpack(v))
        -- print(v[1])
        -- print(v[2])
        -- print(v[3])
        -- print(i[1])
        -- print(i[2])
        -- print("")
    end






    -- replayData.loopdata.startedAt = GetGameTimeMilliseconds()
    -- replayData.taskStartedAt = GetGameTimeMilliseconds()
    self.task = Async:Create("CombatInsightsReplayTask")

    self.task:For(1, 9)
    :Do(function(index) 
        self.task:For(1, 9)
        :Do(function(index2) d("*"..tostring(index)..tostring(index2)) end)
    end)


    -- Targets:Init()
    -- local l = {}
    -- l[1] = Targets:Get(10)
    -- l[2] = Targets:Get(20)
    
    -- l[1] = CompareTable:New()
    -- l[2] = CompareTable:New()
    -- l[1].origNormal = 1
    -- l[2].origNormal = 2
    
    -- d(l)
end


function Sandbox.Test2()
    self.test2 = {}
    self.test2.tbls = {}
    local s = GetGameTimeMilliseconds()
    for i=1,240000 do
        table.insert(self.test2.tbls, CompareTable:New(nil))
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end

function Sandbox.Test3()
    local s = GetGameTimeMilliseconds()
    local sum1 = 0
    local sum2 = 0
    for i=1,240000 do
        local t = self.test2.tbls[i]
        t:Summarize()
        sum1 = sum1 + t.newNormal
        sum2 = sum2 + t.origNormal
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end


function Sandbox.Test4()

    local abilityIds = {
        [123321] = true,
        [1] = true,
        [100] = true,
        [500] = true,
        [890] = true,
        [8190] = true,
        [1890] = true,
        [89011] = true,
        [890011] = true,
        [189011] = true,
        [839011] = true,
        [829011] = true,
    }

    local targetIds = {
        [123321] = true,
        [1] = true,
        [100] = true,
        [500] = true,
        [890] = true,
        [8190] = true,
        [1890] = true,
        [89011] = true,
        [890011] = true,
        [189011] = true,
        [839011] = true,
        [829011] = true,
    }

    local uc = CombatInsightsUptimeCounter:New()

    local s = GetGameTimeMilliseconds()
    for i=1,100000 do
        for t,_ in pairs(targetIds) do
            for a,_ in pairs(abilityIds) do
                uc:NewSample(100, t, a)
            end
        end
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end

function Sandbox.Test5()
    local s = GetGameTimeMilliseconds()
    for i=1,100000 do
        ZO_CachedStrFormat("asjkdjk asdjskjkdsa <<1>> <<2>>", 123, "aaaaaaaaaaaaa")
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end

function Sandbox.Test6()
    local s = GetGameTimeMilliseconds()
    for i=1,100000 do
        zo_strformat("asjkdjk asdjskjkdsa <<1>> <<2>>", 123, "aaaaaaaaaaaaa")
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end

function Sandbox.Test7()
    local s = GetGameTimeMilliseconds()
    for i=1,100000 do
        string.format("asjkdjk asdjskjkdsa %d %s", 123, "aaaaaaaaaaaaa")
    end
    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end



function Sandbox.Test8()

    -- on dummy 
    -- 71 calculation
    -- 16358 hit
    -- 24s
    Sandbox.player = Player:New()
    Sandbox.targets = Targets:New()
    local player = Sandbox.player
    local targets = Sandbox.targets
    player.stats.maxMagicka = 33000
    player.stats.maxStamina = 33000
    player.stats.activeBar = 1
    player.numMediumArmor = 0
    player.numLightArmor = 0
    player.numHeavyArmor = 0
    player.stats.fgbonus[1] = 0
    player.stats.fgbonus[2] = 0
    player:ReCalcBonuses()
    local t = targets:Get(1234)
    local hit = Hit:New(0, 1000, true, 183123, player, t, DAMAGE_TYPE_FIRE)
    Sandbox.hit = hit

    local s = GetGameTimeMilliseconds()
    -- for i=1,100000 do   --6500ms
    -- -- for i=1,1161418 do  --24s
    --     local h = hit:Copy()
    -- end


    -- for i=1,100000 do   --3900  > 1700
    --     local p = player:Copy()
    -- end

    for i=1,100000 do   -- 1280 > 405
        local p = t:Copy()
    end

    debugPrint("took %d", (GetGameTimeMilliseconds() - s))
end




function AdjustLabelForIcon(icon)
    local order = icon.ctrl:GetDrawLevel() + 1
    icon.myLabel:SetDrawLevel( order )
end

function Sandbox.asd1()
    self.icon = OSI.CreatePositionIcon(164524,27700,152492,"SanitysEdgeHelper/icons/squaretwo_green.dds", 2 * OSI.GetIconSize())
end


function Sandbox.asd2()
    local icon = self.icon
    if icon then
        if not icon.myLabel then
          icon.myLabel = icon.ctrl:CreateControl( icon.ctrl:GetName() .. "Label", CT_LABEL )
          icon.myLabel:SetAnchor( CENTER, icon.ctrl, CENTER, 0, 0 )
          icon.myLabel:SetFont( "$(BOLD_FONT)|$(KB_54)|outline" )
          icon.myLabel:SetScale(3)
          icon.myLabel:SetDrawLayer( DL_BACKGROUND )
          icon.myLabel:SetDrawTier( DT_LOW )
          icon.myLabel:SetColor(0.9,0.9,0.9,0.85)
          AdjustLabelForIcon(icon)
          icon.myLabel:SetText( "UwU")
          icon.myLabel:SetHidden( false )
        end
      end 
end

function Sandbox.asdr1()
    OSI.DiscardPositionIcon(self.icon)
end

function Sandbox.asdr2()
    WINDOW_MANAGER:RemoveControl(self.icon.myLabel)
end
