clear all

ay_ADAMS_Mod1 = importdata('mod1_ay.tab');
yawrate_ADAMS_Mod1 = importdata('mod1_yawrate.tab');
ay_ADAMS_Mod2 = importdata('mod2_ay.tab');
yawrate_ADAMS_Mod2 = importdata('mod2_yawrate.tab');
ay_ADAMS_Mod3 = importdata('mod3_ay.tab');
yawrate_ADAMS_Mod3 = importdata('mod3_yawrate.tab');
ay_ADAMS_Mod4 = importdata('mod4_ay.tab');
yawrate_ADAMS_Mod4 = importdata('mod4_yawrate.tab');
ay_ADAMS_Mod5 = importdata('mod5_ay.tab');
yawrate_ADAMS_Mod5 = importdata('mod5_yawrate.tab');
ay_ADAMS_Mod6 = importdata('mod6_ay.tab');
yawrate_ADAMS_Mod6 = importdata('mod6_yawrate.tab');

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
subplot(2,1,1)
plot(ay_ADAMS_Mod1.data(:,1),-ay_ADAMS_Mod1.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod1)),ay_Model_Mod1,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('\lambda = 0.492 m')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod1.data(:,1),yawrate_ADAMS_Mod1.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod1)),yawrate_Model_Mod1*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')


figure(2)
subplot(2,1,1)
plot(ay_ADAMS_Mod2.data(:,1),-ay_ADAMS_Mod2.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod2)),ay_Model_Mod2,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('\lambda = 0.328 m')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod2.data(:,1),yawrate_ADAMS_Mod2.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod2)),yawrate_Model_Mod2*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')


figure(3)
subplot(2,1,1)
plot(ay_ADAMS_Mod3.data(:,1),-ay_ADAMS_Mod3.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod3)),ay_Model_Mod3,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('\lambda = 0.533 m')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod3.data(:,1),yawrate_ADAMS_Mod3.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod3)),yawrate_Model_Mod3*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')


figure(4)
subplot(2,1,1)
plot(ay_ADAMS_Mod4.data(:,1),-ay_ADAMS_Mod4.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod4)),ay_Model_Mod4,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('m = 1005 kg')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod4.data(:,1),yawrate_ADAMS_Mod4.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod4)),yawrate_Model_Mod4*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')


figure(5)
subplot(2,1,1)
plot(ay_ADAMS_Mod5.data(:,1),-ay_ADAMS_Mod5.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod5)),ay_Model_Mod5,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('m = 1148 kg')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod5.data(:,1),yawrate_ADAMS_Mod5.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod5)),yawrate_Model_Mod5*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')


figure(6)
subplot(2,1,1)
plot(ay_ADAMS_Mod6.data(:,1),-ay_ADAMS_Mod6.data(:,2)*9.81,'k')
hold on
plot(Time_Brush(1:length(ay_Model_Mod6)),ay_Model_Mod6,'b')
grid on
ylabel('a_y (m/s^2)')
legend('ADAMS','Brush')
title('m = 1722 kg')
subplot(2,1,2)
plot(yawrate_ADAMS_Mod6.data(:,1),yawrate_ADAMS_Mod6.data(:,2)*pi/180,'k')
hold on
plot(Time_Brush(1:length(yawrate_Model_Mod6)),yawrate_Model_Mod6*pi/180,'b')
grid on
xlabel('Time (s)')
ylabel('\psi (rad/s)')
legend('ADAMS','Brush')

% figure(2)
% plot(ay_ADAMS_Mod2.data(:,1),-ay_ADAMS_Mod2.data(:,2)*9.81,'k')
% hold on
% plot(Time_Brush(1:length(ay_Model_Mod2)),ay_Model_Mod2,'b')
% grid on
% xlabel('Time (s)')
% ylabel('a_y (m/s^2)')
% legend('ADAMS','Brush')
% title('\lambda = 0.328 m')
% 
% figure(3)
% plot(ay_ADAMS_Mod3.data(:,1),-ay_ADAMS_Mod3.data(:,2)*9.81,'k')
% hold on
% plot(Time_Brush(1:length(ay_Model_Mod3)),ay_Model_Mod3,'b')
% grid on
% xlabel('Time (s)')
% ylabel('a_y (m/s^2)')
% legend('ADAMS','Brush')
% title('\lambda = 0.533 m')
% 
% 
% 
% figure(4)
% plot(ay_ADAMS_Mod4.data(:,1),-ay_ADAMS_Mod4.data(:,2)*9.81,'k')
% hold on
% plot(Time_Brush(1:length(ay_Model_Mod4)),ay_Model_Mod4,'b')
% grid on
% xlabel('Time (s)')
% ylabel('a_y (m/s^2)')
% legend('ADAMS','Brush')
% title('m = 1005 kg')
% 
% figure(5)
% plot(ay_ADAMS_Mod5.data(:,1),-ay_ADAMS_Mod5.data(:,2)*9.81,'k')
% hold on
% plot(Time_Brush(1:length(ay_Model_Mod5)),ay_Model_Mod5,'b')
% grid on
% xlabel('Time (s)')
% ylabel('a_y (m/s^2)')
% legend('ADAMS','Brush')
% title('m = 1148 kg')
% 
% figure(6)
% plot(ay_ADAMS_Mod6.data(:,1),-ay_ADAMS_Mod6.data(:,2)*9.81,'k')
% hold on
% plot(Time_Brush(1:length(ay_Model_Mod6)),ay_Model_Mod6,'b')
% grid on
% xlabel('Time (s)')
% ylabel('a_y (m/s^2)')
% legend('ADAMS','Brush')
% title('m = 1722 kg')




% plot(ay_ADAMS_Mod4.data(:,1),-ay_ADAMS_Mod4.data(:,2)*9.81,'k')
% hold on
% plot(ay_ADAMS_Mod5.data(:,1),-ay_ADAMS_Mod5.data(:,2)*9.81,'k')
% hold on