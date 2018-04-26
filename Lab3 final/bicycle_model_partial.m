function [xdot]=bicycle_model_partial(t,x)

global f b C12 C34 g lambda Jz m delta velocity delta_t tyre_model file_time

vx=velocity;
% vx=sqrt(velocity^2-x(2)^2);
%----------------------------------------------------------------

if length(delta)==1 % for single value delta
    delta_t=delta;
else                % for vector delta
    i=find(file_time>=t(end));%,1,'first');
    delta_t=delta(i(1));
% delta=-0.898;
end

alpha_12 = ((x(2)+x(4)*f)/velocity)-delta_t;
alpha_34 = ((x(2)-x(4)*b)/velocity);


if strcmp(tyre_model,'Brush') == 1
    lamb_12 = m*g*(1-lambda)*0.8/(2*C12*abs(tan(alpha_12)));
    lamb_34 = m*g*lambda*0.8/(2*C34*abs(tan(alpha_34)));

    if lamb_12 <= 1
        F_12 = (-tan(alpha_12)*m*g*(1-lambda)*0.8/(2*abs(tan(alpha_12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha_12))));
    else
        F_12 = -C12*tan(alpha_12);
    end

    if lamb_34 <= 1
        F_34 = (-tan(alpha_34)*m*g*(1-lambda)*0.8/(2*abs(tan(alpha_34))))*(2-m*g*(1-lambda)/(2*C34*abs(tan(alpha_34))));
    else
        F_34 = -C34*tan(alpha_34);
    end
else
    F_12 = -C12*alpha_12;
    F_34 = -C34*alpha_34;
end

xdot1=x(2); % vy-speed
xdot2= (1/m)*(F_34+F_12); % vy-acceleration
xdot3=x(4); % Yaw rate angular velocity
xdot4= (1/Jz)*(f*F_12-b*F_34); % Yaw rate angular acceleration
xdot=[xdot1 xdot2 xdot3 xdot4]';
%----------------------------------------------------------------
