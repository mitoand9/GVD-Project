clear all

% ay_ADAMS = xlsread('ay.xls');
% ROLL_ADAMS = xlsread('roll.xls');
% yawrate_ADAMS = xlsread('yawrate.xls');

ay_ADAMS = importdata('tuned-ay.tab');
ROLL_ADAMS = importdata('tuned-roll.tab');
yawrate_ADAMS = importdata('tuned-yaw.tab');

load ay_Linear_Validated
load yawrate_Linear_Validated
load Time_Linear
load ay_Brush_Validated
load yawrate_Brush_Validated
load Time_Brush

load ay_VBOX_121
load yawRate_VBOX_121
load roll_VBOX_121
load Time_VBOX_121

figure(1)
plot(ay_ADAMS.data(1:length(Time),1),-ay_ADAMS.data(1:length(Time),2)*9.81,'k')
hold on
plot(Time_Linear(1:length(ay_Linear_Validated)),ay_Linear_Validated,'b')
hold on
plot(Time_Brush(1:length(ay_Brush_Validated)),ay_Brush_Validated,'g')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')
legend('ADAMS','Linear','Brush','VBOX')

figure(2)
plot(yawrate_ADAMS.data(1:length(Time),1),yawrate_ADAMS.data(1:length(Time),2)*pi/180,'k')
hold on
plot(Time_Linear(1:length(yawrate_Linear_Validated)),yawrate_Linear_Validated*pi/180,'b')
hold on
plot(Time_Brush(1:length(yawrate_Brush_Validated)),yawrate_Brush_Validated*pi/180,'g')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')
legend('ADAMS','Linear','Brush','VBOX')

figure(3)
plot(ROLL_ADAMS.data(1:length(Time),1),ROLL_ADAMS.data(1:length(Time),2)*pi/180,'k')
hold on
plot(Time,roll_angle(1,:),'m')
grid on
xlabel('Time (s)')
ylabel('\Phi (rad)')
legend('ADAMS','VBOX')