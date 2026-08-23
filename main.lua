local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local MAX_SLOTS = 8

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MobileInventory"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--==================================================
-- NÚT BALO
--==================================================

local Bag = Instance.new("TextButton")
Bag.Name = "Bag"
Bag.Size = UDim2.fromOffset(45, 45)
Bag.Position = UDim2.new(1, -60, 0.65, 0)

Bag.Text = "🎒"
Bag.TextSize = 24

Bag.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Bag.BorderSizePixel = 0
Bag.Parent = Gui

local BagCorner = Instance.new("UICorner")
BagCorner.CornerRadius = UDim.new(1, 0)
BagCorner.Parent = Bag

--==================================================
-- NÚT KHÓA
--==================================================

local LockButton = Instance.new("TextButton")
LockButton.Name = "Lock"
LockButton.Size = UDim2.fromOffset(28, 28)

LockButton.Position = UDim2.new(
	1,
	-51,
	0.65,
	-34
)

LockButton.Text = "🔒"
LockButton.TextSize = 14

LockButton.BackgroundColor3 =
	Color3.fromRGB(220, 45, 45)

LockButton.BorderSizePixel = 0
LockButton.Parent = Gui

local LockCorner = Instance.new("UICorner")
LockCorner.CornerRadius = UDim.new(1, 0)
LockCorner.Parent = LockButton

local Locked = true

--==================================================
-- INVENTORY
--==================================================

local Inventory = Instance.new("Frame")
Inventory.Name = "Inventory"

Inventory.Size = UDim2.fromOffset(390, 145)

Inventory.Position = UDim2.new(
	1,
	-405,
	0.65,
	65
)

Inventory.BackgroundColor3 =
	Color3.fromRGB(20, 20, 20)

-- NỀN TRONG SUỐT 75%
Inventory.BackgroundTransparency = 0.75

Inventory.BorderSizePixel = 0
Inventory.Visible = false
Inventory.Parent = Gui

local InvCorner = Instance.new("UICorner")
InvCorner.CornerRadius = UDim.new(0, 12)
InvCorner.Parent = Inventory

--==================================================
-- 8 SLOT
--==================================================

local SlotFrame = Instance.new("Frame")

SlotFrame.Size =
	UDim2.new(1, -10, 0, 55)

SlotFrame.Position =
	UDim2.fromOffset(5, 5)

SlotFrame.BackgroundTransparency = 1
SlotFrame.Parent = Inventory

local Layout = Instance.new("UIListLayout")

Layout.FillDirection =
	Enum.FillDirection.Horizontal

Layout.HorizontalAlignment =
	Enum.HorizontalAlignment.Center

Layout.VerticalAlignment =
	Enum.VerticalAlignment.Center

Layout.Padding =
	UDim.new(0, 4)

Layout.Parent = SlotFrame

local Slots = {}
local SlotTools = {}

for i = 1, MAX_SLOTS do

	local Slot = Instance.new("TextButton")

	Slot.Name = "Slot" .. i
	Slot.Size = UDim2.fromOffset(45, 45)

	Slot.Text = tostring(i)
	Slot.TextSize = 10

	Slot.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	-- CHỮ TRONG SUỐT 60%
	Slot.TextTransparency = 0.60

	Slot.TextWrapped = true

	Slot.BackgroundColor3 =
		Color3.fromRGB(40, 40, 40)

	Slot.BackgroundTransparency = 0.15

	Slot.BorderSizePixel = 0
	Slot.Parent = SlotFrame

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Slot

	Slots[i] = Slot
	SlotTools[i] = nil
end

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("TextLabel")

Logo.Name = "Logo"
Logo.Size = UDim2.fromOffset(100, 25)
Logo.Position = UDim2.fromOffset(10, 65)

Logo.BackgroundTransparency = 1
Logo.Text = "ChatGPT"

Logo.TextColor3 =
	Color3.fromRGB(255, 255, 255)

-- CHỮ TRONG SUỐT 60%
Logo.TextTransparency = 0.60

Logo.TextSize = 14
Logo.Font = Enum.Font.GothamBold

Logo.TextXAlignment =
	Enum.TextXAlignment.Left

Logo.Parent = Inventory

--==================================================
-- NÚT QUÉT
--==================================================

local Scan = Instance.new("TextButton")

Scan.Name = "Scan"
Scan.Size = UDim2.fromOffset(105, 30)

Scan.Position = UDim2.new(
	1,
	-115,
	0,
	65
)

Scan.Text = "🔍 QUÉT"
Scan.TextSize = 13

Scan.TextColor3 =
	Color3.fromRGB(255, 255, 255)

-- CHỮ TRONG SUỐT 60%
Scan.TextTransparency = 0.60

Scan.BackgroundColor3 =
	Color3.fromRGB(35, 35, 35)

Scan.BackgroundTransparency = 0.1

Scan.BorderSizePixel = 0
Scan.Parent = Inventory

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 8)
ScanCorner.Parent = Scan

--==================================================
-- DROP ITEM
--==================================================

local DropButton = Instance.new("TextButton")

DropButton.Name = "DropItem"

DropButton.Size =
	UDim2.fromOffset(105, 27)

DropButton.Position = UDim2.new(
	1,
	-115,
	0,
	102
)

DropButton.Text = "🗑 DROP ITEM"
DropButton.TextSize = 11

DropButton.TextColor3 =
	Color3.fromRGB(255, 255, 255)

-- CHỮ TRONG SUỐT 60%
DropButton.TextTransparency = 0.60

DropButton.BackgroundColor3 =
	Color3.fromRGB(35, 35, 35)

DropButton.BackgroundTransparency = 0.1

DropButton.BorderSizePixel = 0
DropButton.Parent = Inventory

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 8)
DropCorner.Parent = DropButton

--==================================================
-- QUÉT TOOL
--==================================================

local function ScanTools()

	for i = 1, MAX_SLOTS do

		SlotTools[i] = nil

		Slots[i].Text =
			tostring(i)

		Slots[i].BackgroundColor3 =
			Color3.fromRGB(40, 40, 40)

	end

	local Tools = {}
	local Seen = {}

	local Backpack =
		Player:FindFirstChild("Backpack")

	if Backpack then

		for _, Object in
			ipairs(Backpack:GetChildren()) do

			if Object:IsA("Tool")
				and not Seen[Object] then

				Seen[Object] = true
				table.insert(Tools, Object)

			end

		end

	end

	local Character =
		Player.Character

	if Character then

		for _, Object in
			ipairs(Character:GetChildren()) do

			if Object:IsA("Tool")
				and not Seen[Object] then

				Seen[Object] = true
				table.insert(Tools, Object)

			end

		end

	end

	for i = 1,
		math.min(#Tools, MAX_SLOTS) do

		SlotTools[i] =
			Tools[i]

		Slots[i].Text =
			Tools[i].Name

	end

	print(
		"Đã quét:",
		#Tools,
		"Tool"
	)

end

Scan.Activated:Connect(ScanTools)

--==================================================
-- EQUIP / UNEQUIP
--==================================================

for i = 1, MAX_SLOTS do

	Slots[i].Activated:Connect(
		function()

			local Tool =
				SlotTools[i]

			if not Tool
				or not Tool.Parent then
				return
			end

			local Character =
				Player.Character

			if not Character then
				return
			end

			local Humanoid =
				Character:FindFirstChildOfClass(
					"Humanoid"
				)

			if not Humanoid then
				return
			end

			if Tool.Parent == Character then

				Humanoid:UnequipTools()

				Slots[i].BackgroundColor3 =
					Color3.fromRGB(
						40,
						40,
						40
					)

			else

				Humanoid:EquipTool(Tool)

				Slots[i].BackgroundColor3 =
					Color3.fromRGB(
						70,
						70,
						70
					)

			end

		end
	)

end

--==================================================
-- DROP ITEM
--==================================================

DropButton.Activated:Connect(function()

	local Character =
		Player.Character

	if not Character then
		return
	end

	local Tool = nil

	for _, Object in
		ipairs(Character:GetChildren()) do

		if Object:IsA("Tool") then

			Tool = Object
			break

		end

	end

	if not Tool then

		print(
			"Không có Tool đang cầm để thả."
		)

		return
	end

	Tool.Parent = workspace

	local Handle =
		Tool:FindFirstChild("Handle")

	local Root =
		Character:FindFirstChild(
			"HumanoidRootPart"
		)

	if Handle and Root then

		Handle.CFrame =
			Root.CFrame
			* CFrame.new(
				0,
				0,
				-3
			)

	end

	print(
		"Đã thả:",
		Tool.Name
	)

end)

--==================================================
-- MỞ / ĐÓNG BALO
--==================================================

Bag.Activated:Connect(function()

	Inventory.Visible =
		not Inventory.Visible

end)

--==================================================
-- KHÓA / MỞ KHÓA
--==================================================

LockButton.Activated:Connect(function()

	Locked = not Locked

	if Locked then

		LockButton.Text = "🔒"

		LockButton.BackgroundColor3 =
			Color3.fromRGB(
				220,
				45,
				45
			)

	else

		LockButton.Text = "🔓"

		LockButton.BackgroundColor3 =
			Color3.fromRGB(
				45,
				180,
				80
			)

	end

end)

--==================================================
-- KÉO GUI
--==================================================

local Dragging = false
local DragStart

local BagStart
local LockStart
local InventoryStart

Bag.InputBegan:Connect(function(Input)

	if Locked then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.Touch
		or Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = true

		DragStart =
			Input.Position

		BagStart =
			Bag.Position

		LockStart =
			LockButton.Position

		InventoryStart =
			Inventory.Position

	end

end)

UserInputService.InputChanged:Connect(function(Input)

	if not Dragging or Locked then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.Touch
		or Input.UserInputType ==
		Enum.UserInputType.MouseMovement then

		local Delta =
			Input.Position
			- DragStart

		Bag.Position =
			UDim2.new(
				BagStart.X.Scale,
				BagStart.X.Offset + Delta.X,

				BagStart.Y.Scale,
				BagStart.Y.Offset + Delta.Y
			)

		LockButton.Position =
			UDim2.new(
				LockStart.X.Scale,
				LockStart.X.Offset + Delta.X,

				LockStart.Y.Scale,
				LockStart.Y.Offset + Delta.Y
			)

		Inventory.Position =
			UDim2.new(
				InventoryStart.X.Scale,
				InventoryStart.X.Offset + Delta.X,

				InventoryStart.Y.Scale,
				InventoryStart.Y.Offset + Delta.Y
			)

	end

end)

UserInputService.InputEnded:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.Touch
		or Input.UserInputType ==
		Enum.UserInputType.MouseButton1 then

		Dragging = false

	end

end)

print("Mobile Inventory 8 Slots Loaded!")
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Thông báo",
    Text = "load successful",
    Duration = 1
})

StarterGui:SetCore("SendNotification", {
    Title = "Thông báo",
    Text = "Made by: chatgpt___vng_cc676767 Enjoy!",
    Duration = 2
})
