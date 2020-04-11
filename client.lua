local INTERACTION_KEY = 'E'
local PROPERTY_NAME = "moginteractiveobjects:interactive"

local CHECK_METHODS = {}

function OnKeyPress(key)
    if key == INTERACTION_KEY then
        local hitType, hitId = PlayerLookRaycast(300)
        local checkFnc = rawget(CHECK_METHODS, hitType)
        if checkFnc and checkFnc(hitId) then
            CallRemoteEvent("moginteractiveobjects:interact", hitType, hitId)
        end
    end
end
AddEvent("OnKeyPress", OnKeyPress)

--- Start raycast collisions from the player's head and using the camera's rotation values
--- @param maxDistance number The max distance (in centimeters) to check. BE CAREFUL, big values can result in high CPU time !!
--- @return table see https://dev.playonset.com/wiki/LineTrace 's return value
function PlayerLookRaycast(maxDistance)
    local x, y, z = GetPlayerLocation(GetPlayerId())
    z = z + 60
    local forwardX, forwardY, forwardZ = GetCameraForwardVector()
    local finalPointX = forwardX * maxDistance + x
    local finalPointY = forwardY * maxDistance + y
    local finalPointZ = forwardZ * maxDistance + z
    return LineTrace(x + forwardX * 20, y + forwardY * 20, z, finalPointX, finalPointY, finalPointZ, false)
end
AddFunctionExport("PlayerLookRaycast", PlayerLookRaycast)

-- Check methods
CHECK_METHODS[2] = function(player)
    return GetPlayerPropertyValue(player, PROPERTY_NAME)
end
CHECK_METHODS[3] = function(vehicle)
    return GetVehiclePropertyValue(vehicle, PROPERTY_NAME)
end
CHECK_METHODS[4] = function(npc)
    return GetNPCPropertyValue(npc, PROPERTY_NAME)
end
CHECK_METHODS[5] = function(object)
    return GetObjectPropertyValue(object, PROPERTY_NAME)
end
CHECK_METHODS[8] = function(door)
    return GetDoorPropertyValue(door, PROPERTY_NAME)
end
