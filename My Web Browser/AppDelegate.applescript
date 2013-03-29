--
--  AppDelegate.applescript
--  My Web Browser
--
--  Created by tom on 2013/03/27.
--  Copyright (c) 2013年 mii. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    
    property appWindowController : missing value
    property webView : missing value
	
    on applicationShouldHandleReopen_hasVisibleWindows_(sender, visible)
        if visible is false then
            tell appWindowController to showWindow_(me)
        end if
        return yes
    end applicationShouldHandleReopen_hasVisibleWindows_
    
	on applicationWillFinishLaunching_(aNotification)
        tell webView to setMainFrameURL_("http://www.apple.com/")
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script