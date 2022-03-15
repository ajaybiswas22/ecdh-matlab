function Point = elliptic_curve_add_same(x,y,a,b,p)
% adds point P (x,y) to itself
% a and b are parameters of curve and p is a prime number

lambda_up = mod((3*(x.^2) + a),p);
lambda_down = mod(2*y,p);

[G,D] = gcd(lambda_down,p);
lambda_down = mod(D,p);

lambda = mod((lambda_up * lambda_down),p);
 
x_r = mod((lambda.^2 - x - x),p);
y_r = mod((lambda*(x-x_r)-y),p);

Point = [x_r,y_r];
end