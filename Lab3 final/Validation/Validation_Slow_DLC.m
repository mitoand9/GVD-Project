clear all

ay_ADAMS = importdata('DLC008_ay.tab');
yawrate_ADAMS = importdata('DLC008_yawrate.tab');

load ay_Linear_Validated_DLC008
load yawrate_Linear_Validated_DLC008
load Time_Linear_DLC008
load ay_Brush_Validated_DLC008
load yawrate_Brush_Validated_DLC008
load Time_Brush_DLC008

load ay_VBOX_DLC008
load yawRate_VBOX_DLC008
load Time_VBOX_DLC008

figure(1)
plot(ay_ADAMS.data(1:length(Time),1),-ay_ADAMS.data(1:length(Time),2)*9.81,'k')
hold on
plot(Time_Linear_DLC008(1:length(ay_Linear_Validated_DLC008)),ay_Linear_Validated_DLC008,'b')
hold on
plot(Time_Brush_DLC008(1:length(ay_Brush_Validated_DLC008)),ay_Brush_Validated_DLC008,'g')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')
legend('ADAMS','Linear','Brush','VBOX')

figure(2)
plot(yawrate_ADAMS.data(1:length(Time),1),yawrate_ADAMS.data(1:length(Time),2)*pi/180,'k')
hold on
plot(Time_Linear_DLC008(1:length(Time)),yawrate_Linear_Validated_DLC008(1:length(Time))*pi/180,'b')
hold on
plot(Time_Brush_DLC008(1:length(Time)),yawrate_Brush_Validated_DLC008(1:length(Time))*pi/180,'g')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')
legend('ADAMS','Linear','Brush','VBOX')