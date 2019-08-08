% This script reads in the specified text file logged by "sensorlog.txt"

clear all
close all

% Specify name of input file


input_filename='sensorLog_2pitch.txt';
output_filename='data.mat';





fid=fopen(input_filename);



% The next lines are in the format
% data_type time data_x data_y data_z
% where:
% data_type = { ATTITUDE, ACCEL, GYRO, MAGNETO, GPS }
% time = floating-point time [s]
% data_x, data_y, data_z = floating-point values of vector of above
% Note units depend on type

data=textscan(fid,'%f %s %f %f %f');  % Resulting format: cells

fclose(fid);

% Extract out numerical entries of data into an array (used below)
data_matrix=cell2mat( data(:,[1,3,4,5]) );

% Now scan through A{1} (a cell) looking for each of the five types



test=strcmp(data{2},'ACC');  
test1=find(test==true);  
accel_data=data_matrix(test1,:); 

test=strcmp(data{2},'GYR');  
test1=find(test==true); 
gyro_data=data_matrix(test1,:); 

test=strcmp(data{2},'MAG'); 
test1=find(test==true);  
mag_data=data_matrix(test1,:); 






% Save all to disk (to avoid rerunning the script - is this useful?)

save(output_filename,'accel_data','gyro_data','mag_data');

%adaptation to other code
accel=accel_data;
clear accel_data;
gyro=gyro_data;
clear gyro_data;
magneto=mag_data;
clear mag_data;
clear attitude_data;
clear data;
clear fid
clear output_filename
clear test
clear test1


disp([' Data from ' input_filename  'saved']);


