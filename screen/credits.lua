local credits = {};

credits.loadImmediatly = function ()
    credits.load(7);
end

credits.foodEmission = function (ware)
    local emissionTable = {
        BANAN = 0.6,
        FISK = 3,
        GURKA = 1,
        KYCKLING = 3,
        OST = 8,
    };

    if ware == "BALJV%XT" then
        return 0.7;
    elseif ware == "R&DBETA" then    
        return 0.2;
    elseif ware == "N&T STEK" then
        return 26;
    else
        return emissionTable[ware];    
    end
end

credits.trashEmission = function ()

    local emissionTable = {
        bottle = 0.4,
        milk = 0.4,
        ketchup = 0.8,
        tincan = 10.6,
        jar = 0.4
    };

    local emission = 0;

    for i = 1, #PlayerProgress.trash do
        print(PlayerProgress.trash[i]);
        print(emissionTable[PlayerProgress.trash[i]]);
        emission = emission + emissionTable[PlayerProgress.trash[i]];
    end

    return emission;
end

credits.load = function (line)
    CreditsImage = love.graphics.newImage("content/ui/end_screen.png");

    Line = line;

    if line == nil then
        Line = 0;
    end

    local translationTable = {
        banana = "BANAN",
        cheese = "OST",
        chicken = "KYCKLING",
        cucumber = "GURKA",
        fish = "FISK",
        veg = "BALJV%XT",
        roots = "R&DBETA",
        steak = "N&T STEK",
        car = "BIL",
        bike = "CYKEL",
        moped = "MOPED",
        bottle = "GLAS        0.4 KG",
        milk = "KARTONG     0.4 KG",
        ketchup = "PLAST       0.8 KG",
        tincan = "ALUMINIUM   10.6 KG",
        jar = "GLAS        0.4 KG"
    };

    if Line == 0 then
        for i = 1, #PlayerProgress.wares do
        
            PlayerProgress.wares[i] = translationTable[PlayerProgress.wares[i]];
            
        end
    
        PlayerProgress.vehicle = translationTable[PlayerProgress.vehicle]; 
    end
    
    love.update = function ()
        
    end

    credits.emissionTotal = function ()
        local total = 0;
        for i = 1, #PlayerProgress.wares do
            total = total + credits.foodEmission(PlayerProgress.wares[i]);
        end

        total = total + PlayerProgress.switches * 0.01944;
        total = total + credits.trashEmission();

        if PlayerProgress.vehicle == "BIL" then
            total = total + 5.5296;
        elseif PlayerProgress.vehicle == "MOPED" then
            total = total + 1.2528;
        end

        return total;
    end

    love.draw = function ()
        love.graphics.scale(ScreenScale, ScreenScale);
        love.graphics.scale(Zoom, Zoom);
        love.graphics.draw(CreditsImage,0,0);
        love.graphics.setColor(1,1,1,1);

        DrawcreditsText();
    end
end

return credits;