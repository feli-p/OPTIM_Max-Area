function [x,mu,iter] = intpoint2(fname,gname,x0)
% Método de barrera logarítmica (en forma de puntos interiores)
% Problema:
%       Min     f(x)
%       s.a.    g(x) >= 0
% la función f(x) está codificada en Matlab en fname.m
% la función g(x) está en el código de Matlab gname.m
% x0 s el punto inicial
% Out
% x     .-  aproximación al mínimo local del problema
% mu    .-  multiplicador de Lagrange
% iter  .-  número de iteraciones
%
% Usamos actualización BFGS para la matriz hessiana del Lagrangeano.
%
% Optimización Numérica
% ITAM
% 16 de noviembre de 2023
% ------------------------------------------------------------

tol = 1e-05;
maxiter = 100;
iter = 0;

x = x0;
gx = feval(gname,x);
gradx = gradiente(fname,x);
Jx = jacobiana1(gname,x);
n = length(x);
p = length(gx);
mu = ones(p,1);
z = ones(p,1);
vcnpo = [gradx-Jx'*mu; -gx+z; mu.*z];
gamma = 1/2;

B = eye(n);

while(norm(vcnpo)>tol && iter<maxiter)
    % Aproximamos la matriz del sistema de Newton
    % B = hessianalag(fname,gname,x,-mu);
    M = [B zeros(n,p) -Jx';
        -Jx eye(p) zeros(p);
        zeros(p,n) diag(mu) diag(z)];
    % Calculamos el lado derechp del sistema lineal
    ld = -[gradx-Jx'*mu; -gx+z; mu.*z-gamma];

    % Resolvemos el sistema lineal
    Delta = M\ld;

    % Separamos los pasos para x, z y mu
    Dx = Delta(1:n);
    Dz = Delta(n+1:n+p);
    Dmu = Delta(n+p+1:end);

    % Recortamos el paso
    alfaz = recorta(z,Dz);
    alfamu = recorta(mu, Dmu);

    alfa = 0.8*min([alfaz,alfamu,1]);

    % --------------------------------------------------------
    % Actualización BFGS a la matriz hessiana del Lagrangeano
    xp = x + alfa*Dx;
    z = z + alfa*Dz;
    mu = mu + alfa*Dmu;

    gradxp = gradiente(fname,xp);
    Jxp = jacobiana1(gname,xp);
    w1 = gradxp-Jxp'*mu;
    w2 = gradx-Jx'*mu;
    
    y = w1-w2;
    s = xp-x;
    beta = s'*B*s;

    if(s'*y <(0.2)*beta)
        theta = (0.8)*beta/(beta-s'*y);
        rtheta = B*s + theta*(y-B*s);
    else
        %theta = 1;
        rtheta = y;
    end

    B = B-(B*s*s'*B)/beta + (rtheta*rtheta')/(s'*rtheta);
    Brcond = rcond(B);
    if(Brcond < 1e-12)
        B = eye(n);
    end
    % --------------------------------------------------------

    % Nuevo punto
    x = xp;
    gradx = gradxp;
    Jx = Jxp;

    % Nuevos valores
    gx = feval(gname,x);
    vcnpo = [gradx-Jx'*mu; -gx+z; mu.*z];

    gamma = gamma/2;

    iter = iter +1;
    %fprintf('%2.0f %2.8f %2.8f \n', iter, norm(vcnpo), Brcond)


end

end