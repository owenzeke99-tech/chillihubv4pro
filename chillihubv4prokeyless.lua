-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local guiName = "ChilliHubKeySystemV8"

-- // Xóa UI cũ nếu có
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end

-- // Cấu hình Key & Link
local CORRECT_KEY = "ChilliHubV4ProJakwhwhKalalwjjwwllLLwowjwoowbwpb"
local KEY_LINK = "https://raw.githubusercontent.com/napun87/stealanegg/refs/heads/main/ChilliHubPro.lua"
local GET_KEY_URL = "https://link4m.org/4T7nU"

-- // Hệ thống lưu Key ẩn 24 giờ (Local Saving with 24h Expiration)
local saveFileName = "ChilliHubV8_KeyData.json"
local EXPIRATION_TIME = 24 * 60 * 60 -- 24 giờ tính bằng giây

local function saveKeyData()
    if writefile and pcall then
        local data = {
            Key = CORRECT_KEY,
            Timestamp = os.time()
        }
        local HttpService = game:GetService("HttpService")
        pcall(function()
            writefile(saveFileName, HttpService:JSONEncode(data))
        end)
    end
end

local function loadSavedKey()
    if readfile and isfile and isfile(saveFileName) then
        local success, rawData = pcall(readfile, saveFileName)
        if success and rawData then
            local HttpService = game:GetService("HttpService")
            local decodeSuccess, data = pcall(function()
                return HttpService:JSONDecode(rawData)
            end)
            
            if decodeSuccess and data and data.Key == CORRECT_KEY and data.Timestamp then
                local currentTime = os.time()
                if (currentTime - data.Timestamp) < EXPIRATION_TIME then
                    return true
                end
            end
        end
    end
    return false
end

-- // Bỏ qua menu nếu đã lưu key hợp lệ trong vòng 24 giờ
if loadSavedKey() then
    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(KEY_LINK))()
        end)
        if not success then
            warn("Error loading main script: " .. tostring(err))
        end
    end)
    return
end

-- // Tạo giao diện chính (Red & Black Theme Clean)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -135)
MainFrame.Size = UDim2.new(0, 400, 0, 270)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Viền đỏ rực rỡ
local OuterStroke = Instance.new("UIStroke")
OuterStroke.Parent = MainFrame
OuterStroke.Color = Color3.fromRGB(255, 30, 30)
OuterStroke.Thickness = 1.8

-- // Hiệu ứng bóng mờ (Drop Shadow)
local GlowFrame = Instance.new("Frame")
GlowFrame.Name = "Glow"
GlowFrame.Parent = MainFrame
GlowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
GlowFrame.BackgroundTransparency = 0.85
GlowFrame.BorderSizePixel = 0
GlowFrame.Position = UDim2.new(0, -6, 0, -6)
GlowFrame.Size = UDim2.new(1, 12, 1, 12)
GlowFrame.ZIndex = MainFrame.ZIndex - 1

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 20)
GlowCorner.Parent = GlowFrame

-- // Tiêu đề Chilli Hub V4 Pro
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 16)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Font = Enum.Font.FredokaOne
Title.Text = "CHILLI HUB V4 PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Parent = Title
TitleStroke.Color = Color3.fromRGB(220, 0, 0)
TitleStroke.Thickness = 1.5

-- // Dòng chữ tiếng Anh phụ bên dưới tiêu đề
local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 48)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "Please enter your key below"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.TextSize = 12

-- // Khung thông báo tích hợp trực tiếp trên menu
local NotificationBox = Instance.new("Frame")
NotificationBox.Name = "NotificationBox"
NotificationBox.Parent = MainFrame
NotificationBox.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
NotificationBox.BackgroundTransparency = 1
NotificationBox.Position = UDim2.new(0.08, 0, 0, 75)
NotificationBox.Size = UDim2.new(0.84, 0, 0, 30)

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = NotificationBox

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Parent = NotificationBox
NotifStroke.Color = Color3.fromRGB(255, 50, 50)
NotifStroke.Transparency = 1

local NotifText = Instance.new("TextLabel")
NotifText.Parent = NotificationBox
NotifText.BackgroundTransparency = 1
NotifText.Size = UDim2.new(1, 0, 1, 0)
NotifText.Font = Enum.Font.GothamBold
NotifText.Text = ""
NotifText.TextColor3 = Color3.fromRGB(255, 80, 80)
NotifText.TextSize = 13
NotifText.TextTransparency = 1

-- // Ô nhập Key (TextBox Background)
local TextBoxBg = Instance.new("Frame")
TextBoxBg.Parent = MainFrame
TextBoxBg.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TextBoxBg.Position = UDim2.new(0.08, 0, 0, 115)
TextBoxBg.Size = UDim2.new(0.84, 0, 0, 50)

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = TextBoxBg

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Parent = TextBoxBg
BoxStroke.Color = Color3.fromRGB(60, 60, 60)
BoxStroke.Thickness = 1.2

local TextBox = Instance.new("TextBox")
TextBox.Parent = TextBoxBg
TextBox.BackgroundTransparency = 1
TextBox.Size = UDim2.new(1, 0, 1, 0)
TextBox.Font = Enum.Font.GothamMedium
TextBox.PlaceholderText = "Enter your key here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox.TextSize = 14

TextBox.Focused:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 50, 50)}):Play()
end)
TextBox.FocusLost:Connect(function()
    TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 60)}):Play()
end)

-- // Nút Xác Nhận (Check Key)
local CheckBtn = Instance.new("TextButton")
CheckBtn.Parent = MainFrame
CheckBtn.BackgroundColor3 = Color3.fromRGB(220, 25, 25)
CheckBtn.Position = UDim2.new(0.08, 0, 0, 185)
CheckBtn.Size = UDim2.new(0.41, 0, 0, 50)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "CHECK KEY"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 15

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 10)
CheckCorner.Parent = CheckBtn

local CheckGradient = Instance.new("UIGradient")
CheckGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 10, 10))
}
CheckGradient.Rotation = 90
CheckGradient.Parent = CheckBtn

-- // Nút Lấy Key (Get Key)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
GetKeyBtn.Position = UDim2.new(0.51, 0, 0, 185)
GetKeyBtn.Size = UDim2.new(0.41, 0, 0, 50)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
GetKeyBtn.TextSize = 15

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 10)
GetCorner.Parent = GetKeyBtn

local GetStroke = Instance.new("UIStroke")
GetStroke.Parent = GetKeyBtn
GetStroke.Color = Color3.fromRGB(200, 30, 30)
GetStroke.Thickness = 1.2

-- // Hàm hiển thị thông báo
local function showNotification(message, isSuccess)
    NotifText.Text = message
    if isSuccess then
        NotifText.TextColor3 = Color3.fromRGB(80, 255, 130)
        NotifStroke.Color = Color3.fromRGB(40, 200, 80)
        NotificationBox.BackgroundColor3 = Color3.fromRGB(15, 25, 18)
    else
        NotifText.TextColor3 = Color3.fromRGB(255, 80, 80)
        NotifStroke.Color = Color3.fromRGB(255, 50, 50)
        NotificationBox.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
    end
    
    TweenService:Create(NotificationBox, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(NotifStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    TweenService:Create(NotifText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
end

-- // Hiệu ứng lắc mượt mà kết hợp xóa chữ ngay lập tức
local function shakeWindowAndClear()
    local originalPos = UDim2.new(0.5, -200, 0.5, -135)
    local intensity = 10
    local tweenInfo = TweenInfo.new(0.04, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    -- Xóa chữ ngay lập tức cùng lúc bắt đầu lắc
    TextBox.Text = ""
    
    -- Chuỗi hiệu ứng lắc
    TweenService:Create(MainFrame, tweenInfo, {Position = originalPos + UDim2.new(0, intensity, 0, 0)}):Play()
    task.wait(0.04)
    TweenService:Create(MainFrame, tweenInfo, {Position = originalPos + UDim2.new(0, -intensity, 0, 0)}):Play()
    task.wait(0.04)
    TweenService:Create(MainFrame, tweenInfo, {Position = originalPos + UDim2.new(0, intensity - 3, 0, 0)}):Play()
    task.wait(0.04)
    TweenService:Create(MainFrame, tweenInfo, {Position = originalPos + UDim2.new(0, -(intensity - 3), 0, 0)}):Play()
    task.wait(0.04)
    TweenService:Create(MainFrame, tweenInfo, {Position = originalPos}):Play()
end

-- // Xử lý sự kiện bấm Check Key
CheckBtn.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if enteredKey == CORRECT_KEY then
        showNotification("Success! Loading Script...", true)
        saveKeyData()
        task.wait(0.8)
        ScreenGui:Destroy()
        
        -- Chạy script chính của bạn
        local success, err = pcall(function()
            loadstring(game:HttpGet(KEY_LINK))()
        end)
        if not success then
            warn("Error loading main script: " .. tostring(err))
        end
    else
        showNotification("Incorrect Key! Please try again.", false)
        -- Gọi đồng thời hiệu ứng lắc và tự động xóa sạch ô nhập chữ
        shakeWindowAndClear()
    end
end)

-- // Xử lý sự kiện bấm Get Key
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GET_KEY_URL)
        showNotification("Key link copied to clipboard!", true)
    else
        showNotification("Your executor doesn't support clipboard!", false)
    end
end)
