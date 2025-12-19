local f = _G["SteakChatFrame"]

local ToastEvents = {
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
}

local tf = CreateFrame("ScrollingMessageFrame", "ToastChatFrame", UIParent)
tf:SetPoint("CENTER", UIParent, "CENTER", 0, 250)
tf:EnableMouse(false)
tf:SetWidth(500)
tf:SetHeight(300)

tf:EnableKeyboard(false)
tf:EnableMouseWheel(false)
tf:SetFading(true)
tf:SetTimeVisible(10)
tf:SetFadeDuration(3)

tf:SetFont("Fonts\\ARIALN.TTF", f.FontSize+2, "OUTLINE")
tf:SetTextColor(1, 1, 1, 1)
tf:SetJustifyH("LEFT")
tf:SetMaxLines(64)

for _,event in ipairs(ToastEvents) do
	tf:RegisterEvent(event)
end

tf:SetScript("OnEvent", function(self, event, ...)
	local text, playerName, languageName, channelName, _, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, suppressRaidIcons = ...

	local r, g, b, a = 1, 1, 0, 1

	if f.chatColors[event] ~= nil then
		r = f.chatColors[event].r
		g = f.chatColors[event].g
		b = f.chatColors[event].b
		a = f.chatColors[event].a
	end

	local term
	if type(text) == "string" then
		for tag in string.gmatch(text, "%b{}") do
			term = strlower(string.gsub(tag, "[{}]", ""))
			if ( ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]] ) then
				text = string.gsub(text, tag, ICON_LIST[ICON_TAG_LIST[term]] .. "0|t")
			end
		end
	end

	local chanData = "["..date("%H:%M:%S").."]"

	if channelBaseName ~= nil and channelIndex ~= 0 then
		chanData = chanData.."["..channelIndex.." - "..channelBaseName.."]"
		if channelBaseName:sub(1,3) == "Crb" then return end
	end

	if playerName ~= nil and type(playerName) == "string" and strlen(playerName) > 0 then
		local name, rank, _, level, class, note = f.GetGuildInfoByName(playerName)

		playerName = f.GetPlayerLink(playerName, lineID) or playerName
		chanData = chanData.."["..playerName.."]"

		if name ~= false then
			chanData = ("%s[%s:%s]"):format(chanData, rank, level)
		elseif level ~= nil then
			chanData = ("%s[%s]"):format(chanData, level)
		end

		if note ~= "" and note ~= nil and note ~= false then
			chanData = chanData.."(|cffffffff"..note.."|r)"
		end

		if specialFlags ~= nil and strlen(specialFlags) > 0 then
			if specialFlags == "GM" then
				chanData = chanData.."|TInterface\\ChatFrame\\UI-ChatIcon-Blizz.blp:0:2:0:-3|t "
			else
				if getglobal("CHAT_FLAG_"..specialFlags) ~= nil then
					chanData = chanData..getglobal("CHAT_FLAG_"..specialFlags).." "
				end
			end
		end
	end

	if event == "UPDATE_CHAT_WINDOWS" or event == "VARIABLES_LOADED" or event == "PLAYER_ENTERING_WORLD" then
		for k,v in pairs(ChatTypeInfo) do
			ChatTypeInfo[k].colorNameByClass = true
		end
	elseif event == "CHAT_MSG_WHISPER" then
		if self:IsVisible() == nil then
			_G[self:GetName().."Tab"].alerting = 1
		end

		self:AddMessage(("%s: %s"):format(chanData, (text or "")), r, g, b, a)	
	elseif event == "CHAT_MSG_WHISPER_INFORM" then
		if self:IsVisible() == nil then
			_G[self:GetName().."Tab"].alerting = 1
		end

		self:AddMessage(("To %s: %s"):format(chanData, (text or "")), r, g, b, a)	
	elseif event == "CHAT_MSG_CHANNEL" then
		if self:IsVisible() == nil then
			_G[self:GetName().."Tab"].alerting = 1
		end

		self:AddMessage(("%s: %s"):format(chanData, (text or "")), r, g, b, a)			

		--Send who if user is not already in the player list
		if SteakChatPlayerData[playerName] == nil then
			SendWho(playerName)
		end
	else
		if self:IsVisible() == nil then
			_G[self:GetName().."Tab"].alerting = 1
		end

		--[[
		if specialFlags ~= nil then
			msg = msg.."("..specialFlags..")"
		end
		]]

		self:AddMessage(("%s: %s"):format(chanData, (text or "")), r, g, b, a)	
	end
end)

tf:RegisterEvent("PLAYER_ENTERING_WORLD")
tf:RegisterEvent("UPDATE_CHAT_WINDOWS")
tf:RegisterEvent("VARIABLES_LOADED")
--tf:RegisterEvent("CHAT_MSG_WHISPER")
--tf:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
--tf:RegisterEvent("PLAYER_LOGIN")
--tf:RegisterEvent("ADDON_LOADED")
