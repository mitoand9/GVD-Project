clear all

ay_ADAMS = importdata('untuned-ay.tab');
ROLL_ADAMS = importdata('untuned-roll.tab');
yawrate_ADAMS = importdata('untuned-yaw.tab');

ay_ADAMS_2 = importdata('tuned-ay.tab');
ROLL_ADAMS_2 = importdata('tuned-roll.tab');
yawrate_ADAMS_2 = importdata('tuned-yaw.tab');

load ay_VBOX_121
load yawRate_VBOX_121
load roll_VBOX_121
load Time_VBOX_121


figure(1)
plot(ay_ADAMS.data(1:length(Time),1),-ay_ADAMS.data(1:length(Time),2)*9.81,'k')
hold on
plot(ay_ADAMS_2.data(1:length(Time),1),-ay_ADAMS_2.data(1:length(Time),2)*9.81,'g')
hold on
plot(Time,ay_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('a_y (m/s^2)')
legend('ADAMS Untuned','ADAMS Tuned','VBOX')

figure(2)
plot(yawrate_ADAMS.data(1:length(Time),1),yawrate_ADAMS.data(1:length(Time),2)*pi/180,'k')
hold on
plot(yawrate_ADAMS_2.data(1:length(Time),1),yawrate_ADAMS_2.data(1:length(Time),2)*pi/180,'g')
hold on
plot(Time,yawRate_VBOX(:,1),'m')
grid on
xlabel('Time (s)')
ylabel('\Psi (rad/s)')
legend('ADAMS Untuned','ADAMS Tuned','VBOX')

figure(3)
plot(ROLL_ADAMS.data(1:length(Time),1),ROLL_ADAMS.data(1:length(Time),2)*pi/180,'k')
hold on
plot(ROLL_ADAMS_2.data(1:length(Time),1),ROLL_ADAMS_2.data(1:length(Time),2)*pi/180,'g')
hold on
plot(Time,roll_angle(1,:)*0.8,'m')
grid on
xlabel('Time (s)')
ylabel('\Phi (rad)')
legend('ADAMS Untuned','ADAMS Tuned','VBOX')
