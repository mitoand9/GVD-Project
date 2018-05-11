clear all

ay_ADAMS = xlsread('ay.xls');
ROLL_ADAMS = xlsread('roll.xls');
yawrate_ADAMS = xlsread('yawrate.xls');

load ay_VBOX_121
load yawRate_VBOX_121
load roll_VBOX_121
load Time_VBOX_121

figure(1)
plot(ay_ADAMS(1:length(Time),1),-ay_ADAMS(1:length(Time),2)*9.81,'k')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')

figure(2)
plot(yawrate_ADAMS(1:length(Time),1),yawrate_ADAMS(1:length(Time),2)*pi/180,'k')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')

figure(3)
plot(ROLL_ADAMS(1:length(Time),1),ROLL_ADAMS(1:length(Time),2)*pi/180,'k')
hold on
plot(Time,roll_angle(1,:),'m')
grid on
xlabel('Time (s)')
ylabel('\Phi (rad)')