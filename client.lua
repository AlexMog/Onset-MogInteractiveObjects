local INTERACTION_KEY = 'E'

function OnKeyPress(key)
    if key == INTERACTION_KEY then
        local hitType, hitId = PlayerLookRaycast(300)
        if hitType == 5 then
            if GetObjectPropertyValue(hitId, "moginteractiveobjects:interactive") then
                CallRemoteEvent("moginteractiveobjects:interact", hitId)
            end
        end
    end
end
AddEvent("OnKeyPress", OnKeyPress)

function PlayerLookRaycast(maxDistance)
    local x, y, z = GetPlayerLocation(GetPlayerId())
    z = z + 60
    local forwardX, forwardY, forwardZ = GetCameraForwardVector()
    local finalPointX = forwardX * maxDistance + x
    local finalPointY = forwardY * maxDistance + y
    local finalPointZ = forwardZ * maxDistance + z
    return LineTrace(x + forwardX * 20, y + forwardY * 20, z, finalPointX, finalPointY, finalPointZ, false)
end
