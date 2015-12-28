-------------------------------------------------------------------------------------------
-- UTILS.LUA
-- Samuel Cardoso

Utils = {}

-- Round a number at the superior number
--- Used in the graphics module
function Utils:round(num) 
        if num >= 0 then 
        	return math.floor(num+.5) + 1 
        else 
        	return math.ceil(num-.5) + 1
        end
end

return Utils