local interactiveObjectFncs = {}

AddRemoteEvent("moginteractiveobjects:interact", function(player, objectId)
    if IsValidObject(objectId) then
        local objX, objY, objZ = GetObjectLocation(objectId)
        local playerX, playerY, playerZ = GetPlayerLocation(player)
        if GetDistance3D(objX, objY, objZ, playerX, playerY, playerZ) < 300 then
            local fnc = rawget(interactiveObjectFncs, objectId)
            if fnc then
                fnc(player)
            end
        end
    end
end)

--- Registers an Object as a player interactive object
--- @param objectId number The ID of the object to set as interactive
--- @param fnc function A function that will be called with the player ID when the player interacts with the object
--- @return boolean True if the object was correctly registered
function RegisterInteractiveObject(objectId, fnc)
    if not IsValidObject(objectId) then
        return false
    end
    SetObjectPropertyValue(objectId, "moginteractiveobjects:interactive", true, true)
    rawset(interactiveObjectFncs, objectId, fnc)
    return true
end
AddFunctionExport("RegisterInteractiveObject", RegisterInteractiveObject)

--- Unregister an interactive item
--- @param objectId number The ID of the object to unregister
--- @return boolean False if the object was not registered as an interactive object
function UnregisterInteractiveObject(objectId)
    if not rawget(interactiveObjectFncs, objectId) then
        return false
    end
    SetObjectPropertyValue(objectId, "moginteractiveobjects:interactive", nil, true)
    rawset(interactiveObjectFncs, objectId, nil)
    return true
end
AddFunctionExport("UnregisterInteractiveObject", UnregisterInteractiveObject)
