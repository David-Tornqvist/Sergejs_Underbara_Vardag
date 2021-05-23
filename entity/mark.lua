local mark = {};

local markAnimation = 0;
local markAnimationSpeed = 1.5;

mark.update = function (dt) 
    markAnimation = markAnimation + dt * markAnimationSpeed;

    for i = 1, #Drawables do
        if Drawables[i].name == "mark" then
            Drawables[i].y = Drawables[i].y + math.sin(markAnimation) * 0.05;
        end
    end
end

return mark;