
script PreferencesWindow
    
    property parent : class "NSWindow"
    
    on cancelOperation_(sender)
        tell me to |close|()
    end
    
    on switchView_(sender)
        set tagNumber to tag of sender as real
        if tagNumber is 10 then
            log "General clicked."
        else if tagNumber is 20 then
            log "Advanced clicked."
        end if
    end switchView_
    
end script
