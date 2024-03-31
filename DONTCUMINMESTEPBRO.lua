-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'XXX | buyer version',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local RightGroupBox = Tabs.Main:AddRightGroupbox('-')


-- We can also get our Main tab via the following code:
-- local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[

local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options
--[[
    NOTE: You can chain the button methods!
    EXAMPLE:

    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap


-- Groupbox:AddDivider
-- Arguments: None

--[[
    Groupbox:AddSlider
    Arguments: Idx, SliderOptions

    SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }

    Text, Default, Min, Max, Rounding must be specified.
    Suffix is optional.
    Rounding is the number of decimal places for precision.

    Compact will hide the title label of the Slider

    HideMax will only display the value instead of the value & max value of the slider
    Compact will do the same thing
]]

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

RightGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info

RightGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Test', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    
})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)

task.spawn(function()
    while true do
        wait(1)

        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker is being held down')
        end

        if Library.Unloaded then break end
    end
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

-- Long text label to demonstrate UI scrolling behaviour.

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))

local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local Tab1 = TabBox:AddTab('target')
Tab1:AddToggle('Tab1Toggle', { Text = 'Enable' });
Tab1:AddLabel('Keybind'):AddKeyPicker('Tab1KeyPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'q', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Target Aim ', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)

task.spawn(function()
    while true do
        wait(1)

        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker is being held down')
        end

        if Library.Unloaded then break end
    end
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

Tab1:AddInput('Tab1MyTextbox', {
    Default = '0.1325235',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'Prediction',
    Tooltip = '.', -- Information shown when you hover over the textbox

    Placeholder = 'prediction....', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text


})
Tab1:AddDropdown('Tab1MyDropdown', {
    Values = {'Head','UpperTorso','Cloestpart' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Hitparts',
    Tooltip = 'cuh?', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})

Tab1:AddSlider('Tab1MySlider', {
    Text = 'hitchance',
    Default = 0,
    Min = 0,
    Max = 300,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab1:AddToggle('Tab1Toggle', { Text = 'Tracer' });
Tab1:AddToggle('Tab1Toggle', { Text = 'Dot' });
Tab1:AddToggle('Tab1Toggle', { Text = 'Highlight' });
Tab1:AddToggle('Tab1Toggle', { Text = '(CAMLOCK) not legit' });
Tab1:AddToggle('Tab1Toggle', { Text = 'Notifications' });
Tab1:AddToggle('Tab1Toggle', { Text = 'View' });
Tab1:AddToggle('Tab1Toggle', { Text = 'Player infomation' });
local Tab2 = TabBox:AddTab('resolver')
Tab2:AddToggle('Tab2Toggle', { Text = 'Enable' });
Tab2:AddToggle('Tab2Toggle', { Text = 'Resolver v1' });
Tab2:AddSlider('Tab2MySlider', {
    Text = 'Delay',
    Default = 0,
    Min = 0,
    Max = 30,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab2:AddToggle('Tab2Toggle', { Text = 'Resolver v2' });
Tab2:AddSlider('Tab2MySlider', {
    Text = 'Delay',
    Default = 0,
    Min = -20,
    Max = 70,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab2:AddToggle('Tab2Toggle', { Text = 'underground' });
Tab2:AddToggle('Tab2Toggle', { Text = 'fake lag' });
Tab2:AddToggle('Tab2Toggle', { Text = 'sky AA' });
local Tab3 = TabBox:AddTab('OnShot')
Tab3:AddToggle('Tab3Toggle', { Text = 'Enable' });
Tab3:AddDropdown('Tab3MyDropdown', {
    Values = {'Normal','Neon','Plastic' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'OnHit',
    Tooltip = 'cuh?', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})
Tab3:AddLabel('Color'):AddColorPicker('Tab3ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'BaseColor', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})
local Tab4 = TabBox:AddTab('Orbit')
Tab4:AddToggle('Tab4Toggle', { Text = 'Enable' });
Tab4:AddSlider('Tab4MySlider', {
    Text = 'height',
    Default = 0,
    Min = 0,
    Max = 30,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab4:AddSlider('Tab4MySlider', {
    Text = 'distance',
    Default = 0,
    Min = 0,
    Max = 60,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab4:AddSlider('Tab4MySlider', {
    Text = 'Speed',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
Tab4:AddToggle('Tab4Toggle', { Text = 'Jitter' });
Tab4:AddSlider('Tab4MySlider', {
    Text = 'Jitter',
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Anti lock')
LeftGroupBox:AddToggle('Toggle', { Text = 'Enable' });
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Height',
    Default = 0,
    Min = -500,
    Max = 500,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Side',
    Default = 0,
    Min = -200,
    Max = 200,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Up and Down speed',
    Default = 0,
    Min = 0,
    Max = 200,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Hitbox Size',
    Default = 0,
    Min = -30,
    Max = 10,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[lock] changed - ', Value)
    end
})
LeftGroupBox:AddToggle('Toggle', { Text = 'Show AntiHitbox' });
-- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
-- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
-- Dependency box example:
local RightGroupbox = Tabs.Main:AddRightGroupbox('Shake');
RightGroupbox:AddToggle('ControlToggle', { Text = 'Enable' });

local Depbox = RightGroupbox:AddDependencyBox();
Depbox:AddToggle('DepboxToggle', { Text = 'sym' });
-- We can also nest dependency boxes!
-- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set
local SubDepbox = Depbox:AddDependencyBox();
SubDepbox:AddSlider('DepboxSlider', { Text = '^_^', Default = 50, Min = 0, Max = 100, Rounding = 0 });

Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- We can also pass `false` if we only want our features to show when the toggle is off!
});


-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Notif
Library:Notify("nigga.bob loaded!", 5) -- Text, Time

-- Sets the watermark text
Library:SetWatermark('XXX | @11c')

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
