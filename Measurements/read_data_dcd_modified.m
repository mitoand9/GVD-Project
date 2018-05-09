clear
close all
clc

% Program for creating *.dcd-file for ADAMS
% Enter the filename of the measurement file that shall be loaded, insert the desired steering deviation (offset_error and scaling_error), perhaps 
% adjust the time interval to be imported from the measurement file (hereafter referred to as file_data), save with an appropriate file name.
% To run the file in ADAMS it has to be opened in e.g. notepad first. Once opened in notepad, take away the three top rows and save the file. 
% That's it!
% Created by: John Magnus and Fredrik 2008
% Edit by: Daniel 2012

% desired steering deviation and calibration
offset_error=0.0225;    %OFFSET ERROR
scaling_error=1;    %SCALING ERROR

addpath('C:\Users\Teknolog_2\Desktop\Measurements')


load LUNDA121.ASC
% Read-in of file

% file_str = ['C:\Users\Teknolog_2\Desktop\Measurements/LUNDA121.ASC']            % file name--------------CHANGE HERE
% 
% fid = fopen(file_str);                      % open file
% % for i=1:7
% %     temp = fgetl(fid);                      % remove title rows
% % end
% % fscanf(fid,'%e',[13 inf]);                  % import data
% file_data = ans;
% fclose(fid);                                % close file

file_data=LUNDA121;



%create new matrix

UTdata(:,1)=file_data(:,1);             %optionally adjust time interval in the file_data
UTdata(:,2)=file_data(:,2);
UTdata(:,3:6)=zeros(length(file_data),4);

UTdata(:,2)=scaling_error*(UTdata(:,2)-offset_error);


apo=char(39);
Str_1 = strvcat('[MDI_HEADER]','FILE_NAME     = LUNDA121.dcd');  % Change to appropriate file name
Str_2=strcat('FILE_TYPE     =',apo,('dcd'),apo);
Str_3='FILE_VERSION  = 1.0';
Str_4=strcat('FILE_FORMAT   = ', apo, 'ASCII', apo);
Str_5=strvcat('(COMMENTS)', '{comment_string}');
Str_6=strcat(apo, 'Example .dcd file containing open loop data from sampled steering wheel angle.', apo);
Str_7='$--------------------------------------------------------------------------UNITS';
Str_8='[UNITS]';
Str_9=strcat('LENGTH = ', apo, 'meters', apo);
Str_10=strcat('FORCE  = ', apo, 'newton', apo);
Str_11=strcat('ANGLE  = ', apo, 'radians', apo);
Str_12=strcat('MASS   = ', apo, 'kg', apo);
Str_13=strcat('TIME   = ', apo, 'sec', apo);
Str_14=strvcat('$----------------------------------------------------------------------OPEN_LOOP','[OPEN_LOOP]');
Str_15=strcat('ORDINAL = ', apo, 'time', apo);
Str_16=strvcat(' ', '(DATA)', '{time steering throttle brake gear clutch}');

datastr=num2str(UTdata);
Utstr=strvcat(Str_1,Str_2,Str_3,Str_4,Str_5,Str_6,Str_7,Str_8,Str_9,Str_10,Str_11,Str_12,Str_13,Str_14,Str_15,Str_16,datastr);

figure(3)
hold on
plot(file_data(:,1), 180/pi*(file_data(:,2)),'r')
plot(UTdata(:,1),180/pi*UTdata(:,2),'bl-')
title('Origial vs shifted')
legend('Orignal','shifted')
grid minor
ylabel('SWA angle [degrees]')
xlabel('Time [s]')
text(1,100, 'scaling  1')
text(1,60, 'offset 0.0225' )

% Change to appropriate file name
diary LUNDA121.dcd

Utstr

diary off

clc

'Done'