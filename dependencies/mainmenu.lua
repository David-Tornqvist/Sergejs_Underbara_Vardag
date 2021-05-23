--David Törnqvist
local game = require "game";
local credits = require "screen.credits";

game = require "game";

LoadMainMenu = function ()

    SplashScreen = love.graphics.newImage("content/ui/splash_screen.jpg");

    local tutorialHover = false;
    local spelaHover = false;
    local avslutaHover = false;
    local musicHover = false;

    local exit = function ()
        love.event.quit(); 
    end

    local toggleMusic = function ()
        if Music == true then
            Soundtack:pause();
            Music = false;
        else
            Soundtack:play();
            Music = true;    
        end
    end

    love.mousemoved = function (x, y)

        x = x / ScreenScale;
        y = y / ScreenScale;

        if x > 886 and x < 948 and
           y > 502 and y < 532 then
            spelaHover = true;
        else
            spelaHover = false;    
        end

        if  x > 880 and x < 966 and
            y > 402 and y < 432 then
            tutorialHover = true;
        else
            tutorialHover = false;        
        end

        
        if  x > 886 and x < 976 and
            y > 900 and y < 930 then
            avslutaHover = true;
        else
            avslutaHover = false;        
        end

        if  x > 1800 and x < 1870 and
            y > 50 and y < 80 then
            musicHover = true;
        else
            musicHover = false;        
        end
    end

    love.mousepressed = function (x,y)

        x = x / ScreenScale;
        y = y / ScreenScale;

        if x > 886 and x < 948 and
           y > 502 and y < 532 then

            game.load();

        end
        
        if  x > 880 and x < 966 and
            y > 402 and y < 432 then
        
            credits.loadImmediatly();

        end
        
        if  x > 886 and x < 976 and
            y > 900 and y < 930 then
    
            exit();

        end

        if  x > 1800 and x < 1870 and
            y > 50 and y < 80 then
            
            toggleMusic();

        end

    end

    function love.keypressed(key)

        

        if (key == "escape") then 
            exit();
        end

        Line = Line + 1;
    
    end

    love.draw = function ()
        --love.graphics.setColor(1,1,1,1);
        --love.graphics.rectangle("fill", 1800,50,70,30);

        love.graphics.scale(ScreenScale, ScreenScale);

        love.graphics.setColor(1,1,1,1);
        love.graphics.draw(SplashScreen,love.graphics.getWidth()/3,0,0.2);

        love.graphics.setColor(0,1,0,1);
        love.graphics.print("Sergejs Underbara Vardag",650,200,0,4,4);

        if tutorialHover then
            love.graphics.setColor(1,0,0,1); 
        end
        love.graphics.print("analys",880,400,0,2,2);
        love.graphics.setColor(0,1,0,1);

        if spelaHover then
            love.graphics.setColor(1,0,0,1);
        end
        love.graphics.print("spela",886,500,0,2,2);
        love.graphics.setColor(0,1,0,1);

        if avslutaHover then
            love.graphics.setColor(1,0,0,1);
        end
        love.graphics.print("avsluta",886,900,0,2,2);
        love.graphics.setColor(0,1,0,1);


        if musicHover then
            love.graphics.setColor(1,0,0,1);
        end

        if Music == false then
            love.graphics.setColor(1,0,0,1);
            love.graphics.line(1800,50,1870,80);
        end

        love.graphics.print("musik",1800,50,0,2,2);
        love.graphics.setColor(0,1,0,1);

    end
end