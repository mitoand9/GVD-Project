%----------------------------------------------------------------
% Template created by Jenny and Mikael 2016
%----------------------------------------------------------------
clear all;
close all;
clc;

%addpath('MeasurementsfromLund180424')
disp(' ');

% Set global variables so that they can be accessed from other matlab
% functions and files
global vbox_file_name

%----------------------------
% LOAD DATA FROM VBOX SYSTEM
%----------------------------

%vbox_file_name='logged_data/MeasurementsLunda2017/DLC__094.VBO'; 
vbox_file_name='LUNDA008.VBO'; 

vboload


%  Channel 1  = satellites
%  Channel 2  = time
%  Channel 3  = latitude
%  Channel 4  = longitude
%  Channel 5  = velocity kmh
%  Channel 6  = heading
%  Channel 7  = height
%  Channel 8  = vertical velocity kmh
%  Channel 9  = long accel g
%  Channel 10 = lat accel g
%  Channel 11 = swa
%  Channel 12 = correvx
%  Channel 13 = slipcorr
%  Channel 14 = glonass_sats
%  Channel 15 = gps_sats
%  Channel 16 = imu kalman filter status
%  Channel 17 = solution type
%  Channel 18 = velocity quality
%  Channel 19 = event 1 time
%  Channel 20 = RMS_HOPS
%  Channel 21 = RMS_VOPS
%  Channel 22 = RMS_HVEL
%  Channel 23 = RMS_VVEL
%  Channel 24 = latitude_raw
%  Channel 25 = longitude_raw
%  Channel 26 = speed_raw
%  Channel 27 = heading_raw
%  Channel 28 = height_raw
%  Channel 29 = vertical_velocity_raw 
%  Channel 30 = heading
%  Channel 31 = True heading
%  Channel 32 = slip_angle
%  Channel 33 = Lat. vel.
%  Channel 34 = roll_angle
%  Channel 35 = slip_COG
%  Channel 36 = YawRate
%  Channel 37 = x_accel
%  Channel 38 = y_accel
%  Channel 39 = temp
%  Channel 40 = pitchrate
%  Channel 41 = rollrate
%  Channel 42 = z_accel
%  Channel 43 = pitch_angle
%  Channel 44 = yaw_rate
%  Channel 45 = Lng. vel.
%  Channel 46 = HeadingRMS
%  Channel 47 = UTC
%  Channel 48 = True_Head2



g=9.81;             % Gravity constant (m/s^2)


%--------------------------------------------
% SET VARIABLES DATA FROM DATA READ FROM FILE
%--------------------------------------------
trim_start=1;
trim_end=length(vbo.channels(1, 2).data);

Time=(vbo.channels(1, 2).data(trim_start:trim_end,1) - vbo.channels(1, 2).data(1,1));
yawRate_VBOX = vbo.channels(1, 36).data(trim_start:trim_end,1).*(-pi/180); %signal is inverted hence (-)
vx_VBOX = vbo.channels(1, 5).data(trim_start:trim_end,1)./3.6;
ax_VBOX = vbo.channels(1, 9).data(trim_start:trim_end,1).*g;
ay_VBOX = vbo.channels(1, 10).data(trim_start:trim_end,1).*g;
SWA_VBOX=vbo.channels(1, 11).data(trim_start:trim_end,1).*(pi/180);
roll_angle=vbo.channels(1, 34).data(trim_start:trim_end,1).*(pi/180);
roll_rate=vbo.channels(1, 41).data(trim_start:trim_end,1).*(-pi/180);
vy_VBOX=vbo.channels(1, 33).data(trim_start:trim_end,1).*(pi/180);
slip_VBOX=vbo.channels(1, 32).data(trim_start:trim_end,1).*(pi/180);

% Taking away spikes in the data
for i=1:length(Time)
    if (i>1)
        if (abs(SWA_VBOX(i,1)-SWA_VBOX(i-1))>1 || abs(SWA_VBOX(i,1))>7)
            SWA_VBOX(i,1)=SWA_VBOX(i-1);
        end
    end
end
i0 = 322;
i1 = 2121; %length(Time)-1;

yawgain=1;yawoffset=0;
aygain=1; ayoffset=0;
rollgain=1; rolloffset= 0.0039;

Time = Time(i0:i1,1)-Time(i0,1);
SWA_VBOX = SWA_VBOX(i0:i1,1);
vx_VBOX = vx_VBOX(i0:i1,1);
yawRate_VBOX = yawRate_VBOX(i0:i1,1)*yawgain+yawoffset;
ay_VBOX = ay_VBOX(i0:i1,1)*aygain+ayoffset;
roll_rate = roll_rate(i0:i1,1)*rollgain+rolloffset;
ax_VBOX = ax_VBOX(i0:i1,1);
vy_VBOX = vy_VBOX(i0:i1,1);
slip_VBOX = slip_VBOX(i0:i1,1);

x=zeros(1,length(Time));x(1)=0;
y=zeros(1,length(Time));y(1)=0;
roll_angle=zeros(1,length(Time));roll_angle(1)=0;
yaw_angle=zeros(1,length(Time));yaw_angle(1)=0;

for i=2:length(Time)
dt=Time(i)-Time(i-1);
roll_angle(i)=roll_angle(i-1)+roll_rate(i)*dt;
yaw_angle(i)=yaw_angle(i-1)+yawRate_VBOX(i)*dt;
vy_VBOX(i)=vy_VBOX(i-1)+(ay_VBOX(i)-yawRate_VBOX(i)*vx_VBOX(i))*dt;
x(i)=x(i-1)+vy_VBOX(i)*sin(yaw_angle(i))*dt+vx_VBOX(i)*cos(yaw_angle(i))*dt;
y(i)=y(i-1)+vy_VBOX(i)*cos(yaw_angle(i))*dt+vx_VBOX(i)*sin(yaw_angle(i))*dt;
end

subplot(3,2,1)
plot(Time,SWA_VBOX)
ylabel('SWA')

subplot(3,2,2)
plot(Time,vx_VBOX)
ylabel('vx')

subplot(3,2,3)
plot(Time,yawRate_VBOX)
ylabel('yawrate')

% subplot(3,2,4)
% plot(Time,ax_VBOX)
% ylabel('ax')

subplot(3,2,5)
plot(Time,ay_VBOX)
ylabel('ay')

% 
% figure(1)
% plot(Time,roll_angle*180/pi)
% grid on
% ylabel('roll angle')
% 
% 
% figure(2)
% plot(Time,yawRate_VBOX*180/pi)
% grid on
% ylabel('yaw RATE')
% 
% figure(3)
% plot(Time,-ay_VBOX./9.81)
% grid on
% ylabel('ay')



data_storage=[Time SWA_VBOX];

% Save to .mat-file
save('LUNDA008.mat','Time', 'yawRate_VBOX', 'vx_VBOX', 'ax_VBOX', 'ay_VBOX', 'SWA_VBOX')

% Save as ascii-file
dlmwrite('LUNDA008.asc',data_storage,'delimiter','\t')