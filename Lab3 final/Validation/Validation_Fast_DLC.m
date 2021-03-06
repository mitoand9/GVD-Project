clear all

ay_ADAMS = importdata('DLC011_ay.tab');
yawrate_ADAMS = importdata('DLC011_yaw.tab');

load ay_Linear_Validated_DLC011
load yawrate_Linear_Validated_DLC011
load Time_Linear_DLC011
load ay_Brush_Validated_DLC011
load yawrate_Brush_Validated_DLC011
load Time_Brush_DLC011

load ay_VBOX_DLC011
load yawRate_VBOX_DLC011
load Time_VBOX_DLC011

figure(1)
plot(ay_ADAMS.data(100:669,1)-0.99,-ay_ADAMS.data(100:669,2)*9.81,'k')
hold on
plot(Time_Linear_DLC011(1:length(ay_Linear_Validated_DLC011)),ay_Linear_Validated_DLC011,'b')
hold on
plot(Time_Brush_DLC011(1:length(ay_Brush_Validated_DLC011)),ay_Brush_Validated_DLC011,'g')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')
legend('ADAMS','Linear','Brush','VBOX')

figure(2)
plot(yawrate_ADAMS.data(100:669,1)-0.99,yawrate_ADAMS.data(100:669,2)*pi/180,'k')
hold on
plot(Time_Linear_DLC011(1:length(yawrate_Linear_Validated_DLC011)),yawrate_Linear_Validated_DLC011*pi/180,'b')
hold on
plot(Time_Brush_DLC011(1:length(yawrate_Brush_Validated_DLC011)),yawrate_Brush_Validated_DLC011*pi/180,'g')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')
legend('ADAMS','Linear','Brush','VBOX')