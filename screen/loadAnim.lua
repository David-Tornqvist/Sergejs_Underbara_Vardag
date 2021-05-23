local loadAnim = {};

loadAnim.load = function (speed,y)
    LoadAnim = {y = y,speed = speed};
end

loadAnim.update = function (dt)
    LoadAnim.y = LoadAnim.y + LoadAnim.speed * dt;
end

loadAnim.draw = function ()
    love.graphics.setColor(0,0,0,1);
    love.graphics.rectangle("fill",0,LoadAnim.y,Window.width,Window.height);
    love.graphics.setColor(1,1,1,1);
end

return loadAnim;