FuBar_ElysiumPopulationFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
FuBar_ElysiumPopulationFu.hasIcon = true
FuBar_ElysiumPopulationFu.hasNoColor = true
FuBar_ElysiumPopulationFu.clickableTooltip = true
FuBar_ElysiumPopulationFu.folderName = "FuBar_ElysiumPopulationFu"

local waitForWho = 0

function ElysiumPopulationFu_ChatFrame_OnEvent(event)
  -- Ensure that we don't accidently omit other chat messages
  if waitForWho == 1 and event == "CHAT_MSG_SYSTEM" and arg1 == "0 players total" and arg2 == "" then
    waitForWho = 0
     else
       OrigChatFrame_OnEvent(event);
  end
end

function FuBar_ElysiumPopulationFu:OnInitialize()
  OrigChatFrame_OnEvent = ChatFrame_OnEvent;
  ChatFrame_OnEvent = ElysiumPopulationFu_ChatFrame_OnEvent;

  self:SetText("Updating...")
end

function FuBar_ElysiumPopulationFu:OnEnable()
  self:RegisterEvent("CHAT_MSG_SYSTEM")

  self:ScheduleRepeatingEvent("ScheduledWhoTimer", SendWhoQuery, 60)
  SendWhoQuery()
end

function SendWhoQuery()
  SetWhoToUI(0)
  waitForWho = 1
  SendWho("$-`")
end

function FuBar_ElysiumPopulationFu:CHAT_MSG_SYSTEM()
  numResults, totalCount = GetNumWhoResults()
  self:SetText(totalCount)
end

function FuBar_ElysiumPopulationFu:OnDisable()
end

function FuBar_ElysiumPopulationFu:OnClick()
  self:SetText("Updating...")
  SendWhoQuery()
end
