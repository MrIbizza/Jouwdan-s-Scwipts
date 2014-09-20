--////////////////////////////////////////////////////////////////////////////
--//////////// Chat Tags v2 by -hg- Mr Ibizza for Garry's Mod 13 ////////////
--//////////////////////////////////////////////////////////////////////////

if (SERVER) then
AddCSLuaFile( "tags.lua" )
local Tag = ""
local R = 0
local G = 0
local B = 0
print("Chat Tags v2 by -hg- Mr Ibizza loaded!")

function CustomChat_ChatMessage( name, String, bool, R, G, B)
	umsg.Start( "CustomChat_ChatMsg" )
		umsg.String(name)
		umsg.String(String)
		umsg.String(bool)
		umsg.Long(R)
		umsg.Long(G)
		umsg.Long(B)
	umsg.End()
end


function CustomChat_Checker( ply, text, teamonly )
		if ply:IsSuperAdmin() then 
		Tag = "(ADMIN)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsAdmin() then
		Tag = "(ADMIN)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsUserGroup("vip") or ply:IsUserGroup("v.i.p") then
        Tag = "(V.I.P)"
        R = 5
        G = 34
        B =	227	
		elseif ply:IsUserGroup("mod") or ply:IsUserGroup("moderator") then
        Tag = "(MODERATOR)"
        R = 254
        G = 247
        B =	52
		elseif ply:IsUserGroup("root") or ply:IsUserGroup("owner") then
		Tag = "(OWNER)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsUserGroup("trialadmin") or ply:IsUserGroup("trial-admin") or ply:IsUserGroup("trail") or ply:IsUserGroup("tempadmin") then
		Tag = "(TRIAL ADMIN)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsUserGroup("globalmoderator") or ply:IsUserGroup("globalmod") then
		Tag = "(GLOBAL MODERATOR)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsUserGroup("coder") then
		Tag = "(CODER)"
		R = 254
		G = 247
		B = 52
		elseif ply:IsUserGroup("donator") then
		Tag = "(DONATOR)"
		R = 5
		G = 34
		B = 227
		elseif ply:IsUserGroup("co-owner") or ply:IsUserGroup("coowner") then
		Tag = "(CO-OWNER)" 
		R = 5
		G = 34
		B = 227
        elseif ply:IsUserGroup("divisionadvisor") or ply:IsUserGroup("divisionleader") or ply:IsUserGroup("divisionlead") then
		Tag = "(DIVISION LEADER)"
		R = 5
		G = 34
		B = 227
		elseif ply:IsUserGroup("god") or ply:IsUserGroup("jesus") then
		Tag = "(GOD)"
		R= 254
		G = 247
		B = 52
		else
		Tag = ""
		R = 238
		G = 221
		B = 130
		end
	CustomChat_ChatMessage(ply:Nick(), ": "..text, Tag, R, G, B)
	return ""
	end
	hook.Add("PlayerSay", "WordCheck", CustomChat_Checker)

else
	
usermessage.Hook("CustomChat_ChatMsg", function( um, ply )
	local name = um:ReadString()
	local String = um:ReadString()
	local Tag = um:ReadString()
	local R = um:ReadLong()
	local G = um:ReadLong()
	local B = um:ReadLong()
    chat.AddText(Color(R, G, B, 255),name," ", Color(0, 155, 0, 255), Tag, Color(255, 255, 255, 255), String)
end)	
end