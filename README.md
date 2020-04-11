# Mog Interactive Objects
Create objects in your world and let them be interactive !

# Usage
```lua
local MogInteractiveObjects = ImportPackage("moginteractiveobjects")
local objectId = CreateObject(1408, x, y, z, h)
MogInteractiveObjects.RegisterInteractiveObject(5, objectId, function(player)
    AddPlayerChat(player, "Interacted with object "..objectId.." !")
end)
```

# Available functions
```lua
--- Registers an Object as a player interactive object
--- @param objectType number Supported values: 2 (player), 3 (vehicle), 4 (npc), 5 (object), 8 (door)
--- @param objectId number The ID of the object to set as interactive (depends on the objectType)
--- @param fnc function A function that will be called with the player ID when the player interacts with the object
--- @return boolean True if the object was correctly registered
MogInteractiveObjects.RegisterInteractiveObject(objectType, objectId, fnc)
--- Unregister an interactive object
--- @param objectType number Supported values: 2 (player), 3 (vehicle), 4 (npc), 5 (object), 8 (door)
--- @param objectId number The ID of the object to unregister
--- @return boolean False if the object was not registered as an interactive object
MogInteractiveObjects.UnregisterInteractiveObject(objectType, objectId)
--- Start raycast collisions from the player's head and using the camera's rotation values
--- @param maxDistance number The max distance (in centimeters) to check. BE CAREFUL, big values can result in high CPU time !!
--- @return table see https://dev.playonset.com/wiki/LineTrace 's return value
MogInteractiveObjects.PlayerLookRaycast(maxDistance)
```
