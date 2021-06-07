%T5
f=logspace(1,8,200);

Vcc=5;
Vee=-5;
w=2*pi*f;
s=j*w;
R1=1000;
R2=1000;
R3=1000;
R4=100000;
C1=220e-9;
C2=99e-9;


sc = 2*pi*1000*j
%Gain
Gain=20*log10(abs((R1/((1/(sc*C1))+R1))*(1+R4/R3)*(1/(1+R2*sc*C2))))

%frequency response
for(i=1:size(f,2))
H(i)=20*log10(abs((R1/((1/(s(i)*C1))+R1))*(1+R4/R3)*(1/(1+R2*s(i)*C2))));
P(i)= 180/pi*angle((R1/((1/(s(i)*C1))+R1))*(1+R4/R3)*(1/(1+R2*s(i)*C2)));
end

fr=figure() 
semilogx(f,H)
xlabel ("Frequency(Hz)");
ylabel ("Gain(dB)");
print(fr, "fr.eps", "-depsc")

fphase=figure()
semilogx(f,P)
xlabel ("Frequency(Hz)");
ylabel ("Phase (º)");
print(fphase, "fphase.eps", "-depsc")


fL=1/(2*pi*R1*C1)
fH=1/(2*pi*R2*C2)
centralf=sqrt(fL*fH)

inpimp=((1/(j*2*pi*1000*C1))+R1)


outimp=1/((1/R2)+j*2*pi*1000*C2)

save tab1.tex centralf Gain inpimp outimp

movefile('*.eps', '../doc')
