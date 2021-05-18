print("AntiAFK Script by Senko Kitsune")

print("mirror_degree - switch the mirror degree")
print("toggle_mirror - enabling or disabling Mirror")

mirroropened=false
last=nil

CreateClientConVar( "mirror_degree", 180)

function Drawmirror()
		if mirroropened then
		local frame = vgui.Create( "DFrame" )
		frame:ShowCloseButton(false)
		frame:SetPos(20, 20)
		frame:SetSize( ScrW() / 5, ScrH() / 5)
		frame:SetDraggable(false)
		frame:SetTitle("")
		frame:MakePopup()
		frame:SetMouseInputEnabled(false)
		frame:SetKeyBoardInputEnabled(false)
		last=frame
				function frame:Paint( w, h )
				local x, y = self:GetPos()
				render.RenderView({origin = LocalPlayer():EyePos(),angles = Angle(0,LocalPlayer():EyeAngles().yaw - GetConVarNumber( "mirror_degree") ,0),fov =100,x = x, y = y,w = w, h = h})
				end
		end
end

function toggle_mirror()
		if mirroropened == true then
				mirroropened=false
				last:Close()
		else
				mirroropened = true
				Drawmirror()
		end
end

concommand.Add( "toggle_mirror", toggle_mirror)