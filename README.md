# Mog Interactive Objects
Create objects in your world and let them be interactive !

# Usage
```lua
local MogInteractiveObjects = ImportPackage("moginteractiveobjects")
local objectId = CreateObject(1408, x, y, z, h)
MogInteractiveObjects.RegisterInteractiveObject(objectId, function(player)
    AddPlayerChat(player, "Interacted with object "..objectId.." !")
end)
```

# Available functions
```lua
--- Registers an Object as a player interactive object
--- @param objectId number The ID of the object to set as interactive
--- @param fnc function A function that will be called with the player ID when the player interacts with the object
--- @return boolean True if the object was correctly registered
MogInteractiveObjects.RegisterInteractiveObject(objectId, fnc)
--- Unregister an interactive object
--- @param objectId number The ID of the object to unregister
--- @return boolean False if the object was not registered as an interactive object
MogInteractiveObjects.UnregisterInteractiveObject(objectId)
```
