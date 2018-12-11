local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function keyCodeSet(keys)
   return function()
      for i, keyEvent in ipairs(keys) do
         keyEvent()
      end
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if name == "Visual Studio Code" then
       disableAllHotkeys()
   end
   if event == hs.application.watcher.activated then
      if name == "iTerm2" or name == "MacVim" or name == "Visual Studio Code" then
         disableAllHotkeys()
      else
         enableAllHotkeys()
      end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))
remapKey({'ctrl'}, 'w', keyCode('delete', {'option'}))

remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'}))
remapKey({'ctrl'}, 'd', keyCode('forwarddelete'))
remapKey({'ctrl'}, 'h', keyCode('delete'))

remapKey({'ctrl'}, 's', keyCode('f', {'cmd'}))
remapKey({'ctrl'}, '/', keyCode('z', {'cmd'}))
remapKey({'ctrl'}, '[', keyCode('escape'))

remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'alt'}, 'v', keyCode('pageup'))
remapKey({'cmd', 'shift'}, ',', keyCode('home'))
remapKey({'cmd', 'shift'}, '.', keyCode('end'))
