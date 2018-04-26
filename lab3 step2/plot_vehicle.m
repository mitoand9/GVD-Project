% Animering av fordon med styrvinklar.
% Studenten böhöver aldrig in i denna fil om de inte vill.
function plot_vehicle(phi,x,y,delta,L,f,lambda,skala,fignum,i,time)

    figure(fignum)
    phih=[phi+delta,phi,phi,phi+delta]; %Hjulens olika vinklar globalt.
    [X,Y]=rect(L,0.16*skala,x(i),y(i),phi,lambda); % Funktion för chassit och hjulens koordinater globalt.
    X(6)=x(i)+f*cos(phi);X(7)=x(i);Y(6)=y(i)+f*sin(phi);Y(7)=y(i);
    hold off
    plot(X,Y)%plottar chassit
    hold on
    %plot([x(i) x(i)+f*cos(phi)],[y(i) y(i)+f*sin(phi)]) %linje som visar bilens riktning.
    for j=1:4 %plottar 4 hjul
        [Xh,Yh]=rect(0.065*skala,0.025*skala,X(j),Y(j),phih(j),0.5); % Funktion för hjulens ytterhörn koordinater globalt.
        plot(Xh,Yh);
    end
    plot(x(1:i),y(1:i),'r'); % Visar bilens körbana 
    grid on
    xlabel('X [m]')
    ylabel('Y [m]')
    text(0,skala*0.3,['time ',num2str(time(i)),'s']); %plottar aktuell tid.
%     text(0,skala*0.2,['X = ',num2str(x(i)),'m']); %plottar bilens akuella position.
%     text(0,skala*0.1,['Y = ',num2str(y(i)),'m']); 
    %cones
%     plot([0.7211 1.189 1.907],[3.647 3.705 3.54],'*r')
     
    %axis([-2 4 -1 5]);
    axis('equal');
    %drawnow
end
    
function [X,Y]=rect(l,b,x,y,vinkel,lambda) %( längd, bredd, x-läge, y-läge, vinkel, lambda)
    X=[x+l*lambda*cos(vinkel)+b/2*cos(vinkel-pi/2), x-l*(1-lambda)*cos(vinkel)+b/2*cos(vinkel-pi/2), x-l*(1-lambda)*cos(vinkel)-b/2*cos(vinkel-pi/2), x+l*lambda*cos(vinkel)-b/2*cos(vinkel-pi/2), x+l*lambda*cos(vinkel)+b/2*cos(vinkel-pi/2)];
    Y=[y+l*lambda*sin(vinkel)+b/2*sin(vinkel-pi/2), y-l*(1-lambda)*sin(vinkel)+b/2*sin(vinkel-pi/2), y-l*(1-lambda)*sin(vinkel)-b/2*sin(vinkel-pi/2), y+l*lambda*sin(vinkel)-b/2*sin(vinkel-pi/2), y+l*lambda*sin(vinkel)+b/2*sin(vinkel-pi/2)];
end
