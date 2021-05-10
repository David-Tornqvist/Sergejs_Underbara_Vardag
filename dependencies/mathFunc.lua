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

mathFunc.pythagoras = function (h)
    return h/math.sqrt(2);
end

return mathFunc