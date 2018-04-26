function [xdot]=bicycle_model_partial(t,x)

global f b C12 C34 Jz m delta velocity delta_t file_time

vx=velocity;
% vx=sqrt(velocity^2-x(2)^2);
%----------------------------------------------------------------

if length(delta)==1 % for single value delta
    delta_t=delta;
else                % for vector delta
%     i=find(file_time>=t(end));%,1,'first');
%     delta_t=delta(i(1));
delta=-0.898;
end

xdot1=x(2); % vy-speed
xdot2=(1/m).*((-C34./vx).*(x(2)-x(4).*b)-((C12./vx).*(x(2)+x(4).*f-delta*vx)))-x(4)*vx; % vy-acceleration
xdot3=x(4); % Yaw rate angular velocity
xdot4=(1./Jz).*(-f.*C12./vx.*(x(2)+x(4).*f-delta.*vx)+b.*C34./vx.*(x(2)-x(4).*b)); % Yaw rate angular acceleration
xdot=[xdot1 xdot2 xdot3 xdot4]';
%----------------------------------------------------------------
