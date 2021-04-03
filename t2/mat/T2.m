%passo1
%introdução dos dados
%introdução dos dados
format long
fic = fopen('../data.txt');

for k=1:9
  fgets(fic);
end

valores = fscanf(fic,'%*s = %f');
fclose(fic);

R1 = valores (1) *1000;
R2 = valores (2) *1000;
R3 = valores (3) *1000;
R4 = valores (4) *1000;
R5 = valores (5) *1000;
R6 = valores (6) *1000;
R7 = valores (7) *1000;
Vs = valores (8) ;
C = valores (9) /1000000;
Kb = valores (10) /1000;
Kd = valores (11) *1000;

Vsi=Vs

fileId = fopen('dados1.txt','w');
fprintf(fileId, 'Va 1 0 DC %f\n', Vs);
fprintf(fileId, 'C1 8 6 %f\n', C);
fprintf(fileId, 'R1 1 2 %f\n', R1);
fprintf(fileId, 'R2 2 3 %f\n', R2);
fprintf(fileId, 'R3 2 5 %f\n', R3);
fprintf(fileId, 'R4 0 5 %f\n', R4);
fprintf(fileId, 'R5 5 6 %f\n', R5);
fprintf(fileId, 'R6 9 7 %f\n', R6);
fprintf(fileId, 'R7 7 8 %f\n', R7);
fprintf(fileId, 'VE 0 9 0V\n');
fprintf(fileId, 'Hvc 5 8 VE %f\n', Kd);
fprintf(fileId, 'Gib 6 3 2 5 %f\n', Kb);
fclose(fileId)

movefile('dados1.txt','../sim')


%PONTO 1:
%Análise do circuito usando o método dos nós para t<0

A = [1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    -1/R1, 1/R1+1/R2, -1/R2, 0, 0, 0, 0, 0, 1/R3, 0, 0, 0, 0; ...
    0, 1/R2,-1/R2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; ...
    0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 0, 0, 0, 1/R5, -1/R5, 0, 0, 0, 0, -1, -1, 0; ...
    0, 0, 0, 0, 0, 0, -1/R7, 1/R7, 0, 0, 0, 0, 1; ...
    0, 0, 0, 0, 0, 0, 0, 0, -Kb, 0, 1, 0, 0; ...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0; ...
    0, 0, 0, 1/R6, 0, 0, -1/R6, 0, 0, 0, 0, 0, -1; ...
    0, -1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;...
    0 , 0, 0, 0, -1, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -Kd;...
    0, 0,0, 1/R4,-1/R4-1/R5, 1/R5, 1/R7, -1/R7, 1/R3, 0, 0, 1, 0]
    
    
    

    
    
    
    
B = [Vs;0;0;0;0;0;0;0;0;0;0;0;0]
x = A\B;

V1 = x(1)
V2 = x(2)
V3 = x(3)
V4 = x(4)
V5 = x(5)
V6 = x(6)
V7 = x(7)
V8 = x(8)
Vb=x(9)
Vd=x(10)
Ib=x(11)
Ic=x(12)
Id=x(13)
V6i=V6;

IR1=(V2-V1)/R1
IR2=(V3-V2)/R2
IR3=(V2-V5)/R3
IR4=(V5-V4)/R4
IR5=(V5-V6)/R5
IR6=Id
IR7=Id

save tab1.tex V1 V2 V3 V4 V5 V6 V7 V8 IR1 IR2 IR3 IR4 IR5 IR6 IR7 Ib Ic Id



%PONTO 2:
%Determinar R equivalente

Vx=V6-V8

fileId = fopen('dados2.txt','w');
fprintf(fileId, 'Va 1 0 DC 0\n');
fprintf(fileId, 'Vx 8 6 %f\n', Vx);
fprintf(fileId, 'R1 1 2 %f\n', R1);
fprintf(fileId, 'R2 2 3 %f\n', R2);
fprintf(fileId, 'R3 2 5 %f\n', R3);
fprintf(fileId, 'R4 0 5 %f\n', R4);
fprintf(fileId, 'R5 5 6 %f\n', R5);
fprintf(fileId, 'R6 9 7 %f\n', R6);
fprintf(fileId, 'R7 7 8 %f\n', R7);
fprintf(fileId, 'VE 0 9 0V\n');
fprintf(fileId, 'Hvc 5 8 VE %f\n', Kd);
fprintf(fileId, 'Gib 6 3 2 5 %f\n', Kb);
fclose(fileId)

movefile('dados2.txt','../sim')

A = [1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    -1/R1, 1/R1+1/R2, -1/R2, 0, 0, 0, 0, 0, 1/R3, 0, 0, 0, 0; ...
    0, 1/R2,-1/R2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; ...
    0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0; ...
    0, 0, 0, 0, 0, 0, -1/R7, 1/R7, 0, 0, 0, 0, 1; ...
    0, 0, 0, 0, 0, 0, 0, 0, -Kb, 0, 1, 0, 0; ...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0; ...
    0, 0, 0, 1/R6, 0, 0, -1/R6, 0, 0, 0, 0, 0, -1; ...
    0, -1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;...
    0 , 0, 0, 0, -1, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -Kd;...
    0, 0,0, 1/R4,-1/R4, 0, 1/R7, -1/R7, 1/R3, 0, -1, 0, 0]
    
    
    

       
B = [0;0;0;0;Vx;0;0;0;0;0;0;0;0]
x = A\B;

V1 = x(1)
V2 = x(2)
V3 = x(3)
V4 = x(4)
V5 = x(5)
V6 = x(6)
V7 = x(7)
V8 = x(8)
Vb=x(9)
Vd=x(10)
Ib=x(11)
Ix=(V5-V6)/R5 -Ib
Id=x(13)
Req=Vx/(-Ix)

IR1=(V2-V1)/R1
IR2=(V3-V2)/R2
IR3=(V2-V5)/R3
IR4=(V5-V4)/R4
IR5=(V5-V6)/R5
IR6=Id
IR7=Id


save tab2.tex V1 V2 V3 V4 V5 V6 V7 V8 IR1 IR2 IR3 IR4 IR5 IR6 IR7 Ib Ic Id Req

%passo3

fileId = fopen('dados3.txt','w');
fprintf(fileId, '.ic v(6)=%f v(8)=%f\n', V6, V8);
fprintf(fileId, 'Va 1 0 DC 0\n');
fprintf(fileId, 'C 8 6 %f\n', C);
fprintf(fileId, 'R1 1 2 %f\n', R1);
fprintf(fileId, 'R2 2 3 %f\n', R2);
fprintf(fileId, 'R3 2 5 %f\n', R3);
fprintf(fileId, 'R4 0 5 %f\n', R4);
fprintf(fileId, 'R5 5 6 %f\n', R5);
fprintf(fileId, 'R6 9 7 %f\n', R6);
fprintf(fileId, 'R7 7 8 %f\n', R7);
fprintf(fileId, 'VE 0 9 0V\n');
fprintf(fileId, 'Hvc 5 8 VE %f\n', Kd);
fprintf(fileId, 'Gib 6 3 2 5 %f\n', Kb);
fclose(fileId)

movefile('dados3.txt','../sim')

v6 = V6
t=0:0.0001:0.020;
tau=Req*C;
V6=Vx*exp(-t/tau)

solnat=figure()
plot(t,V6)
xlabel ("time [s]");
ylabel ("V6 [V]");
print(solnat, "solnat.eps", "-depsc")
hold off


%PONTO 4
% Transient frequency response

fileId = fopen('dados4.txt','w');
fprintf(fileId, '.ic v(6)=%f v(8)=%f\n', v6, V8);
fprintf(fileId, 'Va 1 0 0 ac 1 sin 0 1 1k \n');
fprintf(fileId, 'C 8 6 %f\n', C);
fprintf(fileId, 'R1 1 2 %f\n', R1);
fprintf(fileId, 'R2 2 3 %f\n', R2);
fprintf(fileId, 'R3 2 5 %f\n', R3);
fprintf(fileId, 'R4 0 5 %f\n', R4);
fprintf(fileId, 'R5 5 6 %f\n', R5);
fprintf(fileId, 'R6 9 7 %f\n', R6);
fprintf(fileId, 'R7 7 8 %f\n', R7);
fprintf(fileId, 'VE 0 9 0V\n');
fprintf(fileId, 'Hvc 5 8 VE %f\n', Kd);
fprintf(fileId, 'Gib 6 3 2 5 %f\n', Kb);
fclose(fileId)

movefile('dados4.txt','../sim')

AVS=1;
w=2*pi*1000;
Zc=1/(w*C*j);
t=-0.005:0.0001:0.020;


A = [1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    -1/R1, 1/R1+1/R2, -1/R2, 0, 0, 0, 0, 0, 1/R3, 0, 0, 0, 0; ...
    0, 1/R2,-1/R2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; ...
    0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 0, 0, 0, 1/R5, -1/R5, 0, 0, 0, 0, -1, -1, 0; ...
    0, 0, 0, 0, 0, 0, -1/R7, 1/R7, 0, 0, 0, 0, 1; ...
    0, 0, 0, 0, 0, 0, 0, 0, -Kb, 0, 1, 0, 0; ...
    0, 0, 0, 0, 0, -1/Zc, 0, 1/Zc, 0, 0, 0, 1, 0; ...
    0, 0, 0, 1/R6, 0, 0, -1/R6, 0, 0, 0, 0, 0, -1; ...
    0, -1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;...
    0 , 0, 0, 0, -1, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -Kd;...
    1/R1,-1/R1,0, 1/R4,-1/R4,0, 0, 0, 0, 0, 0, 0, 1]
    
    
    

    
    
    
    
B = [AVS;0;0;0;0;0;0;0;0;0;0;0;0]
x = A\B;

PV1 = x(1)
PV2 = x(2)
PV3 = x(3)
PV4 = x(4)
PV5 = x(5)
PV6 = x(6)
PV7 = x(7)
PV8 = x(8)

save tab3.tex PV1 PV2 PV3 PV4 PV5 PV6 PV7 PV8 

%passo5


V6(t>=0)=x(6)*sin(w*t(t>=0))+Vx*exp(-t(t>=0)/tau);
Vs(t>=0)=sin(w*t(t>=0));
V6(t<0)=V6i;
Vs(t<0)=Vsi;
   
sol_total=figure() 
plot(t,Vs,t,V6)
xlabel ("time [s]");
ylabel ("V6 and Vs [V]");
print(sol_total, "soltotal.eps", "-depsc")
hold off
%passo6

f=logspace(-1,6,200);
V6=zeros(length(f),1)
V68=zeros(length(f),1)
phi=zeros(length(f), 1)
for(i=1:size(f,2))

w=2*pi*f(i);
Zc=1/(j*w*C);

A = [1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    -1/R1, 1/R1+1/R2, -1/R2, 0, 0, 0, 0, 0, 1/R3, 0, 0, 0, 0; ...
    0, 1/R2,-1/R2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0; ...
    0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 0, 0, 0, 1/R5, -1/R5, 0, 0, 0, 0, -1, -1, 0; ...
    0, 0, 0, 0, 0, 0, -1/R7, 1/R7, 0, 0, 0, 0, 1; ...
    0, 0, 0, 0, 0, 0, 0, 0, -Kb, 0, 1, 0, 0; ...
    0, 0, 0, 0, 0, -1/Zc, 0, 1/Zc, 0, 0, 0, 1, 0; ...
    0, 0, 0, 1/R6, 0, 0, -1/R6, 0, 0, 0, 0, 0, -1; ...
    0, -1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;...
    0 , 0, 0, 0, -1, 0, 0, 1, 0, 1, 0, 0, 0;...
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -Kd;...
    1/R1,-1/R1,0, 1/R4,-1/R4,0, 0, 0, 0, 0, 0, 0, 1;]
    
    
    

    
    
B = [AVS;0;0;0;0;0;0;0;0;0;0;0;0];
x = A\B;

V6(i) = abs(x(6));
V8(i) = abs(x(8));
V68(i)= abs(x(6)-x(8));
phi(i)= (angle(x(6)))*(180/pi);
phi2(i)=angle(x(6)-x(8))*(180/pi);

end

magresponse = figure();

semilogx(f,20*log10(V6),'r')
hold on
semilogx(f,20*log10(V68))
plot(f,20*log10(AVS),'g')

xlabel ("log(f)");
ylabel ("V6, V(6)-V(8), Vs");

print (magresponse, "mag.eps", "-depsc");
hold off

phaseresp = figure();

semilogx(f,phi,'r')
hold on
semilogx(f,phi2)


xlabel ("log(f)");
ylabel ("ph(V6), ph(V(6)-V(8))");

print (phaseresp, "phase.eps", "-depsc");

movefile('*.eps','../doc')
