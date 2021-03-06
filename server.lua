local interactiveObjects = {}
local PROPERTY_NAME = "moginteractiveobjects:interactive"

local HIT_TYPES = {}

AddRemoteEvent("moginteractiveobjects:interact", function(player, hitType, hitId)
    local hitFncs = rawget(HIT_TYPES, hitType)
    if hitFncs and hitFncs.check(hitId) then
        local objX, objY, objZ = hitFncs.location(hitId)
        local playerX, playerY, playerZ = GetPlayerLocation(player)
        if GetDistance3D(objX, objY, objZ, playerX, playerY, playerZ) < 300 then
            local objMap = rawget(interactiveObjects, hitType)
            if objMap then
                if rawget(objMap, hitId) then
                    CallEvent("InteractiveObjectInteract", player, hitType, hitId)
                end
            end
        end
    end
end)

--- Registers an Object as a player interactive object
--- @param objectType number Supported values: 2 (player), 3 (vehicle), 4 (npc), 5 (object), 8 (door)
--- @param objectId number The ID of the object to set as interactive (depends on the objectType)
--- @return boolean True if the object was correctly registered
function RegisterInteractiveObject(objectType, objectId)
    local hitFncs = rawget(HIT_TYPES, objectType)
    if not hitFncs or not hitFncs.check(objectId) then
        return false
    end
    hitFncs.set(objectId, true)
    local objectsMap = rawget(interactiveObjects, objectType)
    if not objectsMap then
        objectsMap = {}
        rawset(interactiveObjects, objectType, objectsMap)
    end
    rawset(objectsMap, objectId, true)
    return true
end
AddFunctionExport("RegisterInteractiveObject", RegisterInteractiveObject)

--- Unregister an interactive object
--- @param objectType number Supported values: 2 (player), 3 (vehicle), 4 (npc), 5 (object), 8 (door)
--- @param objectId number The ID of the object to unregister
--- @return boolean False if the object was not registered as an interactive object
function UnregisterInteractiveObject(objectType, objectId)
    local objectsMap = rawget(interactiveObjects, objectType)
    if not objectsMap then
        return false
    end
    if not rawget(objectsMap, objectId) then
        return false
    end
    local hitFncs = rawget(HIT_TYPES, objectType)
    if not hitFncs then
        return false
    end
    hitFncs.set(objectId, nil)
    rawset(objectsMap, objectId, nil)
    return true
end
AddFunctionExport("UnregisterInteractiveObject", UnregisterInteractiveObject)

-- Hit types
HIT_TYPES[2] = {}
HIT_TYPES[2].check = function(player)
    return IsValidPlayer(player)
end
HIT_TYPES[2].location = function(player)
    return GetPlayerLocation(player)
end
HIT_TYPES[2].set = function(player, value)
    SetPlayerPropertyValue(player, PROPERTY_NAME, value, true)
end
HIT_TYPES[3] = {}
HIT_TYPES[3].check = function(vehicle)
    return IsValidVehicle(vehicle)
end
HIT_TYPES[3].location = function(vehicle)
    return GetVehicleLocation(vehicle)
end
HIT_TYPES[3].set = function(vehicle, value)
    SetVehiclePropertyValue(vehicle, PROPERTY_NAME, value, true)
end
HIT_TYPES[4] = {}
HIT_TYPES[4].check = function(npc)
    return IsValidNPC(npc)
end
HIT_TYPES[4].location = function(npc)
    return GetNPCLocation(npc)
end
HIT_TYPES[4].set = function(npc, value)
    SetNPCPropertyValue(npc, PROPERTY_NAME, value, true)
end
HIT_TYPES[5] = {}
HIT_TYPES[5].check = function(object)
    return IsValidObject(object)
end
HIT_TYPES[5].location = function(object)
    return GetObjectLocation(object)
end
HIT_TYPES[5].set = function(object, value)
    SetObjectPropertyValue(object, PROPERTY_NAME, value, true)
end
HIT_TYPES[8] = {}
HIT_TYPES[8].check = function(door)
    return IsValidDoor(door)
end
HIT_TYPES[8].location = function(door)
    return GetDoorLocation(door)
end
HIT_TYPES[8].set = function(door, value)
    SetDoorPropertyValue(door, PROPERTY_NAME, value, true)
end
