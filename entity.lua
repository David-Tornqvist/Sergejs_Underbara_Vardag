local entity = {}

local animationLoad = function (img,width,height,time)
    
    local animation = {};

    animation.texture = love.graphics.newImage("animations/" .. img .. ".png");

    animation.frames = {};

    animation.t = 0;
    animation.maxt = time;
    animation.width = width;
    animation.height = height;

    

    for anim = 1, height do
        animation.frames[anim] = {};
    end


    local pointer = {x = 0, y = 0};
    local cellWidth = animation.texture:getWidth() / width;
    local cellHeight = animation.texture:getHeight() / height;
    print(cellWidth,cellHeight);

    for anim = 1, height do
        for frame = 1, width do
            animation.frames[anim][frame] = love.graphics.newQuad(pointer.x, pointer.y, cellWidth, cellHeight, animation.texture:getDimensions());
            pointer.x = pointer.x + cellWidth;
        end    
        pointer.x = 0;
        pointer.y = pointer.y + cellHeight;
    end

    animation.pointer = {x = 1, y = 1};
    animation.frametime = animation.maxt/animation.width;

    return animation;

end

entity.playerLoad = function ()

    Player = {};

    Player.spawn = {x = 100, y = 85};

    Player.coords = {x = Player.spawn.x, y = Player.spawn.y};

    Player.speed = {x = 0, y = 0};

    Player.moveSpeed = 40;

    Player.animation = animationLoad("sergej",6,12,Player.moveSpeed/80);

    Player.direction = 1;

    Player.isMoving = false;

end
    
return entity