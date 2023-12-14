function [fx] = funobj(x)
%funobj Función objetivo para el problema del polígono de área máxima.
n = length(x);
fx = 0;
for i = 1:2:n-3
    fx = fx + (x(i+2)*x(i)*sin(x(i+3)-x(i+1)));
end
fx = -fx/2;
end