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
    
end script