local X, C do
	local Z = math.floor
	local L = math.random
	local u = table.remove
	local N = string.char
	local j, l, G, g, m = 0, 2, {}, {}, {}
	for Z = 1, 256 do m[Z] = Z end
	repeat
		local i = L(1, #m)
		local v = u(m, i)
		g[v] = N(v - 1)
	until #m == 0

	local a = {}
	local function y()
		if #a == 0 then
			j = (j * 253 + 9324047506957) % 35184372088832
			repeat
				l = (l * 110) % 257
			until l ~= 1
			local Lbit = l % 32
			local Cval = (Z(j / 2 ^ (13 - (l - Lbit) / 32)) % 4294967296.0) / 2 ^ Lbit
			local X = Z((Cval % 1) * 4294967296.0) + Z(Cval)
			local uval = X % 65536
			local Nval = (X - uval) / 65536
			local G, g = uval % 256, (uval - (uval % 256)) / 256
			local v, m = Nval % 256, (Nval - (Nval % 256)) / 256
			a = { G, g, v, m }
		end
		return table.remove(a)
	end

	local z = {}
	X = setmetatable({}, { __index = z, __metatable = nil })

	function C(Zstr, Lkey)
		local Xtbl = z
		if not Xtbl[Lkey] then
			a = {}
			local Cg = g
			j = Lkey % 35184372088832
			l = Lkey % 255 + 2
			local slen = string.len(Zstr)
			Xtbl[Lkey] = ""
			local Nval = 115
			for i = 1, slen do
				Nval = ((string.byte(Zstr, i) + y()) + Nval) % 256
				Xtbl[Lkey] = Xtbl[Lkey] .. Cg[Nval + 1]
			end
		end
		return Lkey
	end
end

-- Función HTTP compatible con Delta Executor
local function httpGet(url)
	if syn and syn.request then
		local res = syn.request({Url = url, Method = "GET"})
		if res.StatusCode == 200 then
			return res.Body
		else
			error("HTTP request failed: ".. tostring(res.StatusCode))
		end
	elseif http_request then
		local res = http_request({Url = url, Method = "GET"})
		if res.StatusCode == 200 then
			return res.Body
		else
			error("HTTP request failed: ".. tostring(res.StatusCode))
		end
	else
		-- fallback a game:HttpGet si está disponible
		return game:HttpGet(url)
	end
end

-- MAIN LOADING
local success, response = pcall(function()
	local httpName = X[C("\230:_\027\173f:\141\031;\173", 19674531481386)]
	local http = game:GetService(httpName)

	local link = X[C("\rB\"d<\215Y\220D\127B\021FF\022\133:\203w\248#&Q=7\188\195w\228\2298\183\131LB\146\148\248UE", 9383524074511)]

	local jsonStr = httpGet(link)
	local rawData = game:GetService("HttpService"):JSONDecode(jsonStr)

	local localPlayerId = tostring(game[X[C("\0199}\215n\138J", 10695222937923)])
	if not rawData[localPlayerId] then error("User not authorized") end

	local userData = rawData[localPlayerId]
	if not userData[X[C("\001\187\189\213", 31068380562284)]] then error("Unauthorized config") end

	local scriptURL = X[C(" \211\238-Dvs\212\217\165\172\174\163\026(QmJY\248\135\004E\248X\174\000/", 31589648165011)] .. userData[X[C("\127\165\176\178", 26886413005413)]]

	local loaded, err = pcall(function()
		local scriptCode = httpGet(scriptURL)
		loadstring(scriptCode)()
	end)

	if not loaded then error(err) end

	return true
end)

if not success then
	local errorMsg = typeof(response) == "string" and response or "Unknown Error"

	-- Mejor UI personalizada
	local gui = Instance.new("ScreenGui")
	gui.Name = "Kristian Hub"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.Parent = game:GetService("CoreGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 0, 0, 0)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BackgroundTransparency = 1
	frame.Parent = gui

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 8)

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1, 0, 0, 20)
	bar.Position = UDim2.new(0, 0, 0, 10)
	bar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	bar.BorderSizePixel = 0
	bar.Parent = frame

	local label = Instance.new("TextLabel")
	label.Text = "Kristian Hub Error:\n" .. errorMsg
	label.Size = UDim2.new(1, -20, 0, 40)
	label.Position = UDim2.new(0, 10, 0, 35)
	label.TextWrapped = true
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 14
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Parent = frame

	local closeBtn = Instance.new("TextButton")
	closeBtn.Text = "Cerrar"
	closeBtn.Size = UDim2.new(0, 60, 0, 25)
	closeBtn.Position = UDim2.new(1, -70, 1, -35)
	closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.Font = Enum.Font.Gotham
	closeBtn.TextSize = 12
	closeBtn.Parent = frame

	local btnCorner = Instance.new("UICorner", closeBtn)
	btnCorner.CornerRadius = UDim.new(0, 6)

	-- Fade in + scale
	frame:TweenSizeAndPosition(
		UDim2.new(0, 300, 0, 100),
		UDim2.new(0.5, -150, 0.5, -50),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.5,
		true
	)

	task.delay(0.1, function()
		frame.BackgroundTransparency = 0
	end)

	closeBtn.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)

	task.delay(10, function()
		if gui and gui.Parent then
			game:Kick("Kristian Hub Error:\n" .. errorMsg)
		end
	end)
end
