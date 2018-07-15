local NugArt = CreateFrame("Frame")

local MainMenuBarTexturesOffset = 0

local f = CreateFrame("Frame", "NugArtMainMenuBackground", UIParent)
f:SetFrameStrata("BACKGROUND")
f:SetPoint("BOTTOM",83+MainMenuBarTexturesOffset,0)
f:SetSize(50, 50)

f.MakeBackgroundTexture = function(self, name, numSlots)
    local t = f:CreateTexture(name, "BACKGROUND", nil, 1)
    t:SetAtlas("hud-MainMenuBar-small")
    -- t:SetTexture("Interface\\MainMenuBar\\UI-MainMenuBar-Dwarf")
    -- local crop = 0.01
    -- local crop = 0.086
    local crop = 0.01 + (0.0762*numSlots)
    t:SetSize(550* crop, 49)
    t:SetTexCoord(0, crop, 0, 1)
    return t
end

local m = 0.75

local t1 = f:MakeBackgroundTexture("NugArtBackgroundLeft", 12.07)
t1:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT",9,0)
t1:SetVertexColor(m,m,m)
local t2 = f:MakeBackgroundTexture("NugArtBackgroundRight", 7.15)
t2:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT",45,0)
t2:SetVertexColor(m,m,m)

local leftcap = f:CreateTexture("NugArtLeftCap", "BACKGROUND", nil, 2)
leftcap:SetSize(93, 93)
leftcap:SetTexture("Interface\\AddOns\\NugArt\\textures\\SkullCap4")
leftcap:SetPoint("BOTTOMRIGHT", t1, "BOTTOMLEFT",9,0)

local rightcap = f:CreateTexture("NugArtRightCap", "ARTWORK", nil, 2)
rightcap:SetSize(162, 81)
rightcap:SetTexture("Interface\\AddOns\\NugArt\\textures\\d3demonCap")
rightcap:SetPoint("BOTTOMLEFT", t2, "BOTTOMRIGHT",-73,0)

f:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)

f:RegisterEvent("PET_BATTLE_OPENING_START")
f:RegisterEvent("PET_BATTLE_CLOSE")

function f:PET_BATTLE_OPENING_START()
    self:Hide()
end
function f:PET_BATTLE_CLOSE()
    self:Show()
end





local textures = {
	["Chatbg1"] = {
		["strata"] = "BACKGROUND",
		["to"] = "BOTTOMLEFT",
		["scale"] = 2,
        ["layer"] = "BACKGROUND",
        ["layerLevel"] = -6,
		["alpha"] = 0.8,
		["width"] = 300,
		["y"] = 0,
		["x"] = -6,
		["disable"] = false,
		["height"] = 300,
		["level"] = 0,
		["point"] = "BOTTOMLEFT",
		["texture"] = "Interface\\AddOns\\NugArt\\textures\\ABRight",
	},
	-- ["CapRight"] = {
	-- 	["strata"] = "MEDIUM",
	-- 	["point"] = "BOTTOM",
	-- 	["parent"] = "UIParent",
	-- 	["width"] = 240,
	-- 	["y"] = 0,
	-- 	["x"] = 422,
	-- 	["height"] = 120,
	-- 	["level"] = 5,
	-- 	["to"] = "BOTTOM",
	-- 	["texture"] = "Interface\\AddOns\\NugArt\\textures\\d3demonCap",
	-- },
	-- ["SkullCap"] = {
	-- 	["strata"] = "MEDIUM",
	-- 	["to"] = "BOTTOM",
	-- 	["parent"] = "UIParent",
	-- 	["width"] = 93,
	-- 	["y"] = 0,
	-- 	["x"] = -439,
	-- 	["height"] = 93,
	-- 	["level"] = 5,
	-- 	["point"] = "BOTTOM",
	-- 	["texture"] = "Interface\\AddOns\\NugArt\\textures\\SkullCap4",
	-- },

	["Chatbg2"] = {
		["strata"] = "BACKGROUND",
		["point"] = "BOTTOMLEFT",
		["scale"] = 2,
        ["layer"] = "BACKGROUND",
        ["layerLevel"] = -5,
		["width"] = 350,
		["y"] = -6,
		["x"] = -6,
		["disable"] = false,
		["height"] = 350,
		["level"] = 1,
		["to"] = "BOTTOMLEFT",
		["texture"] = "Interface\\AddOns\\NugArt\\textures\\HF-1",
    },
    -- ["ABbgleft"] = {
	-- 	["point"] = "BOTTOMRIGHT",
	-- 	["scale"] = 1.37,
	-- 	["alpha"] = 1,
	-- 	["width"] = 300,
	-- 	["y"] = -30,
	-- 	["x"] = -190,
	-- 	["disable"] = false,
	-- 	["height"] = 300,
	-- 	["parent"] = "UIParent",
	-- 	["to"] = "BOTTOM",
	-- 	["texture"] = "Interface\\AddOns\\NugArt\\textures\\ABLeft",
	-- },
	-- ["ABbgright"] = {
	-- 	["point"] = "BOTTOMLEFT",
	-- 	["scale"] = 1.37,
	-- 	["width"] = 300,
	-- 	["y"] = -30,
	-- 	["x"] = -190,
	-- 	["height"] = 300,
	-- 	["parent"] = "UIParent",
	-- 	["to"] = "BOTTOM",
	-- 	["texture"] = "Interface\\AddOns\\NugArt\\textures\\ABRight",
	-- },
}


local frames = {}

function NugArt.Render()
    local pr = textures
    for name, opts in pairs(pr) do
        if not frames[name] and not opts.disable then
            frames[name] = CreateFrame("Frame","NugArt_"..name,UIParent)
            frames[name].texture = frames[name]:CreateTexture(nil,"ARTWORK")
            frames[name].texture:SetAllPoints(frames[name])
        end
    end
    for name, f in pairs(frames) do
        local opts = pr[name]
        if opts and not opts.disable then
            f:SetParent(opts.frameparent or "UIParent")
            f:SetHeight(opts.height or 64)
            f:SetWidth(opts.width or 64)
            f:SetScale(opts.scale or 1)
            f:SetAlpha(opts.alpha or 1)
            f:SetFrameStrata(opts.strata or "BACKGROUND")
            f:SetFrameLevel(opts.level or 1)
            f.texture:SetDrawLayer(opts.layer or "ARTWORK", opts.layerLevel or 0)
            f.texture:SetTexture(opts.texture or "")
            f:ClearAllPoints()
            f:SetPoint(opts.point or "CENTER",opts.parent or "UIParent",opts.to or "CENTER",opts.x or 0,opts.y or 0)
            f:Show()
        else
            f:Hide()
        end
    end
end


NugArt.Render()
-- MainMenuBarLeftEndCap:Hide()
-- MainMenuBarRightEndCap:Hide()
-- local m = 0.6
-- MainMenuBarLeftEndCap:SetVertexColor(m,m,m)
-- MainMenuBarRightEndCap:SetVertexColor(m,m,m)
-- MainMenuBarTexture0:SetVertexColor(m,m,m)
-- MainMenuBarTexture1:SetVertexColor(m,m,m)
-- MainMenuBarTexture2:SetVertexColor(m,m,m)
-- MainMenuBarTexture3:SetVertexColor(m,m,m)
-- MainMenuMaxLevelBar0:SetVertexColor(m,m,m)
-- MainMenuMaxLevelBar1:SetVertexColor(m,m,m)
-- MainMenuMaxLevelBar2:SetVertexColor(m,m,m)
-- MainMenuMaxLevelBar3:SetVertexColor(m,m,m)

--[[[--~ ***LAYER***
--~ BACKGROUND - Level 0. Place the background of your frame here.
--~ BORDER - Level 1. Place the artwork of your frame here .
--~ ARTWORK - Level 2. Place the artwork of your frame here.
--~ OVERLAY - Level 3. Place your text, objects, and buttons in this level.
--~ HIGHLIGHT - Level 4. Place your text, objects, and buttons in this level.

--~ ***STRATA***
--~ PARENT
--~ BACKGROUND
--~ LOW
--~ MEDIUM
--~ HIGH
--~ DIALOG
--~ FULLSCREEN
--~ FULLSCREEN_DIALOG
--~ TOOLTIP

--~ ***ALPHA MDOE***:
--~ DISABLE - opaque texture
--~ BLEND - normal painting on top of the background, obeying alpha channels if present in the image (uses alpha)
--~ ALPHAKEY - one-bit alpha
--~ ADD - additive blend
--~ MOD - modulating blend

NugArt = CreateFrame("Frame","NugArt")

NugArt:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

NugArt:RegisterEvent("ADDON_LOADED")

local frames = {}

local valid_options = {
    ["width"] = true,
    ["height"] = true,
    ["texture"] = true,
    ["disable"] = true,
    ["alpha"] = true,
    ["scale"] = true,
    ["strata"] = true,
    ["layer"] = true,
    ["level"] = true,
    ["frameparent"] = true,
    ["point"] = true,
    ["parent"] = true,
    ["to"] = true,
    ["x"] = true,
    ["y"] = true,
}

function NugArt.ADDON_LOADED(self,event,arg1)
    if arg1 == "NugArt" then
        NugArtProfile = NugArtProfile or "Default"
        NugArtDB = NugArtDB or {}
        NugArtDB.profiles = NugArtDB.profiles or {}
        NugArtDB.profiles.Default = NugArtDB.profiles.Default or {}

        NugArt.Render()

        SLASH_NUGART1= "/na"
        SLASH_NUGART2 = "/nugart"
        SlashCmdList["NUGART"] = NugArt.SlashCmd
    end
end

function NugArt.Render()
    local pr = NugArtDB.profiles[NugArtProfile]
    for name, opts in pairs(pr) do
        if not frames[name] and not opts.disable then
            frames[name] = CreateFrame("Frame","NugArt_"..name,UIParent)
            frames[name].texture = frames[name]:CreateTexture(nil,"ARTWORK")
            frames[name].texture:SetAllPoints(frames[name])
        end
    end
    for name, f in pairs(frames) do
        local opts = pr[name]
        if opts and not opts.disable then
            f:SetParent(opts.frameparent or "UIParent")
            f:SetHeight(opts.height or 64)
            f:SetWidth(opts.width or 64)
            f:SetScale(opts.scale or 1)
            f:SetAlpha(opts.alpha or 1)
            f:SetFrameStrata(opts.strata or "BACKGROUND")
            f:SetFrameLevel(opts.level or 1)
            f.texture:SetDrawLayer(opts.layer or "ARTWORK")
            f.texture:SetTexture(opts.texture or "")
            f:ClearAllPoints()
            f:SetPoint(opts.point or "CENTER",opts.parent or "UIParent",opts.to or "CENTER",opts.x or 0,opts.y or 0)
            f:Show()
        else
            f:Hide()
        end
    end
end

function NugArt.SlashCmd(msg)
    k,v = string.match(msg, "(%w+) ?(.*)")
    if k == "help" or not k then print(Usage:
      |cff00ff00/na|r create <name> - create new texture
      |cff00ff00/na|r set name=<name> width=100 height=100 texture=&a\CapLeft point=BOTTOMLEFT parent=UIParent to=BOTTOM x=12 y=32 [disable=true/false scale=1 strata=HIGH level=1 layer=ARTWORK frameparent=TargetFrame alpha=0.8]
      Only required option in set is name=, though you won't see anything without some neccesary fields (w,h,tex)
      &a - shortcut to Interface\\AddOns\\NugArt\\textures
      |cff00ff00/na|r info <name>
      |cff00ff00/na|r delete <name>
      |cff00ff00/na|r list

      |cff00ff00/na|r newprofile
      |cff00ff00/na|r listprofile
      |cff00ff00/na|r deleteprofile
      |cff00ff00/na|r changeprofile

    )
    elseif k == "set" then
        local name, p = NugArt.Parse(v,valid_options)
        if not name then print("name missing"); return end
        for field, val in pairs(p) do
            NugArtDB.profiles[NugArtProfile][name][field] = val
        end
        NugArt.Render()
    elseif k == "list" then
        print("Textures list:")
        for name,tbl in pairs(NugArtDB.profiles[NugArtProfile]) do
            print(string.format("   %s :  %s",name,tbl.texture or "<No Texture>"))
        end
    elseif k == "info" then
        if not NugArtDB.profiles[NugArtProfile][v] then print(v.." not exists"); return end
        print("Details for "..v)
        for opt,val in pairs(NugArtDB.profiles[NugArtProfile][v]) do
            print("   "..opt.." = "..val)
        end
    elseif k == "create" then
        if not string.match(v,"(%w+)") then print("incorrect name"); return end
        NugArtDB.profiles[NugArtProfile][v] = {}
    elseif k == "delete" or k == "del" then
        if not NugArtDB.profiles[NugArtProfile][v] then print(v.." not exists"); return end
        NugArtDB.profiles[NugArtProfile][v] = nil
        NugArt.Render()
    elseif k == "newprofile" then
        if not string.match(v,"(%w+)") then print("incorrect name"); return end
        NugArtDB.profiles[v] = {}
    elseif k == "listprofile" then
        print("NugArt profiles:")
        for pf in pairs(NugArtDB.profiles) do
            print("  "..pf)
        end
    elseif k == "changeprofile" then
        if not NugArtDB.profiles[v] then print(v.." profile not exists"); return end
        NugArtProfile = v
        NugArt.Render()
    elseif k == "delprofile" or k == "deleteprofile" then
        if not NugArtDB.profiles[v] then print("invalid profile name") end
        StaticPopupDialogs["NUGART_DELPROFILE"] = {
            text = string.format("Confirm %s profile removal?",v),
            button1 = "Confirm",
            button2 = "Abort",
            OnAccept = function()
                NugArtDB.profiles[v] = nil
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 0
        };
        StaticPopup_Show ("NUGART_DELPROFILE")
    end
end
function NugArt.Parse(str,valid)
    local fields = {}
    local name
    for opt,v in string.gmatch(str,"(%w*)=([%w%_%.%-%&%\\]+)") do
        opt = string.lower(opt)
        if opt == "name" then
            name = v
        elseif valid[opt] then
            if v == "nil" then v = nil end
            if v == "true" then v = true end
            if v == "false" then v = false end
            if tonumber(v) then v = tonumber(v) end
            if opt == "texture" then v = string.gsub(v,"&a","Interface\\AddOns\\NugArt\\textures"); print("Texture path: "..v) end
            if opt == "layer" or opt == "strata" or opt == "point" or opt == "to" then v = string.upper(v) end
            fields[opt] = v
        else
            print(string.format('Unknown field "%s"',opt))
        end
    end
    return name,fields
end]]
