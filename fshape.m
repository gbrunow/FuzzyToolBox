function grade = fshape(x, coordinates)
    if ~isvector(coordinates) || length(coordinates) < 3 || length(coordinates) > 4
        error('Triangular: fshape(x, [A B C]) | Trapezoidal: fshape(x, [A B C D])');
    end
    a = coordinates(1);
    b = coordinates(2);
    if(length(coordinates) == 3)
        c = b;
        d = coordinates(3);
    else
        c = coordinates(3);
        d = coordinates(4);
    end
    if a > b || b > c || c > d
        if(length(coordinates) == 3)
            error('Illegal parameters. Must respect: A < B < C');
        else
            error('Illegal parameters. Must respect: A < B < C < D');
        end
    end
    
    for i = 1:length(x)
        v(1,i) = max(min(min(((x(i)-a)/(b-a)), 1), ((d-x(i))/(d-c))),0);
        v(2,i) = x(i);
    end
    grade = v;
end