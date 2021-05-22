local cutscene = {}

cutscene.load = function ()
    Cutscene = {status = false,scene = 0,box = love.graphics.newImage("content/ui/monologue_box.png")};

    Cutscene.texts = {[0] = {""},{"dsa"},{"we"},{"qq"},{"ere"},{""}};

    Cutscene.draw = function ()
        if Cutscene.texts[Cutscene.scene][1] ~= "" then
            love.graphics.draw(Cutscene.box,0,0);
            love.graphics.setColor(0,0,0,1);
            love.graphics.print(Cutscene.texts[Cutscene.scene][1], 70,128); 
            love.graphics.setColor(1,1,1,1);
        end
    end

    Cutscene.update = function ()
        if Cutscene.texts[Cutscene.scene][1] ~= "" then
            Cutscene.scene = Cutscene.scene + 1;
        else
            Cutscene.status = false;
        end
    end

    Cutscene.start = function ()
        Cutscene.status = true;
        Cutscene.scene = Cutscene.scene + 1;
    end

end

return cutscene;