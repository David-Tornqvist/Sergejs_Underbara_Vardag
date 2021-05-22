local quest = {};

quest.set = function (text)

    QuestIMG = love.graphics.newImage("content/ui/progress.png");
    QuestText = text;

    if text == nil then
        quest.draw = function ()
            
        end
    else
        quest.draw = function ()

            love.graphics.draw(QuestIMG,0,0,0,3,2);
            Font.draw(QuestText[1],14,10);
            Font.draw(QuestText[2],14,18);
            Font.draw(QuestText[3],14,28);                
        end
    end

    
end

quest.draw = function ()
    
end

return quest;