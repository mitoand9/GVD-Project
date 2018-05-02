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

alpha12 = atan((x(2)+x(4)*f)/velocity)-delta_t;
alpha34 = atan((x(2)-x(4)*b)/velocity);
mubrush = 0.9;

%alpha34*180/pi

if strcmp(tyre_model,'Brush') == 1
    %disp('brush')
    lamb12 = m*g*(1-lambda)*mubrush/(2*C12*abs(tan(alpha12)));
    lamb34 = m*g*lambda*mubrush/(2*C34*abs(tan(alpha34)));
    
%     if lamb12 <= 1 || lamb34 <= 1
%         disp('BOOOOOOOOOOOOOOOOOOOOOOOM')
%     end

    if lamb12 <= 1
        %disp('bru-brush12')
        F12 = (-tan(alpha12)*m*g*(1-lambda)*mubrush/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
    else
        %disp('bru-lin12')
        F12 = -C12*tan(alpha12);
    end

    if lamb34 <= 1
        F34 = (-tan(alpha34)*m*g*(1-lambda)*mubrush/(2*abs(tan(alpha34))))*(2-m*g*(1-lambda)/(2*C34*abs(tan(alpha34))));
    else
        %disp('bru-brush34')
        F34 = -C34*tan(alpha34);
    end
else
    %disp('linear')
    F12 = -C12*alpha12;
    F34 = -C34*alpha34;
end

xdot1=x(2); % vy-speed
xdot2= (1/m)*(F34+F12); % vy-acceleration
xdot3=x(4); % Yaw rate angular velocity
xdot4= (1/Jz)*(f*F12-b*F34); % Yaw rate angular acceleration
xdot=[xdot1 xdot2 xdot3 xdot4]';

Fz = 
%----------------------------------------------------------------
