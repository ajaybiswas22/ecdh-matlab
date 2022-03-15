function Point = elliptic_curve_add(x_p,y_p,x_q,y_q,a,b,p)
% adds points P and Q of coordinates (x_p,y_p) and (x_q,y_q) respectively
% a and b are parameters of curve and p is a prime number

if (x_p == x_q &&  y_p == y_q)
    Point = elliptic_curve_add_same(x_p,y_p,a,b,p);
    return;
end

lambda_up = mod((y_q-y_p),p);
lambda_down = mod((x_q-x_p),p);

[G,D] = gcd(lambda_down,p);
lambda_down = mod(D,p);

lambda = mod((lambda_up * lambda_down),p);
 
x_r = mod((lambda.^2 - x_p - x_q),p);
y_r = mod((lambda*(x_p-x_r)-y_p),p);

Point = [x_r,y_r];
end