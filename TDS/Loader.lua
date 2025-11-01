if game.PlaceId ~= 3260590327 and game.PlaceId ~= 5591597781 then return end
if getgenv().StrategiesXLoader then
    return
end
getgenv().ExecDis = true
if getgenv().Config then
    return
end
local OldTime = os.clock()
if not isfolder("StrategiesX") then
    makefolder("StrategiesX")
    makefolder("StrategiesX/UserLogs")
    makefolder("StrategiesX/UserConfig")
elseif not isfolder("StrategiesX/UserLogs") then
    makefolder("StrategiesX/UserLogs")
elseif not isfolder("StrategiesX/UserConfig") then
    makefolder("StrategiesX/UserConfig")
end

getgenv().WriteFile = function(check,name,location,str)
    if not check then
        return
    end
    if type(name) == "string" then
        if not type(location) == "string" then
            location = ""
        end
        if not isfolder(location) then
            makefolder(location)
        end
        if type(str) ~= "string" then
            error("Argument 4 must be a string got " .. tostring(number))
        end
        writefile(location.."/"..name..".txt",str)
    else
        error("Argument 2 must be a string got " .. tostring(number))
    end
end
getgenv().AppendFile = function(check,name,location,str)
    if not check then
        return
    end
    if type(name) == "string" then
        if not type(location) == "string" then
            location = ""
        end
        if not isfolder(location) then
            WriteFile(check,name,location,str)
        end
        if type(str) ~= "string" then
            error("Argument 4 must be a string got " .. tostring(number))
        end
        if isfile(location.."/"..name..".txt") then
            appendfile(location.."/"..name..".txt",str)
        else
            WriteFile(check,name,location,str)
        end
    else
        error("Argument 2 must be a string got " .. tostring(number))
    end
end
local writelog = function(...)
    local TableText = {...}
    task.spawn(function()
        if not game:GetService("Players").LocalPlayer then
            repeat task.wait() until game:GetService("Players").LocalPlayer
        end
        for i,v in next, TableText do
            if type(v) ~= "string" then
                TableText[i] = tostring(v)
            end
        end
        local Text = table.concat(TableText, " ")
        print(Text)
        return WriteFile(true,game:GetService("Players").LocalPlayer.Name.."'s log","StrategiesX/UserLogs",tostring(Text))
    end)
end
local appendlog = function(...)
    local TableText = {...}
    task.spawn(function()
        if not game:GetService("Players").LocalPlayer then
            repeat task.wait() until game:GetService("Players").LocalPlayer
        end
        for i,v in next, TableText do
            if type(v) ~= "string" then
                TableText[i] = tostring(v)
            end
        end
        local Text = table.concat(TableText, " ")
        print(Text)
        return AppendFile(true,game:GetService("Players").LocalPlayer.Name.."'s log","StrategiesX/UserLogs",tostring(Text).."\n")
    end)
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/startsX89w/Strategies-X/refs/heads/main/TDS/MainSource.lua"))()
appendlog("Hooked AutoStrat Main Library Using loadstring")

getgenv().StrategiesXLoader = true
appendlog("Strategies X Loader Loaded: "..tostring(os.clock() - OldTime))
