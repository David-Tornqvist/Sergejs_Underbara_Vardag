--David Törnqvist

local mathFunc = {}

mathFunc.pow = function (base,exponential)
    
    local a = base;
    
    for i = 1, (exponential - 1) do
        a = a*base
    end

    if exponential == 0 then
        a = 1;
    end

    return a;

end

mathFunc.pythagoras = function (h,a,b,result)
    if result == "leg" then
        return h/math.sqrt(2);    
    end

    if result == "hyp" then
        return math.sqrt(mathFunc.pow(a,2) + mathFunc.pow(b,2));
    end
    
end

mathFunc.distance = function (x1,y1,x2,y2)
    return mathFunc.pythagoras(0,x1 - x2, y1 - y2,"hyp")
end

return mathFunc