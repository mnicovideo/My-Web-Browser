script PreferencesWindow
    property parent : class "NSWindow"
    
    property generalView : missing value
    property advancedView : missing value
    
    on cancelOperation_(sender)
        tell me to |close|()
    end cancelOperation_
    
    on switchView_(sender)
        --クリックされたアイコンを判断し表示するカスタムビューを決める
        set tagNumber to tag of sender as real
        if tagNumber is 10 then
            set targetView to generalView
        else if tagNumber is 20 then
            set targetView to advancedView
        end if
        --設定ウィンドウのメインビューから不要なビューを取り除く
        set contentView to contentView() of me
        repeat with aView in subviews of contentView
            tell aView to removeFromSuperview()
        end repeat
        --設定ウィンドウのサイズを取得
        set windowFrame to frame() of me
        --設定ウィンドウのサイズをカスタムビューのサイズに合わせて調整
        set newWindowFrame to frameRectForContentRect_(frame() of targetView) of me
        --設定ウィンドウの位置を調整
        set frameHeight to height of |size| of windowFrame - height of |size| of newWindowFrame
        set x of origin of newWindowFrame to x of origin of windowFrame
        set y of origin of newWindowFrame to y of origin of windowFrame + frameHeight
        --設定ウィンドウの位置とサイズをアニメーション動作付きで設定
        tell me to setFrame_display_animate_(newWindowFrame,1,1)
        --設定ウィンドウのメインビューにカスタムビューを追加
        tell contentView to addSubview_(targetView)
    end switchView_
    
end script

script PreferencesWindowController
    property parent : class "NSWindowController"
    
    property toolbar : missing value
    property defaultSelectedToolbarItem : missing value
    
    on showWindow_(sender)
        continue showWindow_(sender)
        if selectedItemIdentifier() of toolbar is missing value then
            tell toolbar to setSelectedItemIdentifier_(itemIdentifier() of defaultSelectedToolbarItem)
            tell |window|() of me to |center|()
            tell |window|() of me to switchView_(defaultSelectedToolbarItem)
        end if
    end showWindow_
    
end script










