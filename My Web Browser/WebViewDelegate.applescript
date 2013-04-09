script WebViewDelegate
	property parent : class "NSObject"
    
    property locationBar : missing value
    
    -- === FrameLoadDelegate =========================
    
    on webView_didStartProvisionalLoadForFrame_(sender, frame)
        set theURL to mainDocumentURL() of request of provisionalDataSource of frame
        tell locationBar to setStringValue_(absoluteString() of theURL)
	end
    
    on webView_didReceiveTitle_forFrame_(sender, title, frame)
		if mainFrame of sender is frame then
			tell |window| of sender to setTitle_(title)
		end if
	end
    
    -- === UIDelegate ================================
    
    on webView_runJavaScriptAlertPanelWithMessage_initiatedByFrame_(sender, message, frame)
        tell current application to display dialog (message as text) buttons {"OK"} with icon 1
    end
    
    on webView_runJavaScriptConfirmPanelWithMessage_initiatedByFrame_(sender, message, frame)
        set userCanceled to false
        try
            tell current application to display dialog (message as text) with icon 1
        on error number -128
            set userCanceled to true
        end try
        if userCanceled then
            return false
        end if
        return true
    end
    
    on webView_runJavaScriptTextInputPanelWithPrompt_defaultText_initiatedByFrame_(sender, prompt, defaultText, frame)
        set userCanceled to false
        try
            tell current application to display dialog (prompt as text) default answer (defaultText as text) with icon 1
            set textReturned to text returned of result
        on error number -128
            set userCanceled to true
        end try
        if userCanceled then
            return
        end if
        return textReturned
    end
    
    on webView_runOpenPanelForFileButtonWithResultListener_allowMultipleFiles_(sender, resultListener, allowMultipleFiles)
        if allowMultipleFiles then
            set fileList to {}
            tell current application to choose file with multiple selections allowed
            repeat with aFile in result
                tell current application to POSIX path of aFile
                set the end of fileList to result
            end repeat
            tell resultListener to chooseFilenames_(fileList)
        else
            tell current application to choose file
            tell current application to POSIX path of result
            tell resultListener to chooseFilename_(result)
        end if
    end
    
end script