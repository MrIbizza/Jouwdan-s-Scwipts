surface.CreateFont( "healthf", {
 font = "Bebas Neue",
 size = 16,
 weight = 500,
 blursize = 0,
 scanlines = 0,
 antialias = true
} )

surface.CreateFont( "namef", {
 font = "Bebas Neue",
 size = 24,
 weight = 500,
 blursize = 0,
 scanlines = 0,
 antialias = true
} )

surface.CreateFont( "namefsmall", {
 font = "Bebas Neue",
 size = 16,
 weight = 500,
 blursize = 0,
 scanlines = 0,
 antialias = true
} )

local function DrawPlayerAvatar( p )
	av = vgui.Create("AvatarImage")
	av:SetPos(85,ScrH() - 973)
	av:SetSize(59, 59)
	av:SetPlayer( p, 64 )
end


function DrawIt()
if not LocalPlayer():Alive() then return end
local ply = LocalPlayer()
local Wi = surface.ScreenWidth()
local He = surface.ScreenHeight()


 --avatar image place thing
draw.RoundedBox( 1, 125, ScrH() - 973, 190, 59, Color(80,80,80,255) )
surface.SetTexture(0)
surface.SetDrawColor(125, 125, 125, 255 ) 


--[[surface.SetFont( "namef" )
	local PlayerName = LocalPlayer():Name()
	local Width, Height = surface.GetTextSize(PlayerName)
	if Width > 100 then
		font = "namefsmall"
	else
		font = "namef"
	end
	
	surface.SetFont( "namefsmall" )
	local wh, hw = surface.GetTextSize(PlayerName)
	if font == "namefsmall" and wh > 100 then
		PlayerName = string.sub( LocalPlayer():Name(), 1, 18 )..".."
	end
	
	if font == "namef" and Width < 100 then
		local PlayerName = LocalPlayer():Name()
	end
	
	draw.SimpleText( PlayerName, font, 185, ScrH() - 968, Color( 255, 255, 255 ) )
	

//name
local text = ply:Name()
local txtlen = string.len(tostring(text)) * 150 / 50
draw.SimpleText( tostring(text), "healthf", Wi / 5 - txtlen, He / 18, {r = 255, g = 255, b = 0, a = 255}, 0, 0 )
]]--

// health
local width = 150 * math.Clamp( ply:Health() / 100, 0, 1 )
draw.RoundedBox( 1, 160, ScrH() - 960, 150, 15, { r = 50, g = 50 , b = 50, a = 200} )
draw.RoundedBox( 1, 160, ScrH() - 960, 150, 14, { r = 0, g = 170 , b = 0, a = 255} )
draw.SimpleText( "Health: " .. tostring(ply:Health()) .. "/100", "healthf", 200, ScrH() - 960, {r = 255, g = 255, b = 255, a = 255}, 0, 0 )

//armor
	local armor = LocalPlayer():Armor()
	draw.RoundedBox(1, 160, ScrH() - 944, 150, 13, Color(0,0,0,200))
	if armor > 0 then
		draw.RoundedBox(1,160, ScrH() - 944, 150, 12, Color(40,40,255,255))
	end
	draw.SimpleText("Armor: " .. tostring(ply:Armor()) .. "/100", "healthf", 200, ScrH() - 944, Color(255,255,255,200))

// ammo
if not ply:Alive() then return end
if not ply:GetActiveWeapon():IsValid() then return end
local am = AMMO[ ply:GetActiveWeapon():GetClass() ] or 0
local width = 150 * math.Clamp( ply:GetActiveWeapon():Clip1() / am, 0, 1 ) 
local PAType = ply:GetActiveWeapon():GetPrimaryAmmoType()
local PATotal = tostring(ply:GetAmmoCount(PAType))
draw.RoundedBox( 1, 160, ScrH() - 930.5, 150, 15, { r = 50, g = 50 , b = 50, a = 200} )
draw.RoundedBox( 1, 160, ScrH() - 930.5, 150, 14, { r = 0, g = 0, b= 205, a = 255} )
draw.SimpleText( "Ammo: " .. tostring(ply:GetActiveWeapon():Clip1()) .. "/" .. tostring(am) .. " [" .. PATotal .. "]", "healthf", 200, ScrH() - 930.5, {r = 255, g = 255, b = 255, a = 255}, 0, 0 )
if av then
		return
	else
		DrawPlayerAvatar( LocalPlayer() )
	end

end

hook.Add("HUDPaint", "huddy", DrawIt)

function disableCHUD(name)
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then 
		return false 
	end
end
hook.Add("HUDShouldDraw", "disableHUD", disableCHUD)

AMMO = {}
AMMO2 = {}
function ControlAmmo()
	local pl = LocalPlayer()
	if not pl:Alive() then return end
	if not pl:GetActiveWeapon():IsValid() then return end
	local n = AMMO[ pl:GetActiveWeapon():GetClass() ] or 0
 
	if pl:GetActiveWeapon():Clip1() > n then
		n = pl:GetActiveWeapon():Clip1()
	end
		
	AMMO[ pl:GetActiveWeapon():GetClass() ] = n
	
	local l = AMMO[ pl:GetActiveWeapon():GetClass() ] or 0
 
	if pl:GetActiveWeapon():Clip1() > l then
		l = pl:GetActiveWeapon():Clip1()
	end
		
	AMMO2[ pl:GetActiveWeapon():GetClass() ] = l
end 

 
hook.Add( "Think", "ControlAmmoHud", ControlAmmo ) 
