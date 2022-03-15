function [P] = generate_elliptic_curve(a,b,p,low, high)
% generates coordinates of an elliptic curve with parameters
% a and b
% p is a prime number
% low and high are ranges of x coordinate eg low=0 high=100
X = [];
Y = [];
for i = low:high
    x = mod(i,p);
    y = mod(sqrt(mod(x.^3 + x*a + b,p)),p);
    minus_y = -y;
    minus_y = mod(minus_y,p);
    
    % removes floating point values of y
    if (floor(y) ~= y) || (floor(minus_y) ~= minus_y)
        continue;
    end

    X = [X;x];
    Y = [Y;y];
    X = [X;x];
    Y = [Y;minus_y];
end
P = [X,Y];
% remove duplicate coordinates
P = unique(P,'rows');
end
