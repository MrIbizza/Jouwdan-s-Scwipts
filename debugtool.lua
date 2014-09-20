TOOL.Category		= "Jordie"		// Name of the category
TOOL.Name			= "#DebugInfo"		// Name to display
TOOL.Command		= nil				// Command on click (nil for default)
TOOL.ConfigName		= nil				// Config file name (nil for default)
TOOL.used = 0

// An example clientside convar
TOOL.ClientConVar["CLIENTSIDE"] = "default"

// An example serverside convar
TOOL.ServerConVar["SERVERSIDE"] = "default"

function TOOL:LeftClick()
if SERVER then
	if self.used > CurTime() then return end
	self.used = CurTime() + 1
	local tracedata = {}
	tracedata.start = self:GetOwner():GetShootPos()
	tracedata.endpos = tracedata.start + ( self:GetOwner():GetAimVector() * 15000 )
	tracedata.filter = self:GetOwner()
	tracedata.mask = -1
	local trace = util.TraceLine( tracedata )
	if trace.Entity and trace.Entity:IsValid() then
		/*if trace.Entity:GetName() then self:GetOwner():ChatPrint("Name: " .. trace.Entity:GetName() ) end*/
		self:GetOwner():ChatPrint("Entity: " .. tostring(trace.Entity) )
		self:GetOwner():ChatPrint("Pos: " .. tostring(trace.Entity:GetPos()) )
		self:GetOwner():ChatPrint("Angles: " .. tostring(trace.Entity:GetAngles()) )
		self:GetOwner():ChatPrint("Class: " .. tostring(trace.Entity:GetClass()) )
		self:GetOwner():ChatPrint("Model: " .. tostring(trace.Entity:GetModel()) )
		self:GetOwner():ChatPrint("OBB Min/Max: " .. tostring(trace.Entity:OBBMins()) .. "/" .. tostring(trace.Entity:OBBMaxs()) )
		self:GetOwner():ChatPrint("Mass: " .. tostring(trace.Entity:GetPhysicsObject():GetMass()) )
	else
		self:GetOwner():ChatPrint("Hit non-entity.")
		self:GetOwner():ChatPrint("Position: " .. tostring(trace.HitPos))
	end

	if trace.Entity:IsVehicle() then
		local tracedata = {}
		tracedata.start = self:GetOwner():GetShootPos()
		tracedata.endpos = tracedata.start + ( self:GetOwner():GetAimVector() * 15000 )
		tracedata.filter = { self:GetOwner(), trace.Entity }
		tracedata.mask = -1
		local trace = util.TraceLine( tracedata )
		self:GetOwner():ChatPrint("Trace ignoring vehicle...")
		if trace.Entity and trace.Entity:IsValid() then
			self:GetOwner():ChatPrint("Entity: " .. tostring(trace.Entity) )
			self:GetOwner():ChatPrint("Pos: " .. tostring(trace.Entity:GetPos()) )
			self:GetOwner():ChatPrint("Angles: " .. tostring(trace.Entity:GetAngles()) )
			self:GetOwner():ChatPrint("Class: " .. tostring(trace.Entity:GetClass()) )
			self:GetOwner():ChatPrint("Model: " .. tostring(trace.Entity:GetModel()) )
			self:GetOwner():ChatPrint("OBB Min/Max: " .. tostring(trace.Entity:OBBMins()) .. "/" .. tostring(trace.Entity:OBBMaxs()) )			self:GetOwner():ChatPrint("Mass: " .. tostring(trace.Entity:GetPhysicsObject():GetMass()) )
		else
			self:GetOwner():ChatPrint("Hit non-entity.")
		end
	end
end
end

function TOOL:RightClick( trace )
end

function TOOL:Reload()
end

function TOOL:Think()
end