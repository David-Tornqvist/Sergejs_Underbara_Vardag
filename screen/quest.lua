local quest = {};

quest.set = function (text)

    QuestIMG = love.graphics.newImage("content/ui/progress.png");
    QuestText = text;

    if text == nil then
        quest.draw = function ()
            
        end
    else
        quest.draw = function ()

            love.graphics.draw(QuestIMG,0,0);
            Font.draw(QuestText[1],5,16);
            Font.draw(QuestText[2],5,26);
            Font.draw(QuestText[3],5,32);                
        end
    end

    
end

quest.draw = function ()
    
end

return quest;