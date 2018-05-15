clear all

ay_ADAMS = importdata('ay_fast.tab');
ROLL_ADAMS = importdata('roll_fast.tab');
yawrate_ADAMS = importdata('yawrate_fast.tab');

load ay_Linear_Validated_Fast
load yawrate_Linear_Validated_Fast
load Time_Linear_Fast
load ay_Brush_Validated_Fast
load yawrate_Brush_Validated_Fast
load Time_Brush_Fast

load ay_VBOX_131
load yawRate_VBOX_131
load roll_VBOX_131
load Time_VBOX_131

figure(1)
plot(ay_ADAMS.data(1:length(Time)-2,1)+Time(1,1),-ay_ADAMS.data(1:length(Time)-2,2)*9.81,'k')
hold on
plot(Time_Linear_Fast(497:length(ay_Linear_Validated_Fast)),ay_Linear_Validated_Fast(497:end),'b')
hold on
plot(Time_Brush_Fast(497:length(ay_Brush_Validated_Fast)),ay_Brush_Validated_Fast(497:end),'g')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')
legend('ADAMS','Linear','Brush','VBOX')

figure(2)
plot(yawrate_ADAMS.data(1:length(Time)-2,1)+Time(1,1),yawrate_ADAMS.data(1:length(Time)-2,2)*pi/180,'k')
hold on
plot(Time_Linear_Fast(497:length(yawrate_Linear_Validated_Fast)),yawrate_Linear_Validated_Fast(497:end)*pi/180,'b')
hold on
plot(Time_Brush_Fast(497:length(yawrate_Brush_Validated_Fast)),yawrate_Brush_Validated_Fast(497:end)*pi/180,'g')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')
legend('ADAMS','Linear','Brush','VBOX')

figure(3)
plot(ROLL_ADAMS.data(1:length(Time)-2,1)+Time(1,1),ROLL_ADAMS.data(1:length(Time)-2,2)*pi/180,'k')
hold on
plot(Time,roll_angle(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Phi (rad)')
legend('ADAMS','VBOX')