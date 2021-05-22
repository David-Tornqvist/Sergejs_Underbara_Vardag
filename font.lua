local entity = require "entity.entity";
local string = require "dependencies.split"

local font = {}

font.load = function ()
    Font = {};
    Font.animation = entity.animationLoad("font.png",44,1,0);
    Font.animation.pointer.x = 0
    Font.glyphs = string.split(" ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ1234567890.!?/","");
    Font.x = 0;
    Font.y = 0;

    Font.findIndex = function (char)

        for i = 1, #Font.glyphs do
            if char == Font.glyphs[i] then
                return i
            end            
        end
        return 1;
        
    end

    Font.draw = function (text,x,y)

        Font.x = x;
        Font.y = y;
        
        local textArr = string.split(text,"");

        for i = 1, #textArr do

            Font.animation.pointer.x = Font.findIndex(textArr[i]);

            love.graphics.draw( Font.animation.texture, Font.animation.frames[Font.animation.pointer.y][Font.animation.pointer.x], 
                                    Font.x - Font.animation.cellWidth/2, Font.y - Font.animation.cellHeight/2);
            
            Font.x = Font.x + Font.animation.cellWidth;
        end

    end
end

return font;