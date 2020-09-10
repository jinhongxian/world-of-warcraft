local macroBtn = CreateFrame("Button", "myMacroButton", UIParent, "SecureActionButtonTemplate")
macroBtn:SetAttribute("type1", "macro") -- left click causes macro
macroBtn:SetAttribute("macrotext1", "/raid zomg a left click!") -- text for macro on left click

/run  local macroBtn = CreateFrame("Button", "myMacroButton", UIParent, "SecureActionButtonTemplate") macroBtn:SetAttribute("type1", "macro") macroBtn:SetAttribute("macrotext1", "/party zomg a left click!")

/run local mb = CreateFrame("Button", "mb", UIParent, "SecureActionButtonTemplate") btn:SetAttribute("type", "spell") btn:SetAttribute("spell", "奥术射击") btn:SetAttribute("target", "target")



function()
    local btn = CreateFrame("Button", "killcreature", UIParent, "SecureActionButtonTemplate")
    btn:SetAttribute("type", "spell") 
    btn:SetAttribute("spell", "奥术射击") 
    btn:SetAttribute("target", "target")
end



/run print(mb:GetAttribute("target"))

/run mb:SetAttribute("spell", "奥术射击")
/run mb:SetAttribute("target", "训练假人")