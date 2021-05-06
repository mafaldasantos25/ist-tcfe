close all 
clear all

f=50;
w=2*pi*f;
Rs=8.1e3;
Rl=8e3;
C=10e-6;


%envelope detector
A=76.5;
t=linspace(0, 2e-1, 1000);
f=50;
w=2*pi*f;
vS = A * cos(w*t);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));
n=t/0.02;

tOFF = (1/w) * atan(1/w/Rs/C)




envelope = figure();
for i=1:length(t)
  if (vS(i) > 0)
    vOhr(i) = vS(i);
  else
    vOhr(i) = -vS(i);
  endif
endfor

%plot(t*1000, vOhr)
hold
n=1;
for i=1:length(t)
  if(t(i)>=n*0.01)
  tOFF=tOFF+0.01;
  n=n+1;
  endif
  vOnexp(i) = abs(A*cos(w*tOFF)*exp(-(t(i)-tOFF)/Rs/C));
  if t(i) < tOFF
    vO(i) = vOhr(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else 
    vO(i) = vOhr(i);
  endif
endfor

plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("envelope")
print ("venvlope.eps", "-depsc");

%Regulator Circuit

Vcontinuo = median(vO)

%%solve circuit with accurate model

function f = f(vD,vS,R,n)
Is = 1e-14;
VT=26e-3;
f = vD+R*Is * (exp(vD/VT/n)-1) - vS;
endfunction

function fd = fd(vD,R, n)
Is = 1e-14;
VT=26e-3;
fd = 1 + R*Is/VT/n * (exp(vD/VT/n));
endfunction

function vD_root = solve_vD (vS, R, n)
  delta = 1e-6;
  x_next = 0.65;

  do 
    x=x_next;
    x_next = x  - f(x, vS, R, n)/fd(x, R, n);
  until (abs(x_next-x) < delta)

  vD_root = x_next;
endfunction

n=17;
Is = 1e-14;
VT=26e-3;

VD = solve_vD (Vcontinuo, Rl, n);

rd = (VT*n)/(Is*exp(VD/VT/n));

vs = vO-Vcontinuo;

vo = (rd/(rd+Rl)) * vs;

Vout = VD + vo;

output=figure();

plot(t*1000, Vout)
title("Output voltage Vout(t)")
xlabel ("t[ms]")
print ("vout.eps", "-depsc");


VDC = median(Vout)
Vripple = max(Vout) - min(Vout)

erro = figure()

plot(t*1000, Vout-12)
title("Vout(t)-12")
xlabel ("t[ms]")
print ("erro.eps", "-depsc");

save tab1.tex VDC Vripple

movefile('*.eps','../doc')
