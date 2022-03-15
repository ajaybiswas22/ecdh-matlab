function [X,Y] = display_elliptic_curve(a,b,p,low,high,points)
% generates and returns an elliptic curve of parameters a and b 
% p is a prime number
% low and high are ranges in the plot
[x,y] = meshgrid(linspace(low,high,points));
[cm,~] = contour(x,y,mod(y.^2,p) - mod(x.^3 - x*a - b,p),'LevelList',0);
contourTable = getContourLineCoordinates(cm);
ct = table2array(contourTable);
X = ct(:,3);
Y = ct(:,4);

end

