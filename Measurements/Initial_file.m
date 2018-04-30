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
vbox_file_name='LUNDA012.VBO'; 

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

% Taking away spikes in the data
for i=1:length(Time)
    if (i>1)
        if (abs(SWA_VBOX(i,1)-SWA_VBOX(i-1))>1 || abs(SWA_VBOX(i,1))>7)
            SWA_VBOX(i,1)=SWA_VBOX(i-1);
        end
    end
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

subplot(3,2,4)
plot(Time,ax_VBOX)
ylabel('ax')

subplot(3,2,5)
plot(Time,ay_VBOX)
ylabel('ay')

data_storage= [Time SWA_VBOX];

% Save to .mat-file
save('LUNDA012.mat','Time', 'yawRate_VBOX', 'vx_VBOX', 'ax_VBOX', 'ay_VBOX', 'SWA_VBOX')

% Save as ascii-file
dlmwrite('LUNDA012.asc',data_storage,'delimiter','\t')