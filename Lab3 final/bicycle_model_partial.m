function [xdot]=bicycle_model_partial(t,x)

global L f b C12 C34 g lambda Jz m delta velocity delta_t tyre_model file_time cgh tw F1 F2 F3 F4

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

SC1 = 0; %steering calibrations
SC2 = 1;

alpha12 = atan((x(2)+x(4)*f)/velocity)-(delta_t+SC1)*SC2;
alpha34 = atan((x(2)-x(4)*b)/velocity);

mubrush = 1.3;

%alpha34*180/pi

%% brush model - no load transfer

% if strcmp(tyre_model,'Brush') == 1
%     %disp('brush')
%     lamb12 = m*g*(1-lambda)*mubrush/(2*C12*abs(tan(alpha12)));
%     lamb34 = m*g*lambda*mubrush/(2*C34*abs(tan(alpha34)));
%     
% %     if lamb12 <= 1 || lamb34 <= 1
% %         disp('BOOOOOOOOOOOOOOOOOOOOOOOM')
% %     end
% 
%     if lamb12 <= 1
%         %disp('bru-brush12')
%         F12 = -C12*tan(alpha12)*lamb12*(2-lamb12); %(-tan(alpha12)*m*g*(1-lambda)*mubrushbrush/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
%     else
%         %disp('bru-lin12')
%         F12 = -C12*tan(alpha12);
%     end
% 
%     if lamb34 <= 1
%         F34 = -C34*tan(alpha34)*lamb34*(2-lamb34); %(-tan(alpha34)*m*g*lambda*mubrushbrush/(2*abs(tan(alpha34))))*(2-m*g*lambda/(2*C34*abs(tan(alpha34))));
%     else
%         %disp('bru-brush34')
%         F34 = -C34*tan(alpha34);
%     end
%     
% else
%     F12 = -C12*alpha12;
%     F34 = -C34*alpha34;
% end

%% brush model - load transfer

deltaFf = m*(((F1 + F2)*cos((delta_t+SC1)*SC2)+(F3 + F4))/m)*b*cgh/(tw*L);
deltaFr = m*(((F1 + F2)*cos((delta_t+SC1)*SC2)+(F3 + F4))/m)*f*cgh/(tw*L);

Fz1 = m*g*(1-lambda)/2+deltaFf;
Fz2 = m*g*(1-lambda)/2-deltaFf;
Fz3 = m*g*lambda/2+deltaFr;
Fz4 = m*g*lambda/2-deltaFr;

if strcmp(tyre_model,'Brush') == 1
    lamb1 = Fz1*mubrush/(2*C12*abs(tan(alpha12))); %doesn't matter which cg has +/- deltaF, since in tcghe final formubrushla the forces on the same axle will be added
    lamb2 = Fz2*mubrush/(2*C12*abs(tan(alpha12)));
    lamb3 = Fz3*mubrush/(2*C34*abs(tan(alpha34)));
    lamb4 = Fz4*mubrush/(2*C34*abs(tan(alpha34)));

    if lamb1 <= 1
        F1 = (-C12/2)*tan(alpha12)*lamb1*(2-lamb1);
    else
        F1 = -(C12/2)*tan(alpha12);
    end
    if lamb2 <= 1
        F2 = (-C12/2)*tan(alpha12)*lamb2*(2-lamb2);
    else
        F2 = -(C12/2)*tan(alpha12);
    end
    if lamb3 <= 1
        F3 = (-C34/2)*tan(alpha34)*lamb3*(2-lamb3);
    else
        F3 = -(C34/2)*tan(alpha34);
    end
    if lamb4 <= 1
        F4 = (-C34/2)*tan(alpha34)*lamb4*(2-lamb4);
    else
        F4 = -(C34/2)*tan(alpha34);
    end
else
    F1 = -(C12/2)*alpha12;
    F2 = -(C12/2)*alpha12;
    F3 = -(C34/2)*alpha34;
    F4 = -(C34/2)*alpha34;
end



% xdot1=x(2); % vy-speed
% xdot2= (1/m)*(F34+F12*cos((delta_t+SC1)*SC2))-x(4)*velocity; % vy-acceleration
% xdot3=x(4); % Yaw rate angular velocity
% xdot4= (1/Jz)*(f*F12*cos((delta_t+SC1)*SC2)-b*F34); % Yaw rate angular acceleration
% xdot=[xdot1 xdot2 xdot3 xdot4]';
xdot1=x(2); % vy-speed
xdot2= (1/m)*((F1+F2)*cos((delta_t+SC1)*SC2)+F3+F4)-x(4)*velocity; % vy-acceleration
xdot3=x(4); % Yaw rate angular velocity
xdot4= (1/Jz)*(f*(F1+F2)*cos((delta_t+SC1)*SC2)-b*(F3+F4)); % Yaw rate angular acceleration
xdot=[xdot1 xdot2 xdot3 xdot4]';
%----------------------------------------------------------------
