clear all

ay_ADAMS_mod1 = xlsread('modified1_ay.xls');
yawrate_ADAMS_mod1 = xlsread('modified1_yawrate.xls');

load ay_Model_Mod1
load yawrate_Model_Mod1
load ay_Model_Mod2
load yawrate_Model_Mod2
load ay_Model_Mod3
load yawrate_Model_Mod3
load ay_Model_Mod4
load yawrate_Model_Mod4
load ay_Model_Mod5
load yawrate_Model_Mod5
load ay_Model_Mod6
load yawrate_Model_Mod6
load Time_Brush


figure(1)
plot(ay_ADAMS_mod1(1:length(Time),1),-ay_ADAMS(1:length(Time),2)*9.81,'k')
hold on

plot(Time_Brush(1:length(ay_Model_Mod1)),ay_Model_Mod1,'b')
grid on

xlabel('Time (s)')
ylabel('a_y (m/s^2)')