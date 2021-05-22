local credits = {};

credits.load = function ()

    Line = 0;

    local translationTable = {
        banana = "BANAN",
        cheese = "OST",
        chicken = "KYCKLING",
        cucumber = "GURKA",
        fish = "FISK",
        veg = "V%XTBASERAT PROTEIN",
        roots = "R&DBETA",
        car = "BIL",
        bike = "CYKEL",
        moped = "MOPED"
    }

    for i = 1, #PlayerProgress.wares do
        
        PlayerProgress.wares[i] = translationTable[PlayerProgress.wares[i]];
        
    end

    PlayerProgress.vehicle = translationTable[PlayerProgress.vehicle];
    
    
    love.update = function ()
        
    end

    love.draw = function ()
        love.graphics.scale(ScreenScale, ScreenScale);
        love.graphics.scale(Zoom, Zoom);
        love.graphics.draw(QuestIMG,0,0,0,8,8);
        Font.draw("VAL" .. "                " .."CO2 UTSL%PP I KG",40,40);

        
        if Line == 0 then
            Font.draw("TRYCK P# TANGENTBORDET",40,60);
        end
        
        
        if Line > 0 then
            Font.draw("LAMPOR T%NDA " .. PlayerProgress.switches .. "/4",40,60);
            Font.draw("" .. PlayerProgress.switches * 0.01944,218,60);
        end
        if Line > 1 then
            Font.draw("TRANSPORTMEDEL " .. PlayerProgress.vehicle,40,70);
        end
        if Line > 2 then
            Font.draw("FELAKTIGT #TERVUNNET " .. 6 - PlayerProgress.recycle .. "/6  ",40,80);
        end
        if Line > 3 then
            Font.draw("MATVAROR",40,90);
            Font.draw(PlayerProgress.wares[1], 40, 100);
            Font.draw(PlayerProgress.wares[2], 40, 110);
            Font.draw(PlayerProgress.wares[3], 40, 120);
            Font.draw(PlayerProgress.wares[4], 40, 130);
        end
        
    end
end

return credits;