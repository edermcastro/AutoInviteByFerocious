-- 1. Inicialização de Variáveis
if not AIM_Config then AIM_Config = { keyword = "inv", enabled = true } end
if not AIM_DBIcon then AIM_DBIcon = {} end


-- 2. Criação da Janela de Configuração (UI Customizada)
local gui = CreateFrame("Frame", "AIM_SettingsFrame", UIParent, "BackdropTemplate")
gui:SetSize(320, 180) -- Aumentei um pouco a altura para caber os créditos
gui:SetPoint("CENTER")
gui:SetMovable(true)
gui:EnableMouse(true)
gui:RegisterForDrag("LeftButton")
gui:SetScript("OnDragStart", gui.StartMoving)
gui:SetScript("OnDragStop", gui.StopMovingOrSizing)
gui:SetBackdrop({
    bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
gui:SetBackdropColor(0, 0, 0, 0.95)
gui:Hide()

-- Título Principal
gui.title = gui:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
gui.title:SetPoint("TOP", 0, -15)
gui.title:SetText("AutoInvite Midnight")

-- Campo de Texto (EditBox)
local editLabel = gui:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
editLabel:SetPoint("CENTER", 0, 25)
editLabel:SetText("Digite a palavra-chave abaixo:")

local editBox = CreateFrame("EditBox", nil, gui, "InputBoxTemplate")
editBox:SetSize(160, 20)
editBox:SetPoint("CENTER", 0, 5)
editBox:SetAutoFocus(false)
editBox:SetText(AIM_Config.keyword)

-- Botão Salvar
local saveBtn = CreateFrame("Button", nil, gui, "GameMenuButtonTemplate")
saveBtn:SetSize(90, 22)
saveBtn:SetPoint("CENTER", 0, -25)
saveBtn:SetText("Salvar")
saveBtn:SetScript("OnClick", function()
    AIM_Config.keyword = editBox:GetText()
    print("|cFF00FF00[AutoInvite]|r Palavra-chave salva: |cFFFFFF00" .. AIM_Config.keyword)
    gui:Hide()
end)

-- --- SEÇÃO DE DIREITOS AUTORAIS / CRÉDITOS ---
local line = gui:CreateTexture(nil, "ARTWORK")
line:SetSize(280, 1)
line:SetPoint("BOTTOM", 0, 45)
line:SetColorTexture(1, 1, 1, 0.2) -- Linha divisória sutil

gui.copyright = gui:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
gui.copyright:SetPoint("BOTTOM", 0, 25)
gui.copyright:SetText("© 2026 Todos os Direitos Reservados")

gui.author = gui:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
gui.author:SetPoint("BOTTOM", 0, 10)
gui.author:SetText("Desenvolvido por: |cFFFFD100Eder Moraes - Ferocioüs|r")
-- --------------------------------------------

-- Botão Fechar (X)
local closeBtn = CreateFrame("Button", nil, gui, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", gui, "TOPRIGHT")

-- -- 2. Criação da Janela de Configuração (UI Customizada)
-- local gui = CreateFrame("Frame", "AIM_SettingsFrame", UIParent, "BackdropTemplate")
-- gui:SetSize(300, 120)
-- gui:SetPoint("CENTER")
-- gui:SetMovable(true)
-- gui:EnableMouse(true)
-- gui:RegisterForDrag("LeftButton")
-- gui:SetScript("OnDragStart", gui.StartMoving)
-- gui:SetScript("OnDragStop", gui.StopMovingOrSizing)
-- gui:SetBackdrop({
--     bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
--     edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
--     tile = true, tileSize = 16, edgeSize = 16,
--     insets = { left = 4, right = 4, top = 4, bottom = 4 }
-- })
-- gui:SetBackdropColor(0, 0, 0, 0.9)
-- gui:Hide() -- Começa escondida

-- -- Título
-- gui.title = gui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
-- gui.title:SetPoint("TOP", 0, -10)
-- gui.title:SetText("AutoInvite Midnight - Palavra chave?")

-- -- Campo de Texto (EditBox)
-- local editBox = CreateFrame("EditBox", nil, gui, "InputBoxTemplate")
-- editBox:SetSize(180, 20)
-- editBox:SetPoint("CENTER", 0, 0)
-- editBox:SetAutoFocus(false)
-- editBox:SetText(AIM_Config.keyword)

-- -- Botão Salvar
-- local saveBtn = CreateFrame("Button", nil, gui, "GameMenuButtonTemplate")
-- saveBtn:SetSize(80, 25)
-- saveBtn:SetPoint("BOTTOM", 0, 10)
-- saveBtn:SetText("Salvar")
-- saveBtn:SetScript("OnClick", function()
--     AIM_Config.keyword = editBox:GetText()
--     print("|cFF00FF00[AutoInvite]|r Palavra-chave salva: |cFFFFFF00" .. AIM_Config.keyword)
--     gui:Hide()
-- end)

-- -- Botão Fechar (X)
-- local closeBtn = CreateFrame("Button", nil, gui, "UIPanelCloseButton")
-- closeBtn:SetPoint("TOPRIGHT", gui, "TOPRIGHT")

-- 3. LDB e Ícone do Minimapa
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("AutoInviteMidnight", {
    type = "launcher",
    text = "AutoInvite",
    icon = "Interface\\Icons\\INV_Misc_GroupNeedMore",
    OnClick = function(self, button)
        if button == "LeftButton" then
            if gui:IsShown() then gui:Hide() else gui:Show() end
        elseif button == "RightButton" then
            AIM_Config.enabled = not AIM_Config.enabled
            local status = AIM_Config.enabled and "|cFF00FF00Ligado|r" or "|cFFFF0000Desligado|r"
            print("|cFF00FF00[AutoInvite]|r Status: " .. status)
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine("|cFF00FF00AutoInvite Midnight|r")
        tooltip:AddLine("|cFFFFFF00Click Esquerdo:|r Mudar Palavra")
        tooltip:AddLine("|cFFFFFF00Click Direito:|r Ligar/Desligar")
        tooltip:AddLine("Status: " .. (AIM_Config.enabled and "Ligado" or "Desligado"))
        tooltip:AddLine("Palavra: " .. AIM_Config.keyword)
    end,
})

local icon = LibStub("LibDBIcon-1.0")

-- 4. Eventos
-- 1. Registro de Eventos Adicionais
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:RegisterEvent("CHAT_MSG_BN_WHISPER") -- Evento da Battle.net

-- Função Auxiliar de Convite
local function TryInvite(msg, senderName, isBN, bnetAccountID)
    if not AIM_Config.enabled then return end
    
    -- Verifica se o grupo já está cheio (5 para party, 40 para raid)
    if IsInGroup() and not IsInRaid() and GetNumGroupMembers() >= 5 then
        print("|cFFFF0000[AutoInvite]|r Grupo cheio!")
    end
    
    if msg:lower():find(AIM_Config.keyword:lower()) then
        if isBN and bnetAccountID then
            -- No Midnight, usamos GetAccountInfoByID
            local accountInfo = C_BattleNet.GetAccountInfoByID(bnetAccountID)
            
            if accountInfo and accountInfo.gameAccountInfo then
                local gameInfo = accountInfo.gameAccountInfo
                local charName = gameInfo.characterName
                local realmName = gameInfo.realmName
                
                -- Verifica se o amigo está no WoW (Client "WoW")
                if charName and charName ~= "" and gameInfo.clientProgram == "WoW" then
                    -- Limpa o nome do reino (remove espaços para evitar erro no convite)
                    if realmName then
                        realmName = realmName:gsub("%s+", "")
                    end
                    
                    local fullTarget = charName .. "-" .. (realmName or GetRealmName())
                    C_PartyInfo.InviteUnit(fullTarget)
                    print("|cFF00FF00[AutoInvite]|r BNet Invite enviado para: |cff00ccff" .. fullTarget .. "|r")
                    
                    -- Adiciona um som de confirmação (Opcional)
                    PlaySound(888, "Master") 
                end
            end
        elseif not isBN and senderName then
            -- Lógica para Sussurro Normal
            C_PartyInfo.InviteUnit(senderName)
            print("|cFF00FF00[AutoInvite]|r Convidando: " .. senderName)
            PlaySound(888, "Master")
        end
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and ... == "AutoInviteMidnight" then
        -- (A Lógica de inicialização da GUI e Ícone continua aqui...)
        if not AIM_Config then AIM_Config = { keyword = "inv", enabled = true } end
        if not AIM_DBIcon then AIM_DBIcon = {} end
        icon:Register("AutoInviteMidnight", LDB, AIM_DBIcon)
        editBox:SetText(AIM_Config.keyword)

    elseif event == "CHAT_MSG_WHISPER" then
        local msg, sender = ...
        TryInvite(msg, sender, false)

    elseif event == "CHAT_MSG_BN_WHISPER" then
        local msg, _, _, _, _, _, _, _, _, _, _, _, presenceID = ...
        TryInvite(msg, nil, true, presenceID)
    end
end)
