function Rk (dydt,y0,t_interval,h,fx,varargin)
%======== input arguments=========
% dydt = evaluated ODE
% t_interval = [ti, tf] where ti and tf = initial and
% final values of independent variable
% y0 = initial value of dependent variable
% h = step size
% yp = original function f(t)[Optional]
%========= Code start form this point===========
if nargin<4,error('at least 4 input arguments required'),end
% break of the input interval into two salues
ti = t_interval(1); tf = t_interval(2);
%check the lmits
if (tf<ti),error('upper limit must be greater than lower'),end
t = (ti:h:tf);
%inital value
k1=y0;
k2=y0;
k3=y0;
k4=y0;
y=y0;
FX = y0;
% calculating RK
for i = 1:length(t)-1
k1(i) = dydt(t(i),y0(i));
k2(i) = dydt(t(i)+0.5*h,y0(i)+0.5*k1(i)*h);
k3(i) = dydt(t(i)+0.5*h,y0(i)+0.5*k2(i)*h);
k4(i) = dydt(t(i)+h,y0(i)+k3(i)*h);
y(i+1) = y0(i) + (1/6)*(k1(i)+2*k2(i)+2*k3(i)+k4(i))*h;
y0(i+1) = y(i+1);
%if the user enter the 5th argumnet(orignal equation y(t))
if (nargin == 5)
    FX(i+1) = fx(t(i+1));    
end
end
%if the user enter the 5th argumnet(orignal equation y(t))
t_out=t';
y_out=y';
k1_out=k1';
k2_out=k2';
k3_out=k3';
k4_out=k4';
if (nargin ==5)
% a plot for the real values vs RK's values    
plot (t,FX,'-o R',t,y,'B');
grid on;
title('True Solution vs Range-Kutta Solution');
legend ('True value','Runge-Kutta method');
axis tight;
ylabel('y');
xlabel('t');
fprintf('\t\tt\t\ty\n');
disp([t_out,y_out]);
fprintf('\tk1\t\t\tk2\t\t\tk3\t\tk4\n');
disp([k1_out,k2_out,k3_out,k4_out]);
else %when only 4 arguments
fprintf('\t\tt\t\ty\n');
disp([t_out,y_out]);
fprintf('\tk1\t\t\tk2\t\t\tk3\t\tk4\n');
disp([k1_out,k2_out,k3_out,k4_out]);
end