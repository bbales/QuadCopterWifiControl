-- @Author: bbales
-- @Date:   2015-05-02 20:07:31
-- @Last Modified by:   bbales
-- @Last Modified time: 2015-05-03 12:59:21

local commands = {'yaw','roll','throt','pitch','calib'}

-- Request Multiplexing
function switchBox(req)
    local command = nil
    local setpoint = nil
    local colon = nil
    local commandArray

    local comma = string.find(req,',')
    if not comma then
        commandArray = {req}
    else
        commandArray = split(req,',')
    end

    for i = 1, #commandArray do
        -- print(commandArray[i])
        local colon = string.find(commandArray[i],':')
        -- Validate request
        if colon == nil then
            return commError(1,'Malformed')
        end

        -- Parse command and value
        command = string.sub(commandArray[i],1,colon-1)
        setpoint = string.sub(commandArray[i],colon+1)

        -- Make sure command exists
        if not inArray(command,commands) then
            print(command)
            return commError(2,'Not a command')
        end

        if  command == 'yaw' then yaw(setpoint)
        elseif  command == 'roll' then roll(setpoint)
        elseif  command == 'throt' then throttle(setpoint)
        elseif  command == 'pitch' then pitch(setpoint)
        elseif  command == 'calib' then calib(setpoint)
        end
    end
end

function commError(num,errStr)
    print('ERROR' .. num)
    return errStr
end

function inArray(data, array)
    local valid = {}
    for i = 1, #array do
        valid[array[i]] = true
    end
    if valid[data] then
        return true
    else
        return false
    end
end

function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
    return elements
end