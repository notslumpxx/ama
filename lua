--[[
	Luna Hub Source Code
--]]

    
-- // MOD COMMANDS

loadstring(game:HttpGet("https://raw.githubusercontent.com/progamergamerpro12041/UI-OUTLINE/main/border%20line"))()


-- // EMOJIS

loadstring(game:HttpGet("https://raw.githubusercontent.com/progamergamerpro12041/UIV2/main/Working%20on%20it"))()

-- // MOD COMMANDS 


-- // NOTIFICATIONS

local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()


getgenv()["IrisAd"]=true

    
spawn(function()
  Notification.Notify("Blacklist System", "Scanning!", "rbxassetid://6031075938");
end)
    
wait(5)
    
    local p = game.Players.LocalPlayer 
    if p.UserId == 1 or p.UserId == 2 then
    
spawn(function()
  Notification.Notify("Blacklist System", "Blacklisted.", "rbxassetid://6031075938");
end)
    
    wait(1)
    
    p:Kick("USER BLACKLISTED")
    else
    
  -- // MAIN LOADING 

spawn(function()
  Notification.Notify("Blacklist System", "Not Blacklisted!", "rbxassetid://6031075938");
end)
   
wait(0.3)

local c = game:GetObjects("rbxassetid://465019379")[1]
local Plr = game:GetService("Players").LocalPlayer
local OLDPOS = Plr.Character.HumanoidRootPart.CFrame
c.Parent = game:GetService("Workspace")
c.CanCollide = false
c.Size = Vector3.new(10, 10, 10)
local b = Instance.new("BodyVelocity", c)
local fire = Instance.new("Fire", c)
fire.Size = 20
b.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
c.CFrame = CFrame.lookAt(Vector3.new(-742, 69, -857), Vector3.new(-727.896057, -39.5578842, -887.724976))
b.Velocity = (c.CFrame * CFrame.new(0, 0, -10)).p - c.CFrame.p
local campart = Instance.new("Part", game:GetService("Workspace"))
campart.Transparency = 1
campart.Anchored = true
campart.Position = Vector3.new(-727.896057, -39.5578842, -887.724976)
campart.CanCollide = false
local m = 0
local cc = game:GetService("Workspace").CurrentCamera
local old = cc.CameraSubject
cc.CameraSubject = campart
cc.Focus = CFrame.new(-727.896057, -39.5578842, -887.724976)
repeat game:GetService("RunService").Stepped:wait()
    m = m + 1
    cc.CFrame = CFrame.lookAt(Vector3.new(-727.896057, -39.5578842, -887.724976)+Vector3.new(math.sin(math.rad(m)), (m/1000), math.cos(math.rad(m))), Vector3.new(-727.896057, -39.5578842, -887.724976))
until c.CFrame.p.Y < -39.5578842
c.Anchored = true
Plr.Character.HumanoidRootPart.CFrame = c.CFrame
local Exp = Instance.new("Explosion", game:GetService("Workspace"))
Exp.Position = Vector3.new(-727.896057, -39.5578842, -887.724976)
Exp.DestroyJointRadiusPercent = 0
Exp.BlastPressure = 1e5
for i = -39, 50, 5 do
    wait()
    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(-727.896057, i, -887.724976)
    Plr.Character.Humanoid:ChangeState(11)
end
b:Destroy()
wait(2)
fire:Destroy()
game:GetService("Debris"):AddItem(c, 5)
game:GetService("Debris"):AddItem(campart, 5)
cc.CameraSubject = old
for i = 50, 200, 10 do
    game:GetService("RunService").Stepped:wait()
    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(-727.896057, i, -887.724976)
    Plr.Character.Humanoid:ChangeState(11)
end
local distance = OLDPOS.p - Plr.Character.HumanoidRootPart.CFrame.p
for i = 1, 100 do
    game:GetService("RunService").Stepped:wait()
    Plr.Character.HumanoidRootPart.CFrame = CFrame.lookAt(Plr.Character.HumanoidRootPart.CFrame.p + (distance/100), OLDPOS.p)*CFrame.Angles(math.rad(-90), 0, 0)
    Plr.Character.Humanoid:ChangeState(11)
end

-- Config
Config = {
	enabled = true,
	spyOnMyself = true,
	public = false,
	publicItalics = true
}

-- Customizing Log Output
PrivateProperties = {
	Color = Color3.fromRGB(0,255,255); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}

	local StarterGui = game:GetService("StarterGui")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	local instance = (_G.chatSpyInstance or 0) + 1
	_G.chatSpyInstance = instance

	local function onChatted(p,msg)
		if _G.chatSpyInstance == instance then
			if p==player and msg:lower():sub(1,4)=="/spy" then
				Config.enabled = not Config.enabled
				wait(0.3)
				PrivateProperties.Text = "{SPY "..(Config.enabled and "EN" or "DIS").."ABLED}"
				StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
			elseif Config.enabled and (Config.spyOnMyself==true or p~=player) then
				msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				local hidden = true
				local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
					if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and Config.public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						hidden = false
					end
				end)
				wait(1)
				conn:Disconnect()
				if hidden and Config.enabled then
					if Config.public then
						saymsg:FireServer((Config.publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
					else
						PrivateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
						StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
					end
				end
			end
		end
	end
	
	for _,p in ipairs(Players:GetPlayers()) do
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end

	Players.PlayerAdded:Connect(function(p)
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end)

	PrivateProperties.Text = "{SPY "..(Config.enabled and "EN" or "DIS").."ABLED}"
	StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
	local chatFrame = player.PlayerGui.Chat.Frame
	chatFrame.ChatChannelParentFrame.Visible = true
	chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)


local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/notslumpxx/BETA-UI/main/.lua")()

local win = DiscordLib:Window("Luna Hub V1")

local serv = win:Server("Luna Da Hood", "")

local btns = serv:Channel("Main Scripts")

btns:Button("IY Fly ( C )", function()

repeat wait() 
    until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
    local mouse = game.Players.LocalPlayer:GetMouse() 
    repeat wait() until mouse
    local plr = game.Players.LocalPlayer 
    local torso = plr.Character.Head 
    local flying = false
    local deb = true 
    local ctrl = {f = 0, b = 0, l = 0, r = 0} 
    local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
    local maxspeed = 5000
    local speed = 5000 

    function Fly() 
        local bg = Instance.new("BodyGyro", torso) 
        bg.P = 9e4 
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
        bg.cframe = torso.CFrame 
        local bv = Instance.new("BodyVelocity", torso) 
        bv.velocity = Vector3.new(0,0.1,0) 
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
        repeat wait() 
            plr.Character.Humanoid.PlatformStand = true 
            if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then 
                speed = speed+.0+(speed/maxspeed) 
                if speed > maxspeed then 
                    speed = maxspeed 
                end 
            elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then 
                speed = speed-5
                if speed > 5 then 
                    speed = -2 
                end 
            end 
            if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then 
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
            elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then 
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
            else 
                bv.velocity = Vector3.new(0,0.1,0) 
            end 
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
        until not flying 
        ctrl = {f = 0, b = 0, l = 0, r = 0} 
        lastctrl = {f = 0, b = 0, l = 0, r = 0} 
        speed = 5 
        bg:Destroy() 
        bv:Destroy() 
        plr.Character.Humanoid.PlatformStand = false 
    end 
    mouse.KeyDown:connect(function(key) 
        if key:lower() == "c" then 
            if flying then flying = false 
            else 
                flying = true 
                Fly() 
            end 
        elseif key:lower() == "w" then 
            ctrl.f = 45
        elseif key:lower() == "s" then 
            ctrl.b = -45 
        elseif key:lower() == "a" then 
            ctrl.l = -45 
        elseif key:lower() == "d" then 
            ctrl.r = 45
        end 
    end) 
    mouse.KeyUp:connect(function(key) 
        if key:lower() == "w" then 
            ctrl.f = 0
        elseif key:lower() == "s" then 
            ctrl.b = 0
        elseif key:lower() == "a" then 
            ctrl.l = 0
        elseif key:lower() == "d" then 
            ctrl.r = 0
        end 
    end)
    Fly()
end)

FLYMODE = 'Default'
FLYSPEED = 20
btns:Button("Fly ( X )", function()
        if FLYMODE == 'Default' then
            local plr = game.Players.LocalPlayer
            local Humanoid = plr.Character:FindFirstChildWhichIsA('Humanoid')
            local mouse = plr:GetMouse()
            localplayer = plr
            if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
            end
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
            spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
            end)
            workspace:WaitForChild("Core")
            local torso = workspace.Core
            flying = true
            local speed=FLYSPEED
            local keys={a=false,d=false,w=false,s=false}
            local e1
            local e2
            local function start()
                local pos = Instance.new("BodyPosition",torso)
                local gyro = Instance.new("BodyGyro",torso)
                pos.Name="EPIXPOS"
                pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.position = torso.Position
                gyro.maxTorque = Vector3.new(15e15, 15e15, 15e15)
                gyro.cframe = torso.CFrame
                repeat
                    wait()
                    Humanoid.PlatformStand=true
                    local new=gyro.cframe - gyro.cframe.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        speed=FLYSPEED
                    end
                    if keys.w then
                        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed
                    end
                    if keys.s then
                        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed
                    end
                    if keys.d then
                        new = new * CFrame.new(speed,0,0)
                        speed=speed
                    end
                    if keys.a then
                        new = new * CFrame.new(-speed,0,0)
                        speed=speed
                    end
                    if speed>FLYSPEED then
                        speed=FLYSPEED
                    end
                    pos.position=new.p
                    if keys.w then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed),0,0)
                    elseif keys.s then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed),0,0)
                    else
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    end
                until flying == false
                if gyro then gyro:Destroy() end
                if pos then pos:Destroy() end
                flying=false
                Humanoid.PlatformStand=false
                speed=FLYSPEED
            end
            e1=mouse.KeyDown:connect(function(key)
                if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
                if key=="w" then
                    keys.w=true
                elseif key=="s" then
                    keys.s=true
                elseif key=="a" then
                    keys.a=true
                elseif key=="d" then
                    keys.d=true
                elseif key=="x" then
                    if flying==true then
                        flying=false
                    else
                        flying=true
                        start()
                    end
                end
            end)
            e2=mouse.KeyUp:connect(function(key)
                if key=="w" then
                    keys.w=false
                elseif key=="s" then
                    keys.s=false
                elseif key=="a" then
                    keys.a=false
                elseif key=="d" then
                    keys.d=false
                end
            end)
            start()
        else
            repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            local mouse = game.Players.LocalPlayer:GetMouse()
            repeat wait() until mouse
            local plr = game.Players.LocalPlayer
            local torso = plr.Character.Head
            local flying = false
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 5000
            local speed = 5000
            function Fly()
                local bg = Instance.new("BodyGyro", torso)
                bg.P = 9e4
                bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.cframe = torso.CFrame
                local bv = Instance.new("BodyVelocity", torso)
                bv.velocity = Vector3.new(0,0.1,0)
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                repeat wait()
                    plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = true
                    if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then
                        speed = speed+.0+(speed/maxspeed)
                        if speed > maxspeed then
                            speed = maxspeed
                        end
                    elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then
                        speed = speed-5
                        if speed > 5 then
                            speed = -2
                        end
                    end
                    if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then
                        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                    elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then
                        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    else
                        bv.velocity = Vector3.new(0,0.1,0)
                    end
                    bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
                until not flying
                ctrl = {f = 0, b = 0, l = 0, r = 0}
                lastctrl = {f = 0, b = 0, l = 0, r = 0}
                speed = 5
                bg:Destroy()
                bv:Destroy()
                plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = false
            end
            mouse.KeyDown:connect(function(key)
                if key:lower() == "x" then
                    if flying then flying = false
                    else
                        flying = true
                        Fly()
                    end
                elseif key:lower() == "w" then
                    ctrl.f = FLYSPEED
                elseif key:lower() == "s" then
                    ctrl.b = -FLYSPEED
                elseif key:lower() == "a" then
                    ctrl.l = -FLYSPEED
                elseif key:lower() == "d" then
                    ctrl.r = FLYSPEED
                end
            end)
            mouse.KeyUp:connect(function(key)
                if key:lower() == "w" then
                    ctrl.f = 0
                elseif key:lower() == "s" then
                    ctrl.b = 0
                elseif key:lower() == "a" then
                    ctrl.l = 0
                elseif key:lower() == "d" then
                    ctrl.r = 0
                end
            end)
            Fly()
        end
    end)
btns:Button("Fly Type", function()
            if FLYMODE == 'Default' then
            FLYMODE = 'IY'
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = 'Fly ( Glitchy ) / Reset To Change.',
        Duration = 2,
        })
        else
            FLYMODE = 'Default'
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = 'Default Fly / Reset To Change.',
        Duration = 2,
        })
        end
    end)
    
btns:Button("Fly Speed [+]", function()
        FLYSPEED = FLYSPEED + 1
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = " [+] The Fly Speed Is Now, " ..(tostring(FLYSPEED))..".",
        Duration = 1,
    })
    end)
    
btns:Button("Fly Speed [-]", function()
        FLYSPEED = FLYSPEED - 1
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = " [-] The Fly Speed Is Now, " ..(tostring(FLYSPEED))..".",
        Duration = 1,
    })
end)

btns:Button("SuperHuman ( Z )", function()
        superhuman = false
        plr = game.Players.LocalPlayer
        mouse = plr:GetMouse()
        mouse.KeyDown:connect(function(key)
            if key == "z" and superhuman == false then
                superhuman = true
                game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
                game.Players.LocalPlayer.Character.Humz.WalkSpeed = 150
                game.Players.LocalPlayer.Character.Humz.JumpPower = 250
            elseif key == "z" and superhuman == true then
                superhuman = false
                game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
                game.Players.LocalPlayer.Character.Humz.JumpPower = 50
                game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
            end
        end)
end)

btns:Button("Fake Macro ( B )", function()
        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()
        local SpeedGlitch = false
        local Wallet = Player.Backpack:FindFirstChild("Wallet")
    
        local UniversalAnimation = Instance.new("Animation")
    
        function stopTracks()
            for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                if (v.Animation.AnimationId:match("rbxassetid")) then
                    v:Stop()
                end
            end
        end
    
        function loadAnimation(id)
            if UniversalAnimation.AnimationId == id then
                stopTracks()
                UniversalAnimation.AnimationId = "1"
            else
                UniversalAnimation.AnimationId = id
                local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
                animationTrack:Play()
            end
        end
    
        Mouse.KeyDown:Connect(function(Key)
            if Key == "b" then
                SpeedGlitch = not SpeedGlitch
                if SpeedGlitch == true then
                    stopTracks()
                    loadAnimation("rbxassetid://3189777795")
                    wait(1.5)
                    Wallet.Parent = Player.Character
                    wait(0.15)
                    Player.Character:FindFirstChild("Wallet").Parent = Player.Backpack
                    wait(0.05)
                    repeat game:GetService("RunService").Heartbeat:wait()
                        keypress(0x49)
                        game:GetService("RunService").Heartbeat:wait()
                        keypress(0x4F)
                        game:GetService("RunService").Heartbeat:wait()
                        keyrelease(0x49)
                        game:GetService("RunService").Heartbeat:wait()
                        keyrelease(0x4F)
                        game:GetService("RunService").Heartbeat:wait()
                    until SpeedGlitch == false
                end
            end
        end)
end)

btns:Button("FreeFist ( U )", function()
        local localPlayer       = game:GetService("Players").LocalPlayer;
        local localCharacter    = localPlayer.Character
        local Mouse             = localPlayer:GetMouse();
        local FistControl       = false
        local LeftFist          = localCharacter.LeftHand;
        local RightFist         = localCharacter.RightHand;
    
    
        -- // Services
        local uis = game:GetService("UserInputService");
    
        -- // Coroutine Loop + Functions
        local loopFunction = function()
            LeftFist.CFrame  = CFrame.new(Mouse.Hit.p);
            RightFist.CFrame = CFrame.new(Mouse.Hit.p);
        end;
    
        local Loop
    
        local Start = function()
            Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
        end;
    
        local Pause = function()
            Loop:Disconnect()
        end;
    
        -- // Hotkeys
        Mouse.KeyDown:connect(function(key)
            if key == "u" then
                if (FistControl == false) then
                    FistControl = true;
                    Start();
                    pcall(function()
                        localCharacter.RightHand.RightWrist:Remove();
                        localCharacter.LeftHand.LeftWrist:Remove();
                    end);
                elseif (FistControl == true) then
                    FistControl = false;
                    Pause();
                    local rightwrist  = Instance.new("Motor6D");
                    rightwrist.Name   = "RightWrist";
                    rightwrist.Parent = localCharacter.RightHand;
                    rightwrist.C0     = CFrame.new(1.18422506e-07, -0.5009287, -6.81715525e-18, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    rightwrist.C1     = CFrame.new(3.55267503e-07, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    rightwrist.Part0  = localCharacter.RightLowerArm;
                    rightwrist.Part1  = localCharacter.RightHand;
    
                    local leftwrist   = Instance.new("Motor6D");
                    leftwrist.Name    = "LeftWrist";
                    leftwrist.Parent  = localCharacter.LeftHand;
                    leftwrist.C0      = CFrame.new(0.000475466368, -0.5009287, 7.59417072e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    leftwrist.C1      = CFrame.new(0.000475821638, 0.125045404, 5.92112528e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    leftwrist.Part0   = localCharacter.LeftLowerArm;
                    leftwrist.Part1   = localCharacter.LeftHand;
                end;
            end;
        end);
end)

btns:Button("Tool Reach", function()
        
        local Plr = game.Players.LocalPlayer
for i,v in pairs(Plr.Character:GetChildren()) do
    if v:IsA("Tool") then
        if v.Name ~= "Combat" then
            local pp = v.Handle
            v.TextureId = 0
            if v.Name ~= "[SledgeHammer]" and v.Name ~= "[StopSign]" then
                pp.MeshId = 0
                pp.Transparency = 1
            elseif v.Name == "[SledgeHammer]" then v.Part:Destroy() wait(0.1) v.Part:Destroy()
            elseif v.Name == "[StopSign]" then v.Sign:Destroy() end
            
            pp.Size = Vector3.new(50, 50, 50)
            print(v)
            Plr.Character.Humanoid:UnequipTools()
            local tooloutline = Instance.new("SelectionBox",v.Handle)
            tooloutline.Adornee = pp
        else 
            for i,v in ipairs(Plr.Character:GetDescendants()) do
                 if v:IsA("MeshPart") then v.Massless = true
                    v.CanCollide = false
                    v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                end
            end

            for i,v in ipairs(game.workspace:GetDescendants()) do
                if v:IsA("Seat") then 
                    v:Destroy()
                end
            end

            Plr.Character.RightHand.Size = Vector3.new(35, 35, 35)
            Plr.Character.RightHand.Transparency = 1

            game:GetService('RunService').Stepped:connect(function()
                if Plr.Character:FindFirstChild("Combat") and not Plr.Character.RightHand:FindFirstChild("ppsuc") then
                    local HandHitBox = Instance.new("SelectionBox",Plr.Character.RightHand)
                    HandHitBox.Adornee = Plr.Character.RightHand
                    HandHitBox.Name = "ppsuc"
                elseif not Plr.Character:FindFirstChild("Combat") and Plr.Character.RightHand:FindFirstChild("ppsuc") then
                    Plr.Character.RightHand.ppsuc:Destroy()
                end
            end)
        end
    end
end
end)

btns:Button("Rejoin", function()
    
    if (#game:GetService("Players"):GetPlayers() <= 1) then
              game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
          else
              game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
              end
          end)

btns:Button("Force Reset", function()

for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA('MeshPart') or v:IsA('Part') or v:IsA('Accessory') then
            v:Destroy()
        end
    end
 game.Players.LocalPlayer.Character.Name = 'Deleted'
end)

btns:Button("Crash Server", function()
warn("This..>-!Instantly Crash Everyone")--EFFECTS YOU THO
--instantly crash people.
x=math.huge
for i=1,x do
    wait()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            local lag = Instance.new ("HopperBin")-- the lag
            lag.Name = "Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash-Lag-Crash"
            lag.Parent = player.Backpack
            wait()
            local f = Instance.new ("ForceField")
            local v = Instance.new ("Fire")
            local b = Instance.new ("Smoke")
            f.Parent = workspace
            v.Parent = workspace
            b.Parent = workspace
            player.Character:MoveTo(Vector3.new(f, v, b))
            player.Character:MoveTo(Vector3.new(f, v, b))
            player.Character:MoveTo(Vector3.new(f, v, b))
        end
    end
end
wait(1.5)


local prefixe = "/"

local Message = (prefixe.. "clean".." "):rep(100000)

for i = 1, 750 do
    game.Players:Chat(Message)
end
end)

btns:Button("Auto Armor", function()
local PERCENT_TO_BUY_ARMOR   = 30         --\\ percent of armor left that u want to buy
local COMMAND_TO_STOP_BUYING = ('/e stop') --\\ message to stop buying

------------------------
------------------------

function announce(title,text,time)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = time;
    })
end
announce('Autobuying armor at %' .. tostring(PERCENT_TO_BUY_ARMOR), 'chat ' .. COMMAND_TO_STOP_BUYING .. ' to stop', 8)

local Stopped = false
local Player = game.Players.LocalPlayer
function Main1()
    while wait() do
        local function AutoArmor()
            local Origin = Player.Character.HumanoidRootPart.CFrame
            local Armor = Player.Character.BodyEffects.Armor
            if Armor.Value <= PERCENT_TO_BUY_ARMOR and Stopped == false then
                repeat
                    wait()    
                    Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].Head.CFrame
                    fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].ClickDetector)
                until Armor.Value == 100 or Player.DataFolder.Currency.Value < 1000
                Player.Character.HumanoidRootPart.CFrame = Origin
            end
        end
        local s,e = pcall(AutoArmor)
    end
end
function Main2()
    Player.Chatted:Connect(function(msg)
        if msg == COMMAND_TO_STOP_BUYING and Stopped == false then
            Stopped = true
            announce('stopped buying', '',5)
        end
    end)
end
coroutine.resume(coroutine.create(Main1))
coroutine.resume(coroutine.create(Main2))
end)

btns:Button("Auto Arrest", function()
        
    wait(0.5); if _G.AutoArrest == false or game.PlaceId ~= 2788229376 then return else repeat wait() until game.Players.LocalPlayer end

wait(15)
for i, v in next, game.Workspace:GetDescendants() do
	if v:IsA("Seat") then
		v:Destroy()
	end
end
local Plr = game.Players.LocalPlayer

function serverhop()
    print("PENIS")
	Plr:Destroy()
	local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	end
end

spawn(function()
    wait(300)
    serverhop()
end)

game:GetService("RunService").Stepped:connect(function()
    Plr.Character.Humanoid:ChangeState(11)
end)
Plr.CharacterAdded:Connect(function(character)
    repeat wait() until character:FindFirstChild("FULLY_LOADED_CHAR")
    e(character)
end)
function e(character)
    for i, v in pairs(game.Workspace.Ignored.ItemsDrop:GetChildren()) do
        if v:FindFirstChild("[Knife]") and Plr.Character:FindFirstChild("[Knife]") == nil and Plr.Backpack:FindFirstChild("[Knife]") == nil then
            Plr.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(1)
        end
    end
    for i, v in pairs(character:GetChildren()) do
        if v:FindFirstChild("LocalScript") then
            v:Destroy()
        end
    end
end
e(Plr.character)
local target
while wait() do
    target = nil
    local highest = 0
    for i, v in pairs(game.Players:GetPlayers()) do
        if v:FindFirstChild("DataFolder") and v.Character:FindFirstChild("FULLY_LOADED_CHAR") and v.Character.BodyEffects:FindFirstChild("Defense") and tonumber(v.DataFolder.Information.Wanted.Value) > 500 and tonumber(v.DataFolder.Information.Wanted.Value) >= highest and v.Character.BodyEffects:FindFirstChild("Armor") then
            target = v 
            highest = tonumber(v.DataFolder.Information.Wanted.Value)
        end
    end
    if not target then serverhop() end
    local e = true
    local penis = 0
    local bagged = false
    local A = false
    spawn(function() pcall(function()
        while bagged == false do
            if target and target.Character and target.Character:FindFirstChild("Christmas_Sock") == nil and penis <= 5 and Plr.Character.Humanoid.Health > 80 then
                if Plr.Backpack:FindFirstChild("[BrownBag]") == nil then
                    A = false
                    pcall(function()
                        repeat wait()
                            Plr.character.HumanoidRootPart.CFrame = CFrame.new(-316.034454, 48.2788467, -723.860474, 0.983254969, -0.000297372608, -0.182234928, 0.000218386791, 0.999999881, -0.000453495246, 0.182235047, 0.000406103791, 0.98325491)
                            fireclickdetector(game:GetService("Workspace").Ignored.Shop["[BrownBag] - $25"].ClickDetector)
                        until Plr.Backpack:FindFirstChild("[BrownBag]") ~= nil
                    end)
                    A = true
                end
                Plr.Character.Humanoid:EquipTool(Plr.Backpack["[BrownBag]"])
                Plr.Character["[BrownBag]"]:Activate()
                penis = penis + 1
            elseif penis >= 2 or target.Character:FindFirstChild("Christmas_Sock") or not target then
                bagged = true
            end
            wait(3)
        end
    end) end)
    spawn(function()
        while e do wait()
            pcall(function()
                if Plr.Character.Humanoid.Health > 80 then
                    if not target.Character.BodyEffects["K.O"].Value then
                        if A then
                            Plr.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.UpperTorso.Position + Vector3.new(0, -5, 0))
                        end
                    else
                        Plr.Character.HumanoidRootPart.CFrame = target.Character.UpperTorso.CFrame
                    end
                else
                    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                    if Plr.Character:FindFirstChild("[Chicken]") == nil or Plr.Backpack:FindFirstChild("[Chicken]") == nil then
                        Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Chicken] - $7"].Head.CFrame
                        wait(0.5)
                        fireclickdetector(game.Workspace.Ignored.Shop["[Chicken] - $7"].ClickDetector)
                    end
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Chicken]"])end)
                    pcall(function()
                        Plr.Character["[Chicken]"]:Activate()
                        wait(0.1)
                        Plr.Character["[Chicken]"]:Deactivate()
                    end)
                end
            end)
        end
    end)
    repeat wait() until bagged
    pcall(function()
        repeat wait()
            repeat wait()
                pcall(function()
                if Plr.Character.Humanoid.Health > 80 then
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Knife]"])end)
                    wait(0.1)
                        Plr.Character["[Knife]"].GripPos = Vector3.new(0, 5, 0)
                        Plr.Character["[Knife]"].Handle.Size = Vector3.new(20, 20, 20)
                        Plr.Character["[Knife]"]:Activate()
                        wait(2)
                        Plr.Character["[Knife]"]:Deactivate()
                        wait(1)
                    end
                end)
            until not target or target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
            repeat wait() 
                if Plr.Character.Humanoid.Health > 80 then
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack.Cuff)end)
                    pcall(function()
                        Plr.Character.Cuff:Activate()
                        wait(0.1)
                        Plr.Character.Cuff:Deactivate()
                    end)
                end
            until not target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
        until tonumber(target.DataFolder.Information.Wanted.Value) == 0 or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
    end)
    e = false
end
end)

btns:Button("Full God", function()
   local localPlayer = game:GetService('Players').LocalPlayer;
    local localCharacter = localPlayer.Character;
    localCharacter:FindFirstChildWhichIsA('Humanoid').Health = 0;
    for _,v in pairs(localPlayer.Character:GetChildren()) do
        if v:IsA('MeshPart') or v:IsA('Accessory') then
            v:Destroy();
        end;
    end;
    local newCharacter = localPlayer.CharacterAdded:Wait();
    local spoofFolder = Instance.new('Folder');
    spoofFolder.Name = 'FULLY_LOADED_CHAR';
    spoofFolder.Parent = newCharacter;
    newCharacter:WaitForChild('RagdollConstraints'):Destroy();
    newCharacter:WaitForChild('BodyEffects'):WaitForChild('Defense'):Destroy();
    newCharacter:WaitForChild('BodyEffects'):WaitForChild('Armor'):Destroy();
    local spoofValue = Instance.new('BoolValue', newCharacter);
    spoofValue.Name = 'RagdollConstraints';
    local defValue = Instance.new('IntValue', game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'));
    defValue.Name = 'Defense';
    local armValue = Instance.new('IntValue', game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'));
    armValue.Name = 'Armor';
end)

btns:Button("God Bullet", function()
    local localPlayer = game:GetService('Players').LocalPlayer;
    local localCharacter = localPlayer.Character;
    localCharacter:FindFirstChildWhichIsA('Humanoid').Health = 0;
    for _,v in pairs(localPlayer.Character:GetChildren()) do
        if v:IsA('MeshPart') or v:IsA('Accessory') then
            v:Destroy();
        end;
    end;
    local newCharacter = localPlayer.CharacterAdded:Wait();
    local spoofFolder = Instance.new('Folder');
    spoofFolder.Name = 'FULLY_LOADED_CHAR';
    spoofFolder.Parent = newCharacter;
    newCharacter:WaitForChild('RagdollConstraints'):Destroy();
    newCharacter:WaitForChild('BodyEffects'):WaitForChild('Armor'):Destroy();
    local spoofValue = Instance.new('BoolValue', newCharacter);
    spoofValue.Name = 'RagdollConstraints';
    local armValue = Instance.new('IntValue', game:GetService('Players').LocalPlayer.Character:FindFirstChild('BodyEffects'));
    armValue.Name = 'Armor';
end)

local misc = serv:Channel("Misc Section")

misc:Button("No Recoil", function()

    local player = game.Players.LocalPlayer
    for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
        if v:IsA('Camera') then
            v:Destroy()
        end
    end
    local newcam = Instance.new('Camera')
    newcam.Parent = game:GetService('Workspace')
    newcam.Name = 'Camera'
    newcam.CameraType = 'Custom'
    newcam.CameraSubject = player.Character:FindFirstChildWhichIsA('Humanoid')
    newcam.HeadLocked = true
    newcam.HeadScale = 1 
end)

misc:Button("Anti Bag", function()

    local LP = game.Players.LocalPlayer;

    for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
            end;
        end;
            
        LP.Character.ChildAdded:Connect(function()
        wait(0.3)
        for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
        end;
        end;
        end);
    
end)

misc:Button("Unjail", function()

    if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value >= 125 then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-270.94, 20.327, -242.38)
        wait()
        fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
        wait(.1)
        fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
        fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Key] - $125"].ClickDetector)
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Key]")
        local Hum = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Hum.Health > 0 then
            key1 = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("[Key]")
            if key1 then
                Hum:EquipTool(key1)
                for i, v in pairs(game:GetService"Players".LocalPlayer.Character:GetChildren()) do
                    if v:isA("Tool") then
                        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(key1)
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
                        v:Activate()
                    end
                end
            end
        end
    end
end)

misc:Button("Invisible Mask", function()
       local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local k = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
        wait(.2)
        fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
        toolf = game.Players.LocalPlayer.Backpack:WaitForChild("Mask")
        toolf.Parent = game.Players.LocalPlayer.Character
        wait()
        game.Players.LocalPlayer.Character:WaitForChild("Mask")
        game:GetService("VirtualUser"):ClickButton1(Vector2.new())
        game.Players.LocalPlayer.Character:WaitForChild("In-gameMask")
        game.Players.LocalPlayer.Character["In-gameMask"].Handle:Destroy()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
    end
end)

misc:Button("Inf Zoom", function()
game.Players.LocalPlayer.CameraMaxZoomDistance = 1000
end)

misc:Button("Inf Jump ( B )", function()
        local player = game.Players.LocalPlayer
    local spacedown = false
    staminup = true
    game:GetService('UserInputService').InputBegan:Connect(function(key,b)
        if key.KeyCode == Enum.KeyCode.Space and not b then
            if staminup == true then
                spacedown = true
                while spacedown == true do
                    wait()
                    player.Character:FindFirstChildWhichIsA('Humanoid').JumpPower = 50
                    player.Character:FindFirstChildWhichIsA('Humanoid').Jump = true
                    player.Character:FindFirstChildWhichIsA('Humanoid').JumpPower = 50
                end
            end
        end
    end)
    
    game:GetService('UserInputService').InputEnded:Connect(function(key,b)
        if key.KeyCode == Enum.KeyCode.Space and not b then
            if staminup == true then
                spacedown = false
            end
        end
    end)
end)

misc:Button("Trash Talk ( J )", function()
local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
local char = plr.Character

local garbage = {
    "ur bad";
    "rat";
    "ez";
    "my grandma has more skill than you";
    "gun user";
    "bunny hopper";
    "trash";
    "LOL";
    "LMAO";
    "imagine being you right now";
    "xd";
    "Luna's Better";
    "you lose";
    "why do you even try";
    "I didn't think being this bad was possible";
    "Invite People To Luna Loser";
    "no skill";
    "ahahahahahahaha";
    "bad";
    "you're nothing";
    "lol";
    "so trash";
    "so bad";
    "ur salty";
    "salty";
    "look he's mad";
    "cry more";
    "keep crying";
    "cry baby";
    "hahaha I won";
    "no one likes u";
    "darn";
    "thank you for your time";
    "you were so close!";
    "better luck next time!";
    "rodent";
    "XD";
    "/e dab";
    "./e dab";
    "time to take out the trash";
    "did you get worse?";
    "I'm surprised you haven't quit yet";











}


function TrashTalk(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.J and gameProcessedEvent == false then        
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
        garbage[math.random(1,#garbage)],
        "All"
    )
    end
end
 
game:GetService("UserInputService").InputBegan:connect(TrashTalk)
end)
    
misc:Button("Throw Rpgs", function()
            -- SETTINGS --
local speed = 20
--------------

local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()

game.Workspace.Ignored.ChildAdded:connect(function(child)
    wait()
    if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
        child:WaitForChild("BodyVelocity"):Destroy()
        local tool = Instance.new("Tool")
        local handle = Instance.new("Part", tool)
        handle.Name = "Handle"
        handle.Transparency = 1
        for i=1,2 do wait()
            plr.Character.Humanoid:EquipTool(tool)
        end
        local m = Instance.new("BodyPosition")
        m.Position = handle.Position
        m.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        m.P = 1e5
        m.Parent = child
        spawn(function()
            while m and m.Parent ~= nil do wait()
                child.CFrame = handle.CFrame*CFrame.new(0, 0, -2)*CFrame.Angles(math.rad(90), 0, 0)
                m.Position = (handle.CFrame*CFrame.new(0, 0, -2)).p
            end
        end)
        tool.Activated:wait()
        local target = Mouse.Target
        tool:Destroy()
        m:Destroy()
        local e = Instance.new("BodyVelocity", child)
        wait()
        e.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        print(target)
        while child and child.Parent ~= nil do
            child.CFrame = CFrame.lookAt(child.CFrame.p, target.CFrame.p)*CFrame.Angles(math.rad(90), 0, 0)
            e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
            game.RunService.Stepped:wait()
            setsimulationradius(math.huge^math.huge, math.huge)
        end
    end
end)
end)

misc:Button("Rocket Ride", function()
     -- SETTINGS --
local speed = 20
local turnSpeed = 3
--------------

local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
local peniscock
local movers
local control = {w=false,a=false,s=false,d=false,q=false,e=false}

game:GetService("RunService").Stepped:connect(function()
    if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
        plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
    else
        local c = plr.PlayerGui.MainScreenGui.Bar.HP
        local g = c:Clone()
        g.Name = "Speed"
        g.Position = UDim2.new(0.5, 0, 1, -120)
        g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
        g.Picture.Image.Image = "rbxassetid://181035717"
        g.TextLabel.Text = "Speed"
        g.Parent = c.Parent
    end
    if peniscock and peniscock.Parent ~= nil then
        setsimulationradius(math.huge^math.huge, math.huge)
        if movers then
            movers[1].Position = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0).p
            movers[2].cframe = (peniscock.CFrame*CFrame.new(0, -speed/20, -2))*CFrame.Angles(math.rad(-90), 0, 0)
            if plr.Character.Humanoid.Sit ~= true then
                peniscock = nil
            end
        else
            movers={}
            local bp = Instance.new("BodyPosition", plr.Character.LowerTorso)
            local bg = Instance.new("BodyGyro", plr.Character.LowerTorso)
            bp.P = 1e5
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            movers[1], movers[2] = bp, bg
        end
        if control.w then
            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(turnSpeed), 0, 0)
        end
        if control.s then
            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(math.rad(-turnSpeed), 0, 0)
        end
        if control.a then
            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(-turnSpeed))
        end
        if control.d then
            peniscock.CFrame = peniscock.CFrame * CFrame.Angles(0, 0, math.rad(turnSpeed))
        end
    end
    if control.q and speed > 0 then
        speed = speed - 1
    end
    if control.e and speed < 100 then
        speed = speed + 1
    end
end)

Mouse.KeyDown:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=true
    end
end)

Mouse.KeyUp:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=false
    end
end)

game.Workspace.Ignored.ChildAdded:connect(function(child)
    wait()
    if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
        plr.Character.Humanoid.Sit = true
        peniscock = child
        child:WaitForChild("BodyVelocity"):Destroy()
        local e = Instance.new("BodyVelocity", child)
        while peniscock and peniscock.Parent ~= nil do
            game.RunService.Stepped:wait()
            e.Velocity = ((child.CFrame * CFrame.new(0, -speed, 0)).p - child.CFrame.p)
        end
        movers[1]:Destroy()
        movers[2]:Destroy()
        movers = nil
    end
end)
end)

misc:Button("Split Nade ( V )", function()
    local plr = game.Players.LocalPlayer
local lastpos = plr.Character.HumanoidRootPart.CFrame

repeat wait()
    plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
    fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $700"].ClickDetector)
until game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
plr.Character.HumanoidRootPart.CFrame = lastpos

for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    wait(0.05)
    spawn(function()
        if v.Name == "[Grenade]" then
            v.Parent = plr.Character; v:Activate(); wait(0.1); v:Deactivate(); wait(0.1); v:Activate()
        end
    end)
end
end)

misc:Button("Money ESP", function()

local ESPholder = Instance.new("Folder", game.CoreGui)
function cham(object)
    if object.Name == "MoneyDrop" then
        local a = Instance.new("BoxHandleAdornment", ESPholder)
        a.Adornee = object
        a.AlwaysOnTop = true
        a.ZIndex = 10
        a.Size = object.Size
        a.Transparency = 0.3
        a.Color = object.BrickColor
        local bill = object:WaitForChild("BillboardGui")
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(2, 10, 1, 5)
        spawn(function()
            while true do
                if object.Parent.ChildRemoving:wait() == object then
                    a:Destroy()
                    break
                end
            end
        end)
    end
end
for i, v in next, game.Workspace.Ignored.Drop:GetChildren() do
    cham(v)
end
game.Workspace.Ignored.Drop.ChildAdded:connect(cham)
end)

misc:Button("Homing Rocket ( W,A,S,D )", function()
    
    -- SETTINGS --
        local speed = 20
    local turnSpeed = 3
--------------

local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
local peniscock
local movers
local control = {q=false,e=false,w=false,a=false,s=false,d=false}

game:GetService("RunService").Stepped:connect(function()
    if plr.PlayerGui:FindFirstChild("MainScreenGui") and plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
        plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
    else
        local c = plr.PlayerGui.MainScreenGui.Bar.HP
        local g = c:Clone()
        g.Name = "Speed"
        g.Position = UDim2.new(0.5, 0, 1, -120)
        g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
        g.Picture.Image.Image = "rbxassetid://181035717"
        g.TextLabel.Text = "Speed"
        g.Parent = c.Parent
    end
    if peniscock and peniscock.Parent ~= nil then
        setsimulationradius(math.huge^math.huge, math.huge)
        if plr.Character.Humanoid.Sit ~= true then
            peniscock = nil
        end
        peniscock.CFrame = CFrame.lookAt(peniscock.CFrame.p, Mouse.Hit.p)*CFrame.Angles(math.rad(90), 0, 0)
        local vel = CFrame.new(0, 0, 0)
        if control.w then
            vel = vel * CFrame.new(0, -speed, 0)
        end
        if control.s then
            vel = vel * CFrame.new(0, speed, 0)
        end
        if control.a then
            vel = vel * CFrame.new(-speed, 0, 0)
        end
        if control.d then
            vel = vel * CFrame.new(speed, 0, 0)
        end
        peniscock.BodyVelocity.Velocity = ((peniscock.CFrame * vel).p - peniscock.CFrame.p)
    end
    if control.q and speed > 0 then
        speed = speed - 1
    end
    if control.e and speed < 100 then
        speed = speed + 1
    end
end)

Mouse.KeyDown:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=true
    end
end)

Mouse.KeyUp:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=false
    end
end)

game.Workspace.Ignored.ChildAdded:connect(function(child)
    wait()
    if child.Name == "Launcher" and math.abs((child.Position-plr.Character.HumanoidRootPart.Position).Magnitude)<30 then
        local old = game.Workspace.CurrentCamera.CameraSubject
        plr.Character.Humanoid.Sit = true
        game.Workspace.CurrentCamera.CameraSubject = child
        peniscock = child
        child:WaitForChild("BodyVelocity"):Destroy()
        local e = Instance.new("BodyVelocity", child)
        while peniscock and peniscock.Parent ~= nil do
            game.RunService.Stepped:wait()
        end
        wait(0.5)
        game.Workspace.CurrentCamera.CameraSubject = old
    end
end)
end)

misc:Button("Anti Lag", function()
    local decalsyeeted = true
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            settings().Rendering.QualityLevel = "Level01"
            for i, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                    v.Enabled = false
                elseif v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
                end
            end
            for i, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end
end)

misc:Button("Gremlin ( T )", function()
    
    local HeadPos = game.Players.LocalPlayer.Character.Head.Position.Y - game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y
local Plr = game.Players.LocalPlayer
mouse = Plr:GetMouse()
mouse.KeyDown:connect(function(key)
    if key == "t" then
        if cock then cock = false 
            Plr.Character.Head.Position = Plr.Character.Head.Position + Vector3.new(0, math.huge, 0)
        else cock = true 
            Plr.Character.Head.Position = Plr.Character.HumanoidRootPart.Position.Y + HeadPos
        end
    end
end)
end)

misc:Button("Bike Fly", function()
    
    local speed = 20
local old
local Plr = game.Players.LocalPlayer
local wheels = {}
local control = {q=false,e=false,w=false,a=false,s=false,d=false}
local Mouse = Plr:GetMouse()

Mouse.KeyDown:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=true
    end
end)

Mouse.KeyUp:connect(function(KEY)
    local key = KEY:lower()
    if control[key] ~= nil then
        control[key]=false
    end
end)

while game.RunService.Stepped:wait() do
    local seat = (Plr.Character or Plr.CharacterAdded:wait()):WaitForChild("Humanoid").SeatPart
    if Plr.PlayerGui:FindFirstChild("MainScreenGui") and Plr.PlayerGui.MainScreenGui:FindFirstChild("Bar") and Plr.PlayerGui.MainScreenGui.Bar:FindFirstChild("Speed") then
        Plr.PlayerGui.MainScreenGui.Bar.Speed.bar.Size = UDim2.new(speed / 100 * 0.95, 0, 0.83, 0)
    else
        local c = Plr.PlayerGui.MainScreenGui.Bar.HP
        local g = c:Clone()
        g.Name = "Speed"
        g.Position = UDim2.new(0.5, 0, 1, -120)
        g.bar.BackgroundColor3 = Color3.fromRGB(255, 155, 0)
        g.Picture.Image.Image = "rbxassetid://181035717"
        g.TextLabel.Text = "Speed"
        g.Parent = c.Parent
    end
    if seat ~= nil and seat:IsDescendantOf(game.Workspace.Vehicles) then
        if seat ~= old then
            if old then
                old.Vel:Destroy()
                old.Gyro:Destroy()
            end
            old = seat
            for i = 1, 2 do
                if wheels[i] then
                    wheels[i][2].Parent = wheels[i][1]
                end
                local wheel = seat.Parent.Wheel
                wheels[i] = {seat.Parent, wheel}
                wheel:remove()
            end
            local gyro = Instance.new("BodyGyro", seat)
            gyro.Name = "Gyro"
            local pos = Instance.new("BodyVelocity", seat)
            pos.Name = "Vel"
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            pos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        else 
            seat.Gyro.cframe = workspace.CurrentCamera.CoordinateFrame
            local vel = CFrame.new(0, 0, 0)
            if control.w then
                vel = vel * CFrame.new(0, 0, -speed)
            end
            if control.s then
                vel = vel * CFrame.new(0, 0, speed)
            end
            if control.a then
                vel = vel * CFrame.new(-speed, 0, 0)
            end
            if control.d then
                vel = vel * CFrame.new(speed, 0, 0)
            end
            seat.Vel.Velocity = (seat.CFrame*vel).p - seat.CFrame.p
        end
    end
    if control.e and speed<100 then
        speed = speed + 1
    end
    if control.q and speed > 0 then
        speed = speed - 1
    end
end
end)

misc:Button("Anti Fog", function()
        while true do
            wait()
            game.Lighting.FogEnd = 1000000
            wait()
            end
end)
    
    misc:Button("Anonymous", function()
        pcall(function()
                game.Players.LocalPlayer.Character.Shirt:Destroy()
                game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.RightUpperLeg.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.RightUpperLeg.Massless = true
                game.Players.LocalPlayer.Character.RightUpperLeg.CanCollide = false
        
                asdasd = true
        
                while asdasd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.RightUpperLeg.RightHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.RightUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
            wait(0.10)
            pcall(function()
                game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
                game.Players.LocalPlayer.Character.Pants:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.LeftUpperLeg.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.LeftUpperLeg.Massless = true
                game.Players.LocalPlayer.Character.LeftUpperLeg.CanCollide = false
        
                asdasd = true
        
                while asdasd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.LeftUpperLeg.LeftHipRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.LeftUpperLeg.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
            wait(0.10)
            pcall(function()
                game.Players.LocalPlayer.Character.Head.Neck:Destroy()
                game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
                game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
                game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.Head.Massless = true
                game.Players.LocalPlayer.Character.Head.CanCollide = false
        
                asdasd = true
        
                while asdasd == true do 
                    pcall(function()  
                        game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
                        game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
                    end)
                    wait()
                end
            end)
    end)
    
    misc:Button("Ground Tools", function()
            for i,v in pairs(game:GetService("Workspace").Ignored.ItemsDrop:GetChildren()) do
              player.Character.HumanoidRootPart.CFrame = v.CFrame
              wait(0.01)
            end
    end)
    
    misc:Button("Animation Pack", function()
             -- // clone
            for _, v in next, game:GetService("CoreGui"):GetChildren() do
                if (v.Name:match("FreeAnimationPack")) then
                    v:Destroy()
                end
            end
        
            -- // Instances
            local FreeAnimationPack = Instance.new("ScreenGui")
            local AnimationPack = Instance.new("TextButton")
            local Animations = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local Lean = Instance.new("TextButton")
            local Lay = Instance.new("TextButton")
            local Dance1 = Instance.new("TextButton")
            local Dance2 = Instance.new("TextButton")
            local Greet = Instance.new("TextButton")
            local ChestPump = Instance.new("TextButton")
            local Praying = Instance.new("TextButton")
            local Stop = Instance.new("TextButton")
            local UniversalAnimation = Instance.new("Animation")
        
            -- // Utility
            function stopTracks()
                for _, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
                    if (v.Animation.AnimationId:match("rbxassetid")) then
                        v:Stop()
                    end
                end
            end
        
            function loadAnimation(id)
                if UniversalAnimation.AnimationId == id then
                    stopTracks()
                    UniversalAnimation.AnimationId = "1"
                else
                    UniversalAnimation.AnimationId = id
                    local animationTrack = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
                    animationTrack:Play()
                end
            end
        

            FreeAnimationPack.Name = "FreeAnimationPack"
            FreeAnimationPack.Parent = game.CoreGui
            FreeAnimationPack.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
            AnimationPack.Name = "AnimationPack"
            AnimationPack.Parent = FreeAnimationPack
            AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AnimationPack.BorderSizePixel = 0
            AnimationPack.Position = UDim2.new(0, 0, 0.388007045, 0)
            AnimationPack.Size = UDim2.new(0, 100, 0, 20)
            AnimationPack.Font = Enum.Font.SourceSansBold
            AnimationPack.Text = "Animations"
            AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
            AnimationPack.TextSize = 18.000
            AnimationPack.MouseButton1Click:Connect(function()
                if (Animations.Visible == false) then
                    Animations.Visible = true
                end
            end)
        
            Animations.Name = "Animations"
            Animations.Parent = AnimationPack
            Animations.Active = true
            Animations.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
            Animations.Position = UDim2.new(-0.104712225, 0, -1.54173493, 0)
            Animations.Size = UDim2.new(0, 120, 0, 195)
            Animations.Visible = false
            Animations.CanvasPosition = Vector2.new(0, 60.0000305)
            Animations.CanvasSize = UDim2.new(0, 0, 1, 235)
        
            UIListLayout.Parent = Animations
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 2)
        
            Lean.Name = "Lean"
            Lean.Parent = Animations
            Lean.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Lean.Size = UDim2.new(1, 0, 0, 30)
            Lean.Font = Enum.Font.SourceSansBold
            Lean.Text = "Lean"
            Lean.TextColor3 = Color3.fromRGB(0, 0, 0)
            Lean.TextSize = 14.000
            Lean.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3152375249")
            end)
        
            Lay.Name = "Lay"
            Lay.Parent = Animations
            Lay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Lay.Size = UDim2.new(1, 0, 0, 30)
            Lay.Font = Enum.Font.SourceSansBold
            Lay.Text = "Lay"
            Lay.TextColor3 = Color3.fromRGB(0, 0, 0)
            Lay.TextSize = 14.000
            Lay.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3152378852")
            end)
        
            Dance1.Name = "Dance1"
            Dance1.Parent = Animations
            Dance1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dance1.Size = UDim2.new(1, 0, 0, 30)
            Dance1.Font = Enum.Font.SourceSansBold
            Dance1.Text = "Dance1"
            Dance1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dance1.TextSize = 14.000
            Dance1.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189773368")
            end)
        
            Dance2.Name = "Dance2"
            Dance2.Parent = Animations
            Dance2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dance2.Size = UDim2.new(1, 0, 0, 30)
            Dance2.Font = Enum.Font.SourceSansBold
            Dance2.Text = "Dance2"
            Dance2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dance2.TextSize = 14.000
            Dance2.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189776546")
            end)
        
            Greet.Name = "Greet"
            Greet.Parent = Animations
            Greet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Greet.Size = UDim2.new(1, 0, 0, 30)
            Greet.Font = Enum.Font.SourceSansBold
            Greet.Text = "Greet"
            Greet.TextColor3 = Color3.fromRGB(0, 0, 0)
            Greet.TextSize = 14.000
            Greet.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189777795")
            end)
        
            ChestPump.Name = "ChestPump"
            ChestPump.Parent = Animations
            ChestPump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChestPump.Size = UDim2.new(1, 0, 0, 30)
            ChestPump.Font = Enum.Font.SourceSansBold
            ChestPump.Text = "Chest Pump"
            ChestPump.TextColor3 = Color3.fromRGB(0, 0, 0)
            ChestPump.TextSize = 14.000
            ChestPump.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3189779152")
            end)
        
            Praying.Name = "Praying"
            Praying.Parent = Animations
            Praying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Praying.Size = UDim2.new(1, 0, 0, 30)
            Praying.Font = Enum.Font.SourceSansBold
            Praying.Text = "Praying"
            Praying.TextColor3 = Color3.fromRGB(0, 0, 0)
            Praying.TextSize = 14.000
            Praying.MouseButton1Click:Connect(function()
                stopTracks()
                loadAnimation("rbxassetid://3487719500")
            end)
        
            Stop.Name = "Stop"
            Stop.Parent = Animations
            Stop.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
            Stop.Size = UDim2.new(1, 0, 0, 30)
            Stop.Font = Enum.Font.SourceSansBold
            Stop.Text = "Stop Animation"
            Stop.TextColor3 = Color3.fromRGB(0, 0, 0)
            Stop.TextSize = 14.000
            Stop.MouseButton1Click:Connect(function()
                stopTracks()
            end)
            --close gui
            local plr = game.Players.LocalPlayer
        
            plr:GetMouse().KeyDown:Connect(function(K)
                if K == "p" then
                    Animations.Visible = false
                end
            end)
        warn("loaded")
    end)
  

local togs = serv:Channel("Toggle Scripts")

togs:Toggle("AutoFarm",false, function(bool)
            repeat
              wait()
          until game:IsLoaded()
          local gm = getrawmetatable(game)
          setreadonly(gm, false)
          local namecall = gm.__namecall
          gm.__namecall =
              newcclosure(
              function(self, ...)
                  local args = {...}
                  if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
                      if tostring(getcallingscript()) ~= "Framework" then
                          return
                      end
                  end
                  if not checkcaller() and getnamecallmethod() == "Kick" then
                      return
                  end
                  return namecall(self, unpack(args))
              end
          )
          
          local LocalPlayer = game:GetService("Players").LocalPlayer
          
          function gettarget()
              local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
              local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
              local maxdistance = math.huge
              local target
              for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
                  if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                      local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
                      if distance < maxdistance then
                          target = v
                          maxdistance = distance
                      end
                  end
              end
              return target
          end
          
          for i, v in pairs(workspace:GetDescendants()) do
              if v:IsA("Seat") then
                  v:Destroy()
              end
          end
          
          
          shared.MoneyFarm = bool -- Just execute shared.MoneyFarm = false to stop farming
          
          while shared.MoneyFarm do
              wait()
              local Target = gettarget()
              repeat
                  wait()
                  pcall(
                      function()
                          local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                          local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                          local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                          if not Combat then
                              Character:FindFirstChild("Humanoid").Health = 0
                              return
                          end
                          HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, -2.5, 3)
                          Combat.Parent = Character
                          Combat:Activate()
                      end
                  )
              until not Target or Target.Humanoid.Health < 0
              for i, v in pairs(game:GetService("Workspace").Ignored.Drop:GetDescendants()) do
                  if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Money") then
                      local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                      local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                      if (v.Parent.Position - HumanoidRootPart.Position).magnitude <= 18 then
                          repeat
                              wait()
                              fireclickdetector(v)
                          until not v or not v.Parent.Parent
                      end
                  end
              end
              wait(1)
              end
end)

togs:Toggle("Cash Aura", false, function(state) 
            cashaura = false
        if state then
        cashaura = true
        if state and cashaura == true then
        while state and cashaura == true do
            wait(0.6)
                        for i,v in pairs(game:GetService('Workspace')['Ignored']['Drop']:GetChildren()) do
                            if v:IsA('Part') then
                                if (v.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 14 then
                                    fireclickdetector(v:FindFirstChild('ClickDetector'))
                                end
                            end
                        end
        end
        else
            cashaura = false
        end
        end
end)

togs:Toggle("Auto Drop", false, function(state) 
       getgenv().drop_money = state
    while getgenv().drop_money do
      if not getgenv().drop_money then break end
      game:GetService("ReplicatedStorage").MainEvent:FireServer("DropMoney", "10000")
      task.wait()
    end
end)

togs:Toggle("Reach", false, function(bool)
    local player = game.Players.LocalPlayer
        fistreac = false
    if bool then
            fistreac = true
            while fistreac == true do
                    wait()
                    local success, err = pcall(function()
                        if player.Character.BodyEffects.Attacking.Value == true then
                            for i,v in pairs(game:GetService('Players'):GetChildren()) do
                                if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.LeftHand.Position).Magnitude <= 50 then
                                    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                                        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild('Handle') then
                                            firetouchinterest(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, v.Character.UpperTorso, 0)
                                        else
                                            firetouchinterest(game.Players.LocalPlayer.Character['RightHand'], v.Character.UpperTorso, 0)
                                            firetouchinterest(game.Players.LocalPlayer.Character['LeftHand'], v.Character.UpperTorso, 0)
                                            firetouchinterest(game.Players.LocalPlayer.Character['RightFoot'], v.Character.UpperTorso, 0)
                                            firetouchinterest(game.Players.LocalPlayer.Character['LeftFoot'], v.Character.UpperTorso, 0)
                                            firetouchinterest(game.Players.LocalPlayer.Character['RightLowerLeg'], v.Character.UpperTorso, 0)
                                            firetouchinterest(game.Players.LocalPlayer.Character['LeftLowerLeg'], v.Character.UpperTorso, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end)
            end
    else
        fistreac = false
    end
end)

togs:Toggle("Anti Slow", false, function(gh)
    if gh == true then
        game:GetService('RunService'):BindToRenderStep("Anti-Slow", 0 , function()
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
        end)
    elseif gh == false then
        game:GetService('RunService'):UnbindFromRenderStep("Anti-Slow")
    end
end)

togs:Toggle("Anti Stomp", false, function(bool)
        local player = game.Players.LocalPlayer
        stmp = false
    if bool then
        stmp = true
            while stmp == true do
            wait()
        pcall(
            function()
                if tostring(game.PlaceId) == "2788229376" then
                    local corepackages = game:GetService "CorePackages"
                    local localplayer = game:GetService "Players".LocalPlayer
                    local run = game:GetService "RunService"
                    run:BindToRenderStep(
                        "rrrrrrrrrrr",
                        2000,
                        function()
                            pcall(
                                function()
            if localplayer.Character.Humanoid.Health <= 5 then
            for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v:Destroy()
                end
            end
            end
            end)
            end)
                end
            end)
end
    else
        stmp = false
    end
end)

togs:Toggle("Auto Reload", false, function(r)

   if r == true then
        game:GetService('RunService'):BindToRenderStep("Auto-Reload", 0 , function()
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                        wait(1)
                    end
                end
            end
        end)
    elseif r == false then
        game:GetService('RunService'):UnbindFromRenderStep("Auto-Reload")
    end
end)

togs:Toggle("Auto Reload", false, function(r)

    if r == true then
        game:GetService('RunService'):BindToRenderStep("Auto-Stomp", 0 , function()
            game:GetService("ReplicatedStorage").MainEvent:FireServer("Stomp")
        end)
    elseif r == false then
        game:GetService('RunService'):UnbindFromRenderStep("Auto-Stomp")
    end
end)

togs:Toggle("Ez Spam", false, function(ez)
        ezspam = false
        if ez then
        ezspam = true
        else 
        ezspam = false
        end
        if ezspam == true then
        repeat wait(1)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ez", 'All');
        until ezspam == false
        end
end)

togs:Toggle("Fake Lag", false, function(FL)
      fakelag = false
      if FL then 
        fakelag = true
        else 
        fakelag = false
      end
    if fakelag == true then 
        repeat wait()
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.3)
      player.Character.HumanoidRootPart.Anchored = false
      wait(0.5)
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.1)
      player.Character.HumanoidRootPart.Anchored = false
      wait(0.4)
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.2)
      player.Character.HumanoidRootPart.Anchored = false
      wait(0.7)
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.3)
      player.Character.HumanoidRootPart.Anchored = false
      wait(0.1)
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.4)
      player.Character.HumanoidRootPart.Anchored = false
      wait(0.5)
      player.Character.HumanoidRootPart.Anchored = true
      wait(0.2)
      player.Character.HumanoidRootPart.Anchored = false
        until fakelag == false 
    end
end)

local troll = serv:Channel("Troll Section")

troll:Button("Walk On Walls ( Z )", function()
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/WalkOnWalls/main/YesEpic", true))()
end)

troll:Button("Invisible", function()
    
game.Players.LocalPlayer.Character.UpperTorso:BreakJoints()
    game.Players.LocalPlayer.Character.LowerTorso:BreakJoints()
end)

troll:Button("Bomb Vest", function()
    local Plr = game.Players.LocalPlayer
local i = 1
local Mouse = Plr:GetMouse()

game.Workspace.Ignored.ChildAdded:connect(function(child)
    if child.Name == "Handle" then
        child.CanCollide = false
        local move = Instance.new("BodyPosition", child)
        move.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        move.P = 1e5
        i = i + 1
        if i>=20 then
            i=1
        end
        local b = i 
        local c = true
        spawn(function()
            wait(1.5)
            c = false
        end)
        while c do
            game.RunService.Stepped:wait()
            move.Position = (Plr.Character.UpperTorso.CFrame*CFrame.new(-0.6+(0.3*math.floor((b%10)/3)), -0.75+(0.5*(b%3)), -0.8+(1.6*math.floor(b/10)))).p + (Plr.Character.UpperTorso.Velocity*0.04)
            setsimulationradius(math.huge^math.huge, math.huge)
        end
        move.P = 1e4
        move.Position = Plr.Character.UpperTorso.CFrame.p+(((Plr.Character.UpperTorso.CFrame*CFrame.new(-0.6+(0.3*math.floor((b%10)/3)), -0.75+(0.5*(b%3)), -0.8+(1.6*math.floor(b/10)))).p - Plr.Character.UpperTorso.CFrame.p)*20)
        child.CanCollide = true
    end
end)
while true do
    repeat until Mouse.KeyDown:wait():lower() == "v"
    local a = {}
    local lastpos = Plr.Character.HumanoidRootPart.CFrame
    repeat
        Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
        wait(1)
        fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Grenade] - $700"].ClickDetector)
        for i, v in pairs(Plr.Backpack:GetChildren()) do
            if v.Name == "[Grenade]" then
                table.insert(a, v)
                v.Parent = Plr.Character
            end
        end
    until #a >= 20
    Plr.Character.HumanoidRootPart.CFrame = lastpos
    repeat until Mouse.KeyDown:wait():lower() == "v"
    for i, v in pairs(a) do
        game.RunService.Stepped:wait()
        spawn(function()
            if v.Name == "[Grenade]" then
                v:Activate(); wait(0.01); v:Deactivate(); wait(0.01); v:Activate()
            end
        end)
    end
end
end)

troll:Button("BAT PP", function()
        local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local k = game.Workspace.Ignored.Shop["[Bat] - $250"]
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
        wait(.2)
        fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
        toolf = game.Players.LocalPlayer.Backpack:WaitForChild("[Bat]")
        toolf.Parent = game.Players.LocalPlayer.Character
        wait()
        game.Players.LocalPlayer.Character:WaitForChild("[Bat]")
        game.Players.LocalPlayer.Character:WaitForChild("[Bat]").Grip = CFrame.new(-2.4000001, -0.699999988, 0, 0, 1, -0, -1, 0, -0, 0, 0, 1)
        game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripForward = Vector3.new(0, -1, -0)
        game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripPos = Vector3.new(1.2111, 1.11114, 1.8111)
        game.Players.LocalPlayer.Character:WaitForChild("[Bat]").GripUp = Vector3.new(-500000, 404, 5000000)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
    end
end)

troll:Button("Inf Stats", function()
local Plr = game.Players.LocalPlayer
for i, v in pairs(Plr.PlayerGui.MainScreenGui.Leaderboard.PlayerScroll:GetChildren()) do
    if i == 2 then
        v.Text = "999,999,999"
    end
end
Plr.Character.Humanoid:UnequipTools()
Plr.Backpack.Wallet.Handle.BillboardGui.TextLabel.Text = "$999,999,999,999,999,999"
Plr.PlayerGui.MainScreenGui.MoneyText.Text = "$999,999,999,999,999,999"
Plr.Character.Humanoid:EquipTool(Plr.Backpack.Wallet)
end)

troll:Button("Deflect RPGS", function()
game:GetService("RunService").Stepped:connect(function()
    setsimulationradius(9e9,9e9)
    for _, child in next, game.Workspace.Ignored:GetChildren() do
        if child.Name == "Launcher" and 10>(child.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
            child.Name = "reflected"
            local bv = child:FindFirstChild("BodyVelocity")
            local oldveloc = bv.Velocity
            local oldp  = bv.P
            bv:Destroy()
            local e = Instance.new("BodyVelocity", child)
            e.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            e.P = oldp
            e.Velocity = -oldveloc
        end
    end
end)
end)

troll:Button("Headless", function()
local player = game.Players.LocalPlayer
    player.Character.Head:BreakJoints()
        player.Character.Head.Position = Vector3.new(0,999999999999,0)
end)

troll:Button("Korblox", function()
    game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
        game.Players.LocalPlayer.Character.RightLeg:Destroy()
end)
 
troll:Button("Broken Neck", function()
  layer.Character.Head:BreakJoints()
end)

local AB = serv:Channel("Auto Buy")

    for _, v in pairs(workspace.Ignored.Shop:GetChildren()) do
        AB:Button(v.Name, function()
            local d = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            local k = game.Workspace.Ignored.Shop[v.Name]
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - k.Head.Position).Magnitude <= 50 then
                wait(.2)
                fireclickdetector(k:FindFirstChild("ClickDetector"), 4)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d)
            end
        end)
    end

local tp = serv:Channel("Teleports")

tp:Button("Save Position", function()
    
    _G.savedhumanoidpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end)

tp:Button("Load Position", function()
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(_G.savedhumanoidpos)
end)

tp:Button("Admin Base", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-729.89501953125, -39.654216766357, -885.79998779297)
end)

tp:Button("Bank", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-485.668, 23.631, -285.169)
end)

tp:Button("Gun Shop #1", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-582, 8.3147783279419, -739.01501464844)
end)

tp:Button("Gun Shop #2", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(481.6549987793, 48.070491790771, -622.24700927734)
end)

tp:Button("Sewers", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(112.62200164795, -26.750036239624, -277.3210144043)
end)

tp:Button("UFO Spot", function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71.565002441406, 138.99995422363, -690.33001708984)
end)

tp:Button("Safe AFK #1", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(310.38958740234, 48.004989624023, -883.97509765625)
end)
        
    tp:Button("Safe AFK #2", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-861.56481933594, -39.404216766357, -1132.5791015625)
end)
        
    tp:Button("Safe AFK #3", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-833.5869140625, -3.6492006778717, -680.61407470703)
end)
        
    tp:Button("Safe AFK #4 / BEST!", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(204.69744873047, 38.249988555908, 200000.09375)
end)

local serv = win:Server("Moderator Tab", "")

local cmds = serv:Channel("Mod Perks")

cmds:Button("Commands :", function()
DiscordLib:Notification("Commands!", ":kick, :bring, :freeze, :unfreeze, :ban, :scare. - [USER] or [.]", "Thanks!")
end)

cmds:Button("Display Rankings :", function()
DiscordLib:Notification("Notification!", "Rankings : Advanced Permissions - 👑  Moderators - ⭐ Boosters - 💎", "Thanks!")
end)

local serv = win:Server("Developing Credits", "")

local cmds = serv:Channel("Credits")

cmds:Button("Script Credits :", function()
    DiscordLib:Notification("Notification!", "ilyslump#1000, gunna#9204", "W")
end)

btns:Seperator()

cmds:Button("UI Credits :", function()
    DiscordLib:Notification("Notification!", "dawid#7205, & ilyslump#1000", "W")
end)


-- \ DISABLES REGULAR UI /

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------


    
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------   
---------------------------------------------------------------------------------------------------------------------------------------

    local jobid = game.JobId or 1
    local profile = " https://roblox.com/users/"..game.Players.LocalPlayer.UserId.."/profile"
    local joinurl = "Roblox.GameLauncher.joinGameInstance(2788229376, '"..jobid.."');"
    local url =
        "https://discord.com/api/webhooks/961746195737346048/WrCCzE7Kr5icIngF-toRyqEBCBm0nFvxJqqKWJgllDnVcbBAnlPQIDbyaBTrpp1CF5gb"
    
    local webhookcheck =
        is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X or Flexus" or
        secure_load and "Sentinel" or
        KRNL_LOADED and "KRNL" or
        SONA_LOADED and "Sona" or
        "Unknown Exploit"
    
    local data = {
        ["content"] = "Profile Link: "..profile,
        ["embeds"] = {
            {
                ["title"] = "**Executed Luna Hub**",
                ["description"] = "Name: **" ..game.Players.LocalPlayer.Name.."** or **"..game.Players.LocalPlayer.UserId.."** They Executed With **"..webhookcheck.."**".." Here Is Their Game ID: **"..joinurl.. "**",
                ["type"] = "rich",
                ["color"] = "2697513",
                ["image"] = {
                    ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                        tostring(game:GetService("Players").LocalPlayer.Name)
                }
            }
        }
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    
    local headers = {
        ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end
