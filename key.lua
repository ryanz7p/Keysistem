
--[[
    ================================================================
    [ OYB OFFICIAL | ROBLOX DEVELOPER ]
    Website: https://oybofficial.com/
    Builder: https://oybofficial.com/keysystem
    YouTube: https://youtube.com/@OYBOfficial
    Discord: https://discord.gg/kT55J724BK
    ================================================================
]]

-- ⚠️ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) ⚠️

local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "Test",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "Farm Tycoon"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- 👇 YOUR MAIN SCRIPT CODE STARTS HERE 👇
-------------------------------------------------------------------------------

print(ProtectionConfig.HubName .. " Loaded Successfully!")


local P=game:GetService("Players")local R=game:GetService("ReplicatedStorage")local W=game:GetService("Workspace")local pl=P.LocalPlayer local pg=pl:WaitForChild("PlayerGui")
local BC=0.3 local BUF="\019\000"
local S={b=true,t=false,c=false,r=false,st=""}local E={on=false,sp=150}
local MK={"money","cash","dinero"}local VK={"view","follow","segui","subs","inscri"}
local function nm(x,k)x=string.lower(x or"")for _,v in ipairs(k)do if x:find(v,1,true)then return true end end end
local function fv(k,t)local d=pl:FindFirstChild("DataFolder")
if d then for _,c in ipairs(d:GetChildren())do if c:IsA("ValueBase")and nm(c.Name,k)then return tonumber(c.Value)or 0 end end end
ls=pl:FindFirstChild("leaderstats")if ls then for _,c in ipairs(ls:GetChildren())do if nm(c.Name,k)then return tonumber(c.Value)or 0 end end end
if t then local va=t:FindFirstChild("Values")if va then for _,c in ipairs(va:GetChildren())do if c:IsA("ValueBase")and nm(c.Name,k)then return tonumber(c.Value)or 0 end end end end
return 0 end
local function gm()return fv(MK)end local function gv(t)return fv(VK,t)end
local function gt()
local a=W:FindFirstChild("GameAssents")local y=a and a:FindFirstChild("Tycoons")if not y then return nil end
local t=y:FindFirstChild("Tycoon"..pl.UserId)if t then return t end
for _,t2 in ipairs(y:GetChildren())do
local va=t2:FindFirstChild("Values")local own=va and va:FindFirstChild("Owner")
if own and own:IsA("ValueBase")and tostring(own.Value)==pl.Name then return t2 end end
return nil end
local function tpAll(part)
if not part or not part:IsA("BasePart")or not firetouchinterest then return end
local char=pl.Character if not char then return end
for _,n in ipairs({"HumanoidRootPart","LeftFoot","RightFoot","LeftLeg","RightLeg","UpperTorso","LowerTorso"})do
local p=char:FindFirstChild(n)
if p and p:IsA("BasePart")then pcall(firetouchinterest,p,part,0)pcall(firetouchinterest,p,part,1)end end end
local function by(b)
if not b then return end
if b:IsA("BasePart")then tpAll(b)return end
local pp=b.PrimaryPart if pp then tpAll(pp)return end
for _,d in ipairs(b:GetChildren())do if d:IsA("BasePart")then tpAll(d)return end end end
local function classify(b,t)
local forced=b:GetAttribute("_ac")
for _,k in ipairs({"ViewersPrice","FollowersPrice","ViewersCost","FollowersCost"})do
local v=b:GetAttribute(k)if type(v)=="number"and v>0 then return"v",v end end
local mp=nil
for _,k in ipairs({"Price","Cost","MoneyPrice"})do
local v=b:GetAttribute(k)if type(v)=="number"and v>0 then mp=v break end end
local req=nil
for _,k in ipairs({"Requisito","Requirement","Req"})do
local v=b:GetAttribute(k)if type(v)=="number"and v>0 then req=v break end end
for k,v in pairs(b:GetAttributes())do if type(v)=="number"and v>0 and nm(k,VK)then return"v",v end end
for _,d in ipairs(b:GetDescendants())do
if d:IsA("ValueBase")and type(d.Value)=="number"and d.Value>0 and nm(d.Name,VK)then return"v",d.Value end end
local learned=b:GetAttribute("_ap")
if forced=="v"then return"v",(req or mp or learned or 0)end
if forced=="m"then return"m",(mp or req or learned or 0)end
if req then
local m=gm()local v=t and gv(t)or 0
if req>10*m then return"v",req end
if v>=req then return"v",req end
if m>=req then return"m",req end
return"v",req end
if mp then return"m",mp end
return"u",nil end
local LT,FU,FC={},{},{}
local failCount={}
local lastSaldoM,lastSaldoV=0,0
local function recordFail(b)
failCount[b]=(failCount[b]or 0)+1
local n=failCount[b]
local wait=n>=5 and 1800 or n==4 and 600 or n==3 and 300 or n==2 and 60 or 30
FU[b]=math.max(FU[b]or 0,tick()+wait)end
local function resetFailIfSaldoMudou()
local t=gt()if not t then return end
local m,v=gm(),gv(t)
local mudou=false
if lastSaldoM>0 and math.abs(m-lastSaldoM)>math.max(lastSaldoM*0.2,50000)then mudou=true end
if lastSaldoV>0 and math.abs(v-lastSaldoV)>math.max(lastSaldoV*0.2,50000)then mudou=true end
if mudou then for k in pairs(failCount)do failCount[k]=nil end end
lastSaldoM,lastSaldoV=m,v end
local function resetCache()
for k in pairs(FU)do FU[k]=nil end for k in pairs(LT)do LT[k]=nil end for k in pairs(FC)do FC[k]=nil end
for k in pairs(failCount)do failCount[k]=nil end
local t=gt()if not t then return end
for _,d in ipairs(t:GetDescendants())do d:SetAttribute("_ac",nil)d:SetAttribute("_ap",nil)end end
local function fe()local r=R:FindFirstChild("ByteNetReliable")if r then pcall(function()r:FireServer(buffer.fromstring(BUF))end)end end
task.spawn(function()while true do task.wait(E.sp/1000)if E.on then fe()end end end)
local function findZone(t)local best,bs=nil,0
for _,d in ipairs(t:GetDescendants())do if d:IsA("BasePart")then
local n=string.lower(d.Name)local sc=0
if n:find("zone")or n:find("circl")or n:find("area")or n:find("trig")or n:find("capt")or n:find("green")then sc=sc+10 end
if d:IsA("Part")and d.Shape==Enum.PartType.Cylinder then sc=sc+5 end
if d.CanTouch then sc=sc+2 end
if sc>bs then bs=sc best=d end end end return best end
local function capture()
if not S.t then return end
local char=pl.Character local hrp=char and char:FindFirstChild("HumanoidRootPart")if not hrp then return end
local hum=char:FindFirstChildOfClass("Humanoid")
local wasSeated=hum and hum.Sit
if wasSeated then pcall(function()hum.Sit=false end)task.wait(0.05)end
local tw=W:FindFirstChild("Torres")
if not tw then if wasSeated and hum then pcall(function()hum.Sit=true end)end return end
for _,torre in ipairs(tw:GetChildren())do if not S.t then break end
if torre:IsA("Model")and string.lower(torre.Name):find("torre")then
local own=torre:FindFirstChild("Owner")
local isMine=own and own:IsA("ValueBase")and tostring(own.Value)==pl.Name
if not isMine then
local zone=findZone(torre)if not zone then break end
local saved=hrp.CFrame
hrp.CFrame=CFrame.new(zone.Position+Vector3.new(0,4,0))
pcall(firetouchinterest,hrp,zone,0)
local t0=tick()local ok=false
while S.t and tick()-t0<30 do task.wait(0.4)
if own and own:IsA("ValueBase")and tostring(own.Value)==pl.Name then ok=true break end end
pcall(firetouchinterest,hrp,zone,1)hrp.CFrame=saved
if ok then break end end end end
if wasSeated and hum then pcall(function()hum.Sit=true end)end end
local collectFails=0
local function getMTC()local t=gt()if not t then return 0 end local v=t:FindFirstChild("Values")local m=v and v:FindFirstChild("MoneyToCollect")return m and tonumber(m.Value)or 0 end
local function getCashParts()
local t=gt()if not t then return{}end
local core=t:FindFirstChild("CoreItems")if not core then return{}end
local cb=core:FindFirstChild("CashButton")if not cb then return{}end
local list={}
if cb:IsA("BasePart")then list[#list+1]=cb end
local pp=cb:IsA("Model")and cb.PrimaryPart
if pp then list[#list+1]=pp end
for _,d in ipairs(cb:GetDescendants())do if d:IsA("BasePart")and d.CanTouch and d~=pp then list[#list+1]=d end end
return list end
local function collect()
if not S.c then return end
local char=pl.Character local hrp=char and char:FindFirstChild("HumanoidRootPart")if not hrp then return end
local hum=char:FindFirstChildOfClass("Humanoid")
local wasSeated=hum and hum.Sit
if wasSeated then pcall(function()hum.Sit=false end)task.wait(0.05)end
local mtc0=getMTC()local m0=gm()
if mtc0<=0 then collectFails=0 if wasSeated and hum then pcall(function()hum.Sit=true end)end return end
local parts=getCashParts()
if #parts==0 then if wasSeated and hum then pcall(function()hum.Sit=true end)end return end
local saved=hrp.CFrame
for _,col in ipairs(parts)do if not S.c then break end
local topY=col.Position.Y+col.Size.Y/2
hrp.CFrame=CFrame.new(col.Position.X,topY+2.5,col.Position.Z)
task.wait(0.08)tpAll(col)task.wait(0.05)hrp.CFrame=saved task.wait(0.05)
local mtc=getMTC()local m=gm()
if mtc<mtc0 or m>m0 then S.st="coletado +"..(mtc0-mtc).."M"collectFails=0 if wasSeated and hum then pcall(function()hum.Sit=true end)end return end end
if wasSeated and hum then pcall(function()hum.Sit=true end)end
collectFails=collectFails+1 S.st="falhou "..collectFails.."/5"
if collectFails>=5 then S.c=false S.st="PAROU" collectFails=0 end end
local REB={"DoRebirth","Rebirth","RebirthMulti","MansionRebirth"}
local lastRebirth=0 local lastPend=0 local pendStable=0 local completeSince=0
local lastRank=0 local lastTycoon=nil local nilSince=0
local function countPend()
local t=gt()if not t then return 999 end
local bo=t:FindFirstChild("Botones")if not bo then return 999 end
local m,v=gm(),gv(t)local n=0
for _,f in ipairs(bo:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then
for _,b in ipairs(f:GetChildren())do if b:GetAttribute("Buyable")==true then
local cur,pr=classify(b,t)
if cur=="m"and pr and m>=pr then n=n+1
elseif cur=="v"and pr and v>=pr then n=n+1 end end end end end
return n end
local function tryRemote(name)
local ev=R:FindFirstChild("Events")if not ev then return false end
local rem=ev:FindFirstChild(name)if not rem then return false end
pcall(function()
if rem:IsA("RemoteEvent")then rem:FireServer()
elseif rem:IsA("RemoteFunction")then rem:InvokeServer()end end)return true end
local function tryRebirth()
if not S.r then return end
local pend=countPend()
if pend==lastPend then if pendStable==0 then pendStable=tick()end
else pendStable=tick()lastPend=pend end
local stuck=pendStable>0 and(tick()-pendStable)or 0
if pend>0 and stuck<60 then S.st="esperando "..pend.." ("..math.floor(stuck).."s)" completeSince=0 return end
if pend>0 then S.st="travado "..pend.." - forcando"else
if completeSince==0 then completeSince=tick()S.st="OK! 5s..." return end
if tick()-completeSince<5 then S.st="OK ("..math.floor(tick()-completeSince).."/5s)" return end end
if tick()-lastRebirth<5 then return end
lastRebirth=tick()
local rank0=pl:GetAttribute("RebirthRank")or 0
S.st="REBIRTH..."
local ok=false
for _,name in ipairs(REB)do if not S.r then break end
tryRemote(name)task.wait(1.5)
local rank1=pl:GetAttribute("RebirthRank")or 0
if rank1>rank0 then S.st="REBIRTH! "..rank0.."->"..rank1 print("[Auto] REBIRTH "..rank0.."->"..rank1)ok=true break end end
if ok then task.wait(2)resetCache()lastRank=pl:GetAttribute("RebirthRank")or 0 lastTycoon=nil
else S.st="falhou (rank "..rank0..")" end
completeSince=0 pendStable=0 lastPend=0 end
task.spawn(function()
lastRank=pl:GetAttribute("RebirthRank")or 0
while true do task.wait(1.5)
local r=pl:GetAttribute("RebirthRank")or 0
if r~=lastRank then lastRank=r resetCache()lastTycoon=nil end
local t=gt()
if t then
if lastTycoon and t.Name~=lastTycoon then resetCache()end
lastTycoon=t.Name nilSince=0
else if nilSince==0 then nilSince=tick()end
if tick()-nilSince>5 then resetCache()lastTycoon=nil nilSince=tick()end end end end)
local function tryBuyM(b,t,pr)
if gm()<pr then return false,"skip"end
local m0,v0=gm(),gv(t)
by(b)
task.wait(0.15)
local m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true then return true end
if m1<m0 then return true end
if v1<v0 then return "reclass_v",v0-v1 end
task.wait(0.2)
m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true or m1<m0 then return true end
if v1<v0 then return "reclass_v",v0-v1 end
task.wait(0.25)
m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true or m1<m0 then return true end
if v1<v0 then return "reclass_v",v0-v1 end
return false end
local function tryBuyV(b,t,pr)
if gv(t)<pr then return false,"skip"end
local m0,v0=gm(),gv(t)
by(b)
task.wait(0.15)
local m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true then return true end
if v1<v0 then return true end
if m1<m0 then return "reclass_m",m0-m1 end
task.wait(0.2)
m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true or v1<v0 then return true end
if m1<m0 then return "reclass_m",m0-m1 end
task.wait(0.25)
m1,v1=gm(),gv(t)
if b:GetAttribute("Buyable")~=true or v1<v0 then return true end
if m1<m0 then return "reclass_m",m0-m1 end
return false end
local function processMoney(t,bo)
local m=gm()
local list={}
for _,f in ipairs(bo:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then
for _,b in ipairs(f:GetChildren())do
if b:GetAttribute("Buyable")==true and not(FU[b]and tick()<FU[b])and(not LT[b]or tick()-LT[b]>BC)then
local cur,pr=classify(b,t)
if cur=="m"and pr and m>=pr then list[#list+1]={b=b,pr=pr}end end end end end
table.sort(list,function(a,b)return a.pr<b.pr end)
local bx=0
for _,it in ipairs(list)do if not S.b then return bx end
local ok,why=tryBuyM(it.b,t,it.pr)
if ok==true then LT[it.b]=tick()FC[it.b]=nil bx=bx+1 m=gm()failCount[it.b]=nil
elseif ok=="reclass_v" then it.b:SetAttribute("_ac","v")it.b:SetAttribute("_ap",why)FU[it.b]=nil FC[it.b]=nil failCount[it.b]=nil
elseif why=="skip"then FU[it.b]=tick()+30
else recordFail(it.b) end end
return bx end
local function processViewers(t,bo)
local v=gv(t)
local list={}
for _,f in ipairs(bo:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then
for _,b in ipairs(f:GetChildren())do
if b:GetAttribute("Buyable")==true and not(FU[b]and tick()<FU[b])and(not LT[b]or tick()-LT[b]>BC)then
local cur,pr=classify(b,t)
if cur=="v"and pr and v>=pr then list[#list+1]={b=b,pr=pr}end end end end end
table.sort(list,function(a,b)return a.pr<b.pr end)
local bx=0
for _,it in ipairs(list)do if not S.b then return bx end
local ok,why=tryBuyV(it.b,t,it.pr)
if ok==true then LT[it.b]=tick()FC[it.b]=nil bx=bx+1 v=gv(t)failCount[it.b]=nil
elseif ok=="reclass_m" then it.b:SetAttribute("_ac","m")it.b:SetAttribute("_ap",why)FU[it.b]=nil FC[it.b]=nil failCount[it.b]=nil
elseif why=="skip"then FU[it.b]=tick()+30
else recordFail(it.b) end end
return bx end
local lastLog=0 local lastBought=0
local function cy()
local t=gt()if not t then S.st="sem tycoon" return end
local bo=t:FindFirstChild("Botones")if not bo then S.st="sem Botones" return end
if not S.b then return end
resetFailIfSaldoMudou()
local char=pl.Character local hum=char and char:FindFirstChildOfClass("Humanoid")
local seated=hum and hum.Sit
local bxM,bxV=0,0
if seated then
local m,v=gm(),gv(t)
local hasBuyable=false
for _,f in ipairs(bo:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then
for _,b in ipairs(f:GetChildren())do
if b:GetAttribute("Buyable")==true then
local cur,pr=classify(b,t)
if cur and pr and((cur=="m"and m>=pr)or(cur=="v"and v>=pr))then hasBuyable=true break end end end end if hasBuyable then break end end
if not hasBuyable then S.st="(sentado) nada compravel" return end
local seatPart=hum.SeatPart
pcall(function()hum.Sit=false end)task.wait(0.06)
bxM=processMoney(t,bo)bxV=processViewers(t,bo)
task.wait(0.03)
if seatPart and seatPart.Parent then pcall(function()hum.Sit=true end)end
else bxM=processMoney(t,bo)bxV=processViewers(t,bo)end
lastBought=bxM+bxV
if tick()-lastLog>=5 then
lastLog=tick()
local tot,buy,nm_,nv=0,0,0,0
for _,f in ipairs(bo:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then
for _,b in ipairs(f:GetChildren())do tot=tot+1
if b:GetAttribute("Buyable")==true then buy=buy+1
local cur=classify(b,t)
if cur=="m"then nm_=nm_+1 elseif cur=="v"then nv=nv+1 end end end end end
local tag=seated and"(SENT) "or""
local rank=pl:GetAttribute("RebirthRank")or 0
local fcTotal=0
for _ in pairs(failCount)do fcTotal=fcTotal+1 end
print("[Auto] "..tag.."M="..gm().." V="..gv(t).." R="..rank.." | Buy="..buy.." m="..nm_.." v="..nv.." | +M="..bxM.." +V="..bxV.." | fails="..fcTotal)end
local tag=seated and"(sentado) "or""
if lastBought>0 then S.st=tag.."M+"..bxM.." V+"..bxV else S.st=tag.."aguardando" end end
task.spawn(function()
local idle=0
while true do
if not S.b then task.wait(0.5)else
pcall(cy)
local char=pl.Character local hum=char and char:FindFirstChildOfClass("Humanoid")
local seated=hum and hum.Sit
if seated then task.wait(1)idle=0
elseif lastBought>0 then task.wait(0.03)idle=0
else idle=idle+1 task.wait(math.min(0.5,0.05*idle))end end end end)
task.spawn(function()while task.wait(2)do local now=tick()for k,t in pairs(FU)do if now>=t then FU[k]=nil end end end end)
task.spawn(function()while task.wait(3)do pcall(capture)end end)
task.spawn(function()while task.wait(1.2)do pcall(collect)end end)
task.spawn(function()while task.wait(5)do pcall(tryRebirth)end end)
pcall(function()local o=pg:FindFirstChild("AG")if o then o:Destroy()end end)
local g=Instance.new("ScreenGui")g.Name="AG"g.ResetOnSpawn=false g.Parent=pg
local f=Instance.new("Frame")f.Size=UDim2.new(0,250,0,236)f.Position=UDim2.new(0,20,0,20)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=0 f.Draggable=true f.Active=true f.Parent=g
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local function tg(y,t,gt,st,c)local b=Instance.new("TextButton")b.Size=UDim2.new(1,-16,0,26)b.Position=UDim2.new(0,8,0,y)
b.BackgroundColor3=gt()and c or Color3.fromRGB(75,75,90)b.Text=t..(gt()and"  ON"or"  OFF")b.Font=Enum.Font.GothamBold b.TextSize=12 b.TextColor3=Color3.new(1,1,1)b.BorderSizePixel=0 b.Parent=f
Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)
b.MouseButton1Click:Connect(function()st(not gt())b.Text=t..(gt()and"  ON"or"  OFF")b.BackgroundColor3=gt()and c or Color3.fromRGB(75,75,90)end)end
tg(8,"Auto Comprar",function()return S.b end,function(v)S.b=v end,Color3.fromRGB(60,170,90))
tg(40,"Auto Coletar",function()return S.c end,function(v)S.c=v collectFails=0 end,Color3.fromRGB(80,180,80))
tg(72,"Auto Torres",function()return S.t end,function(v)S.t=v end,Color3.fromRGB(100,160,220))
tg(104,"Auto Rebirth",function()return S.r end,function(v)S.r=v lastRebirth=0 completeSince=0 pendStable=0 lastPend=0 end,Color3.fromRGB(255,180,60))
tg(136,"Auto Edit",function()return E.on end,function(v)E.on=v end,Color3.fromRGB(220,100,100))
local sb={}
for i,sp in ipairs({500,150,50})do local b=Instance.new("TextButton")b.Size=UDim2.new(0,58,0,20)b.Position=UDim2.new(0,8+(i-1)*62,0,170)
b.BackgroundColor3=(E.sp==sp)and Color3.fromRGB(200,150,60)or Color3.fromRGB(75,75,90)b.Text=tostring(sp).."ms"b.Font=Enum.Font.GothamBold b.TextSize=10 b.TextColor3=Color3.new(1,1,1)b.BorderSizePixel=0 b.Parent=f
Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)sb[sp]=b
b.MouseButton1Click:Connect(function()E.sp=sp for v,bb in pairs(sb)do bb.BackgroundColor3=(E.sp==v)and Color3.fromRGB(200,150,60)or Color3.fromRGB(75,75,90)end end)end
local st=Instance.new("TextLabel")st.Size=UDim2.new(1,-16,0,32)st.Position=UDim2.new(0,8,0,206)
st.BackgroundTransparency=1 st.Font=Enum.Font.Code st.TextSize=10 st.TextColor3=Color3.fromRGB(180,220,180)st.TextXAlignment=Enum.TextXAlignment.Left st.Text="aguardando"st.Parent=f
st.TextWrapped=true
local x=Instance.new("TextButton")x.Size=UDim2.new(0,20,0,20)x.Position=UDim2.new(1,-24,0,4)
x.BackgroundColor3=Color3.fromRGB(200,55,55)x.Text="X"x.TextColor3=Color3.new(1,1,1)x.Font=Enum.Font.GothamBold x.TextSize=11 x.BorderSizePixel=0 x.Parent=f
Instance.new("UICorner",x).CornerRadius=UDim.new(0,4)
x.MouseButton1Click:Connect(function()g.Enabled=false S.b=false S.c=false S.t=false S.r=false E.on=false end)
task.spawn(function()while g.Parent and task.wait(.3)do st.Text=S.st==""and"aguardando"or S.st end end)
print("[Auto] v64 limpo - sem key system")
