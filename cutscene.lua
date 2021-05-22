local quest = require "quest";

local cutscene = {}

cutscene.load = function ()
    Cutscene = {status = false,scene = 0,box = love.graphics.newImage("content/ui/monologue_box.png")};

    Cutscene.texts = {[0] = {""},{"GODMORGON K%RA V%NNER OCH...","",""},{"GODMORGON K%RA V%NNER OCH...","KANSKE BORDE T%NDA LAMPAN","F&RST"},{""},
                            {"OOJOJOJOJ!!!","",""},{"OM JAG SKA HINNA HANDLA OCH","#TERVINNA INNAN JAG SKA TILL","SKOLAN M#STE JAG #KA NU!!!"},{""},
                            {"HOPPAS ATT JAG HITTAR N#GOT","SMARRIGT",""},{""},
                            {"HEJ OCH V%LKOMNA TILL","#TERVINNINGENS UNDERBARA V%RLD",""},{""}};

    Cutscene.draw = function ()
        if Cutscene.texts[Cutscene.scene][1] ~= "" then
            love.graphics.draw(Cutscene.box,0,0);
            love.graphics.setColor(0,0,0,1);
            Font.draw(Cutscene.texts[Cutscene.scene][1], 68,126);
            Font.draw(Cutscene.texts[Cutscene.scene][2], 68,136);
            Font.draw(Cutscene.texts[Cutscene.scene][3], 68,146);
            
            love.graphics.setColor(1,1,1,1);
        end
    end

    Cutscene.update = function (key)
        if Cutscene.texts[Cutscene.scene][1] ~= "" then
            Cutscene.scene = Cutscene.scene + 1;
            if key == "space" then
                SpacePressed = true; 
            end
        end
        if Cutscene.texts[Cutscene.scene][1] == "" then
            Cutscene.status = false;
            if CurrentLevel == "house" then
                quest.set({"#K OCH HANDLA","0/1",""});
            elseif CurrentLevel == "ICA2" then
                quest.set({"HANDLA",#Cart.items .. "/4",""});
            elseif CurrentLevel == "recycle_station" then
                quest.set({"#TERVINN",Sorted .. "/8",""});
            end
            
        end
    end

    Cutscene.start = function ()
        Cutscene.status = true;
        Cutscene.scene = Cutscene.scene + 1;
    end

end

return cutscene;