-- @Author: bbales
-- @Date:   2015-05-03 12:49:24
-- @Last Modified by:   bbales
-- @Last Modified time: 2015-05-03 23:00:25

function yaw(value)
    if value == 'left' or value == 'right' then
        print('yaw'..' '..value)
    else
        return commError(3,'Invalid yaw value')
    end
end

function pitch(value)
    if tonumber(value) < 256 and tonumber(value) >= 0 then
        print('pitch'..' '..value)
    else
        return commError(4,'Invalid pitch value')
    end
end

function throttle(value)
    if tonumber(value) < 256 and tonumber(value) >= 0 then
        print('throt'..' '..value)
    else
        return commError(5,'Invalid throttle value')
    end
end

function roll(value)
    if tonumber(value) < 256 and tonumber(value) >= 0 then
        print('roll'..' '..value)
    else
        return commError(6,'Invalid roll value')
    end
end

function calib(value)
    if value == 'true' then
        print('calib'..' '..' true')
    else
        return commError(7,'Invalid calibration command')
    end
end