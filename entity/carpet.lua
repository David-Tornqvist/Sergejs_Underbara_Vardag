local carpet = {};

carpet.update = function ()
    if CurrentLevel == "bedroom" then

        local carpet = Drawables[GetDrawableIndex("floor")];

        carpet.animation.pointer.x = 1;

        if Player.coords.y < 80 then
            carpet.animation.pointer.x = 4;
        elseif Player.coords.y > 100 then
            carpet.animation.pointer.x = 2;     
        elseif Player.coords.x > 45 then
            carpet.animation.pointer.x = 3;   
        end
 
    end

    if CurrentLevel == "house" then
        local carpet = Drawables[GetDrawableIndex("floor")];

        carpet.animation.pointer.x = 1;

        if Player.coords.y < 124 and Player.coords.x < 120 then
            carpet.animation.pointer.x = 4;
        elseif Player.coords.x < 120 then
            carpet.animation.pointer.x = 5;
        end

    end
    
end

return carpet;