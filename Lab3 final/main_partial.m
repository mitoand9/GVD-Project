% Main program 
% Single track model with animation funtion call.
% /Johannes Edrén
% /edit by Daniel Wanner 2011-03-09
clear all
close all
clc
 
load ay_VBOX_121
load vy_VBOX_121
load yawRate_VBOX_121
load slip_VBOX_121
load SWA_VBOX_121

global m Jz L lambda f b C12 C34 is velocity delta file_time g tyre_model cgh F1 F2 F3 F4 tw %delta_t 

% Vehicle parameters
%------------------------------------------------------
m=1435;
Jz=2380;
L=2.55;
lambda=0.41;
f=lambda*L;
b=(1-lambda)*L;
C12=90e3; %N/rad % Brush = Linear = 65e3
C34=100e3; % Brush = Linear = 90e3
is=16.5;
g = 9.81;
cgh = 0.2*L; %cg height
tw = 1.46; %track width

F1 = 1;
F2 = 1;
F3 = 1;
F4 = 1;

tyre_model = "Brush"; % Select between Linear or Brush

% Intitial condition and time
%-------------------------------------------------------
velocity=13;          % speed [m/s]
tstop=10 ;           % stop-time
dt=0.02;            % timestep
time=0:dt:tstop;    % time vector (fixed time step)

% Steering input
%-------------------------------------------------------

% -- open loop constant value (STEP 1 & 3) --
% delta_sw=30;          % constant steering wheel angle [deg]
% delta_ss=delta_sw/is*pi/180;
% delta=delta_ss; % use one steering angle only
% time_delta=time;

%-- from file (STEP 2) --

% file_data=read_ascii('DLC_50_english.ASC'); %change name also in the read_ascii.mat!
% file_time=file_data(:,1);
% file_delta_sw=file_data(:,8);
% file_delta=file_delta_sw/is;
% delta=file_delta;
% time_delta=file_time;

file_data=read_ascii('Testdata2011_Ramp.ASC');
file_time=file_data(:,1);
file_delta_sw=file_data(:,8);
file_delta=file_delta_sw/is;
delta=file_delta;
time_delta=file_time;
file_ay = file_data(:,7);
file_SA34 = file_data(:,10);
file_psidot = file_data(:,2);
file_vx = file_data(:,9);

% file_data = dlmread('LUNDA121.asc');
% file_time=file_data(:,1);
% file_delta_sw=file_data(:,2);
% file_delta=file_delta_sw/is;
% delta=file_delta;
% time_delta=file_time;

% Solve equations of motion
%------------------------------------------------------
x0=[0 0 0 0];       % initial condition
size(delta)
% Change "time" to "tstop" for variable time step.
%[timeout, xout]=ode45('bicycle_model_partial',time,x0);
[timeout, xout]=ode45('bicycle_model_partial',time_delta,x0);

% Identify variables from simulation results
%------------------------------------------------------
vy=xout(:,2);
psi=xout(:,3);
psi_p=xout(:,4);

% calculate vy_p:
vy_p=0; %xout(:,2)

% Analytical expressions (for validation) (STEP 1)
%-------------------------------------------------------
vx=velocity;
vy_ss=(vx.*delta.*(b*C12*C34*L-f*C12*m*vx.^2))./(L^2*C12*C34+m*vx.^2.*(b*C34-f*C12));
psi_p_ss=(delta*L*C12*C34*vx)./(L^2*C12*C34+m*vx^2.*(b*C34-f*C12));

%Calculations of global position out of local (STEP 3)
% Vx_Global=vx.*cos(psi)-vy_p.*sin(psi_p);
% Vy_Global=vx.*cos(psi)+vy_p.*sin(psi_p);
%--------------------------------------------------------------------------
% x=0;y=0;
% for i=1:length(timeout)-1
%     dt(i)=timeout(i+1)-timeout(i);
%     vx=sqrt(velocity^2-vy(i)^2);
%     y(i+1)=y(i)+(vx.*sin(psi(i))+vy(i).*cos(psi(i))).*dt(i);
%     x(i+1)=x(i)+(vx.*cos(psi(i))-vy(i).*sin(psi(i))).*dt(i);
% end

% STEP 1 presentation: Plot verification using open loop steering
%--------------------------------------------------------------------------
% if length(delta)==1,figure
%     subplot(3,1,1)
%     vx=sqrt(velocity^2-vy.^2); % only used to get the right lateral acceleration
%     plot(timeout(1:end),vy_p+vx(1:end).*psi_p(1:end),'b'),hold on,grid on
%     title('Simulation with open loop steering')
%     ylabel('ay [m/s^2]');
%     xlabel('time [s]')
%     legend('a_y')
%     subplot(3,1,2)
%     plot(timeout,vy,'b',[timeout(1) timeout(end)],[vy_ss vy_ss],'g--')
%     grid on
%     ylabel('v_y [m/s]');
%     xlabel('time [s]')
%     legend('simulation','calculation')
%     subplot(3,1,3)
%     plot(timeout,psi_p*180/pi,'b',[timeout(1) timeout(end)],[psi_p_ss psi_p_ss]*180/pi,'g--')
%     grid on
%     ylabel('\Psi\prime [deg/s]');
%     xlabel('time [s]')
%     legend('simulation','calculation')
% end

%% to be used for ay etc. plots

% STEP 2 presentation: Plot simulation from sampled data
%--------------------------------------------------------------------------
if length(delta)~=1, figure
    subplot(3,1,1)
    %plot(timeout,vx.*psi_p,'b');
    vx=sqrt(velocity^2-vy.^2);
    i_end=find(time_delta>=timeout(end-1),1,'first');
    %plot(timeout,ay_VBOX,'m'),hold on,grid on %only use for 121
    %plot(time_delta(1:i_end),delta(1:i_end)*180/pi,'g'),hold on,grid on 
    %plot(timeout,file_data(:,7),'r'),hold on,grid on % only use for DLC
    plot(timeout(1:end-1),vy_p+vx(1:end-1).*psi_p(1:end-1),'b'),hold on,grid on % plot model-based ay
    plot(time_delta(1:i_end),file_ay(1:i_end)),grid on; % VBOX data - ramp steer
    title('Simulation from sampled steering wheel angle')
    ylabel('ay [m/s^2]');
    xlabel('time [s]')
    %legend('ay_VBOX','a_y model') %change accordingly if you want

    subplot(3,1,2)
    % plot(timeout,vy_ss,'g'),hold on,grid on % steady-state vy
    %plot(timeout,-vy_VBOX,'m'),hold on,grid on %only use for 121
    plot(timeout,vy,'b'),grid on
    ylabel('v_y [m/s]');
    xlabel('time [s]')

    subplot(3,1,3)
    %plot(timeout,yawRate_VBOX*180/pi,'m'),hold on,grid on %only use for 121
    plot(timeout,psi_p*180/pi,'b'),grid on
    ylabel('\Psi\prime [deg/s]');
    xlabel('time [s]')
    
%     subplot(4,1,4)
%     plot(file_SA34(1:i_end),file_ay(1:i_end)*m*f/L,'o'),hold on, grid on
%     %plot(atan((vy(1:end-1)-psi_p(1:end-1)*b)./vx(1:end-1)),(vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L,'o'),grid on;
%     plot(-((vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L)/C34,(vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L,'o','Linewidth',3),grid on;
%     ylabel('F34 [N]');
%     xlabel('SA [rad]')
end

%% F vs SA plots - only use with ramp steer


if length(delta)~=1, figure
    vx=sqrt(velocity^2-vy.^2);
    i_end=find(time_delta>=timeout(end-1),1,'first');
    
    figure()
    plot((file_SA34(1:i_end)-0.02)*180/pi,file_ay(1:i_end)*m*f/L,'o'),hold on, grid on %measured later force for ramp
    %plot(slip_VBOX*180/pi,ay_VBOX*m*f/L,'o'),hold on, grid on %measured later force for 121
    plot(atan((vy(1:end-1)-psi_p(1:end-1)*b)./vx(1:end-1))*180/pi,(vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L,'o'),grid on; % bicycle model lateral force with non-working slip angles
    %plot(-(((vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L)/C34)*180/pi+1.1,(vy_p+vx(1:end-1).*psi_p(1:end-1))*m*f/L,'o','Linewidth',3),grid on; %C34 slip angles
    ylabel('F34 (N)');
    xlabel('SA (deg)')
    legend('Measurement','Model')
    hold on
    
    figure()
    plot(((file_SA34(1:i_end)-0.02)+(file_psidot(1:i_end)*L./file_vx(1:i_end))-file_delta(1:i_end))*180/pi , file_ay(1:i_end)*m*b/L,'o'),hold on, grid on
    plot((atan((vy(1:end-1)+psi_p(1:end-1)*f)./vx(1:end-1))-file_delta(1:end-1))*180/pi , (vy_p+vx(1:end-1).*psi_p(1:end-1))*m*b/L,'o'),grid on;
    ylabel('F12 (N)');
    xlabel('SA (deg)')
    legend('Measurement','Model')
        
end

%% don't use this

% STEP 3 presentation: Plot vehicle position using open loop steering
%--------------------------------------------------------------------------
% if length(delta)==1,figure
%     % Plot the vehicle path in X-Y figure 
%     figure, plot(x,y), grid on, axis equal
%     title('Vehicle path')
%     ylabel('X [m]');
%     xlabel('Y [m]')
% end

% STEP 3 (animation): Animation of open loop stering
%--------------------------------------------------------------------------
% openloop_animation=0;    % change to 1 if animation is to be shown
% 
% if length(delta)==1 && openloop_animation==1
%     delta_plot=ones(1,length(timeout))*delta_ss;
%     tic;
%     for i=1:length(timeout)-1
%         plot_vehicle(psi(i),x,y,delta_plot(i),L,f,lambda,10,3,i,timeout);
%         drawnow
%         del(i)=dt(i)-toc;
%         pause(del(i));
%         tic;
%     end
% end