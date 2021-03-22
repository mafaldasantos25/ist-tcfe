close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic


R1 = 1.01787737043e03;
R2 = 2.04571952501e03;
R3 = 3.05375801147e03;
R4 = 4.04666279155e03;
R5 = 3.06704055629e03;
R6 = 2.03801057346e03;
R7 = 1.01955463161e03;
Va = 5.12775921163;
Id = 1.02526488404e-03; 
Kb = 7.01231226489e-03;
Kc = 8.06614086819e03;


G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;

V3 = -Va;

A = [-G1-G3-G2, G2, G3, 0, 0, 0; ...
G2+Kb, -G2, -Kb, 0, 0, 0;...
 -Kb, 0, Kb+G5, -G5, 0, 0;...
 0, 0, 0, 0, -G6-G7, G7;...
 0, 0, 1, 0, Kc*G6, -1;...
 G3, 0, -G3-G4-G5, G5, G7, -G7];
 
 

B = [0; 0; -Id; (-V3)*G6; Kc*V3*G6; Id-V3*G4];

x = A\B;

V0 = 0
V1 = x(1)
V2 = x(2)
V3 = -Va
V4 = x(3)
V5 = x(4)
V6 = x(5)
V7 = x(6)
Vb = V1-V4
Vc = V4-V7
Ib = Kb*Vb

save nos.tex V0 V1 V2 V3 V4 V5 V6 V7 Vb Vc Ib
