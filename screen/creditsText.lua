local credits = require "screen.credits";

local creditsText = {};

DrawcreditsText = function ()
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

    if Line > -1 and Line < 6 then
        Font.draw(" VAL" .. "               " .."CO2 UTSL%PP I KG",40,40);
    end
    
    if Line == 0 then
        Font.draw("TRYCK P# TANGENTBORDET",40,60);
    end
    
    if Line > 0 and Line < 6 then
        Font.draw("LAMPOR T%NDA " .. PlayerProgress.switches .. "/4",40,60);
        Font.draw("" .. PlayerProgress.switches * 0.01944,218,60);
    end

    if Line > 1 and Line < 6 then
        Font.draw("TRANSPORTMEDEL " .. PlayerProgress.vehicle,40,70);
        if PlayerProgress.vehicle == "BIL" then
            Font.draw("5.5296",218,70);
        elseif PlayerProgress.vehicle == "MOPED" then
            Font.draw("1.2528",218,70);
        else
            Font.draw("0",218,70);        
        end
    end
    
    if Line > 2 and Line < 6 then
        Font.draw("FELAKTIGT #TERVUNNET " .. 6 - PlayerProgress.recycle .. "/6  ",40,80);
        Font.draw("" .. credits.trashEmission(),218,80);
    end

    if Line > 3 and Line < 6 then
        Font.draw("MATVAROR 1 KG",40,90);
        Font.draw(PlayerProgress.wares[1], 40, 100);
        Font.draw(PlayerProgress.wares[2], 40, 110);
        Font.draw(PlayerProgress.wares[3], 40, 120);
        Font.draw(PlayerProgress.wares[4], 40, 130);

        Font.draw("" .. credits.foodEmission(PlayerProgress.wares[1]), 218, 100);
        Font.draw("" .. credits.foodEmission(PlayerProgress.wares[2]), 218, 110);
        Font.draw("" .. credits.foodEmission(PlayerProgress.wares[3]), 218, 120);
        Font.draw("" .. credits.foodEmission(PlayerProgress.wares[4]), 218, 130);
    end

    if Line == 5 then
        Font.draw("TOTAL",50,150);
        Font.draw("" .. credits.emissionTotal(),218,150);
    end

    if Line == 6 then

        if #PlayerProgress.trash ~= 0 then
            Font.draw(" DINA CO2 UTSL%PP FR#N FELAKTIG", 40, 40);
            Font.draw(" #TERVINNING PER KG MATERIAL", 40, 50);

            for i = 1, #PlayerProgress.trash do
                Font.draw(translationTable[PlayerProgress.trash[i]],40, 60 + i *10);
            end 
        else
            Line = Line + 1
        end
    end

    if Line == 7 then
        Font.draw("  K%LLOR", 40, 40);
        
        Font.draw("  KJELL.COM", 40, 60);
        Font.draw("  EN LED LAMPA DRAR 9W",40, 70);

        Font.draw("  UTSLAPPSRATT.SE", 40, 90);
        Font.draw("  EN LED LAMPA SL%PPER UT 0.01944", 40, 100);
        Font.draw("  KG CO2 PER DYGN", 40, 110);
        
        Font.draw("  MILJ&F&RVALTNINGEN", 40, 130);
        Font.draw("  EN MOPED SL%PPER UT 0.058", 40, 140);
        Font.draw("  KG CO2 PER KM", 40, 150);
    end

    if Line == 8 then
        Font.draw("  K%LLOR", 40, 40);

        Font.draw("  ECOTREE.GREEN", 40, 60);
        Font.draw("  EN BIL SL%PPER UT 0.259", 40, 70);
        Font.draw("  KG CO2 PER KM", 40, 80);

        Font.draw("  MAPS.GOOGLE.COM", 40, 100);
        Font.draw("  F%RDSTR%CKAN MELLAN %LVS& OCH", 40, 110);
        Font.draw("  TULLINGE VAR 21.6 KM TUR OCH", 40, 120);
        Font.draw("  RETUR", 40, 130);
    end

    if Line == 9 then
        Font.draw("  K%LLOR", 40, 40);

        Font.draw("  CO2 UTSL%PPET F&R F%RDSTR%CKAN", 40, 60);
        Font.draw("  F&R BIL     5.5295 KG", 40, 70);
        Font.draw("  F&R MOPED   1.2529 KG", 40, 80);
    end

    if Line == 10 then
        Font.draw("  K%LLOR", 40, 40);

        Font.draw("  SVERIGES LANTBRUKSUNIVERSITET", 40, 60);
        Font.draw("  CO2 UTSL%PP I KG PER KG MATVARA", 40, 70);
        Font.draw("  BANAN       0.6", 40, 80);
        Font.draw("  N&T STEK    26", 40, 90);
        Font.draw("  FISK        3", 40, 100);
        Font.draw("  GURKA       1", 40, 110);
        Font.draw("  KYCKLING    3", 40, 120);
        Font.draw("  OST         8", 40, 130);
        Font.draw("  R&DTBETOR   0.2", 40, 140);
        Font.draw("  BALJV%XTER  0.7", 40, 150);
    end

    if Line == 11 then
        Font.draw("  K%LLOR", 40, 40);

        Font.draw("  RECYCLING.SE", 40, 60);
        Font.draw("  KLIMATNYTTA MED ", 40, 70);
        Font.draw("  MATERIAL#TERVINNING J%MF&RT MED  ", 40, 80);
        Font.draw("  PRODUKTION FR#N NY R#VARA I KG CO2 ", 40, 90);
        Font.draw("  EKVIVALENTER PER KG MATERIAL ", 40, 100);
        Font.draw("  J%MF&RT MED PRODUKTION FR#N NY", 40, 110);
        Font.draw("  R#VARA   GLAS        0.4",40,120);
        Font.draw("           ALUMINIUM   10.6",40,130);
        Font.draw("           PLAST       0.8",40,140);
        Font.draw("           KARTONG     0.4",40,150);
    end

    if Line == 12 then
        Font.draw("  ANALYS", 40, 40);

        Font.draw("  AV DET H%R KAN VI DRA SLUTSATSEN", 40, 60);
        Font.draw("  ATT VARDAGLIGA VAL SOM ATT SE TILL", 40, 70);
        Font.draw("  ATT G# ELLER CYKLA TILL", 40, 80);
        Font.draw("  ARBETE/SKOLA IST%LLET F&R ATT #KA", 40, 90);
        Font.draw("  BIL KAN HA P#VERKAN P# V#RA CO2", 40, 100);
        Font.draw("  UTSL#PP. %VEN FELAKTIG #TERVINNING", 40, 110);
        Font.draw("  AV FR%MST ALUMINIUM SAMT", 40, 120);
        Font.draw("  KOSUMPTION AV PRODUKTER FR#N", 40, 130);
        Font.draw("  N&TDJUR HAR STOR P#VERKAN.", 40, 140);
    end
    
    if Line == 13 then
        Font.draw("  MEDVERKANDE", 40, 40);

        Font.draw("  MELVIN BENTINGER", 40, 60);
        Font.draw("  GRAFIK/SPELDESIGN/FYSIKBER%KNINGAR", 40, 70);

        Font.draw("  DAVID T&RNQVIST", 40, 90);
        Font.draw("  PROGRAMMERING/SPELDESIGN/", 40, 100);
        Font.draw("  FYSIKBER%KNINGAR", 40, 110);

        Font.draw("  HIROKAZU TANAKA", 40, 130);
        Font.draw("  MUSIK", 40, 140);
    end

    if Line == 14 then
        LoadMainMenu();
    end
    
end

return creditsText;