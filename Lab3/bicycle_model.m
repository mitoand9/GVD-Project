function xdot=bicycle_model(t,x)

global delta_t velocity tstop delta mass L b C12 C34 f Jz

vx=velocity;
% vx=sqrt(velocity^2-x(2)^2);
%----------------------------------------------------------------

if length(delta)==1 % for single value delta
    delta_t=delta;
else                % for vector delta
    delta_t=6789
end

xdot(1,:)=x(2); %delta*(velocity*(b*L*C12*C34-f*C12*mass*(velocity^2)))/((L^2)*C12*C34+(mass*velocity^2*(b*C34-f*C12))); % y-speed
xdot(2,:)=(((-C34*(x(2)-x(4)*b)/vx)-(C12*(((x(2)+x(4)*f)/vx)-delta_t)))/mass)-(x(4)*vx); % y-acceleration
xdot(3,:)=x(4);%delta*(velocity*L*C12*C34)/((L^2)*C12*C34+(mass*velocity^2*(b*C34-f*C12))); % Yaw rate angular velocity
xdot(4,:)=(((C34*(x(2)-x(4)*b)/vx)*b)-((C12*(((x(2)+x(4)*f)/vx)-delta_t)*f)))/Jz; % Yaw rate angular acceleration

%----------------------------------------------------------------
end