%% Variable initialization
kn = 175 * 10^(-6);
kp = 60 * 10^(-6);

lp = 0.15;
ln = 0.05;

vin_min = - 100 * 10^(-3);
vin_max = 100 * 10^(-3);

vdd = 1.854;
vss = -1.854;

vtn = 0.5; 
vtp = -0.6;
vtn_max = vtn + 0.15;
vtn_min = vtn - 0.15;
vtp_max = vtp + 0.15;
vtp_min = vtn - 0.15;

Cox = 2.47 * 10 ^ (-3); 

l = 1 * 10^(-6);
gb = 7.18 * 10^6;
%% Miller Capacitance Cc
cl = 2.18 * 10^(-12);
cc = 0.22 * cl;
disp("Cc > " + cc);
cc = round(10^13*cc)/10^13; 
disp("We choose to round up Cc to " + cc);

%% Slew Rate and I reference
sr = 18.18 * 10^6;
disp("SR >=  " + sr);
i5 = sr * cc;
disp("I5 >= " + i5);
i5 = (fix(i5 * 10^6) + 1) * 10^(-6);       
disp("Ι5 = " + i5);
%% S3 and s4
s3 = i5/(kn*(vin_min - vss - vtn_max + abs(vtp_min))^2);
if s3 < 1
     s3 = 1;
end
disp("s3 = s4 = " + s3);
s4 = s3;
w3 = s3 * l;
w4 = s4 * l;
%% p3 
p3 = (sqrt(2 * kn * (w3/l) * (i5/2))) / (2 * 0.667 * w3 * l * Cox);
disp("p3 = "+ p3 + " rad/s");
disp("p3 = "+ p3 * 0.1592 * 10 ^ (-6) + " MHz");
if p3*0.1592*10^(-6) > 10*gb*10^(-6)
     disp("p3 > 71.8 MHz");
end
%% s1 and s2
gm1 = gb * 2 * 3.14 * cc;
disp("gm1 = "+ gm1);
s1 = gm1 ^ 2 / (kp * i5);
if s1 < 1
     s1 = 1;
end
disp("s1 = s2 = " + s1);
s2 = s1;
w1 = s1 * l;
w2 = s2 * l;
 %% s5
vds5 = vin_min - vss - sqrt(i5/(kp*s1)) - vtp;
s5 = 2*(i5/(kp*vds5^2));
if s5 < 1
    s5 = 1;
end
disp("s5 = " + s5);
w5 = s5 * l;
 
%% s6
gm6 = 10*gm1;
disp("gm6 = " + gm6 + "μS");
gm4 = sqrt(2*kn*s4*(i5/2));
s6 = fix(s4 * (gm6/gm4)) + 1;
i6 = gm6^2/(2 * kn * s6);
disp("gm4 = " + gm4 + "μS");
disp("s6 = " + s6);
disp("i6 = " + i6 + " A");
w6 = s6 * l;
%% s7
s7 = fix((i6/i5) * s5) + 1;
disp("s7 = " + s7);
w7 = s7 * l;
%% A
gm2 = gm1;
A = (2 * gm2 * gm6) / (i5 * i6 * (lp+ln) ^ 2);
disp("A = " + A + " V/V");
 
%% Pdiss
Pdiss = (i5 + i6)*(vdd + abs(vss));
disp("Pdiss = " + Pdiss * 1000 +" mW");
% 
%% prints all W
disp("W1 = " + w1/10^(-6) + "μm");
disp("W2 = " + w2/10^(-6) + "μm");
disp("W3 = " + w3/10^(-6) + "μm");
disp("W4 = " + w4/10^(-6) + "μm");
disp("W5 = " + w5/10^(-6) + "μm");
disp("W6 = " + w6/10^(-6) + "μm");
disp("W7 = " + w7/10^(-6) + "μm");
