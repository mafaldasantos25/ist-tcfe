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


A = [R4+R3+R1, -R3, -R4; -R4, 0, R6+R7-Kc+R4; -Kb*R3, Kb*R3-1, 0];
B = [-Va; 0; 0];
x = A\B;

Ia = x(1)
Ib = x(2)
Ic = x(3)
Id

Vb = R3 * (Ib - Ia)

Vc = Kc * Ic

save malhas.tex Ia Ib Ic Id Vb Vc
