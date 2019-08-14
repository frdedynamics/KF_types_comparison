%% Read Log Script
% Read sensor data from a text file and saves them into a .mat file in
% order to use them in Simulink

%% Fresh workspace at first
clear all
close all

%% Import log file
% Specify name of input file
input_filename = 'sensorLog_2pitch.txt';
output_filename = 'data.mat';
fid=fopen(input_filename);



% The next lines are in the format
% data_type time data_x data_y data_z
% where:
% data_type = { ATTITUDE, ACCEL, GYRO, MAGNETO, GPS }
% time = floating-point time [s]
% data_x, data_y, data_z = floating-point values of vector of above
% Note units depend on type

data = textscan(fid,'%f %s %f %f %f');  % Resulting format: cells
fclose(fid);

%% Extract out numerical entries of data into an array (used below)
data_matrix = cell2mat( data(:,[1,3,4,5]) );

%% Now scan through A{1} (a cell) looking for each of the three types
test = strcmp(data{2},'ACC');  
test1 = find(test==true);  
accel_data = data_matrix(test1,:); 
accel_data_length = length(accel_data);


test = strcmp(data{2},'GYR');  
test1 = find(test==true); 
gyro_data = data_matrix(test1,:); 
gyro_data_length = length(gyro_data);


accel_data = accel_data(length(accel_data)+1-min(length(accel_data),length(gyro_data)):end,:);

sample_time = 0.01; 
sim_time = (sample_time*(length(accel_data)-1)); 
t_data = 0:sample_time:sim_time; 
acc_ts = timeseries(accel_data(:,2:4), t_data, 'name', 'Accelerometer'); 
gyro_ts = timeseries(gyro_data(:,2:4), t_data, 'name', 'Gyroscope'); 

% acc_ts = timeseries(accel_data(:,2:4), 1:length(accel_data), 'name', 'Accelerometer');
% gyro_ts = timeseries(gyro_data(:,2:4), 1:length(gyro_data), 'name', 'Gyroscope');

% gyro_data(:,1) = 0:1:length(gyro_data)-1;
% 
% 
% test=strcmp(data{2},'MAG'); 
% test1=find(test==true);  
% mag_data=data_matrix(test1,:); 
% mag_data(:,1) = 0:1:length(mag_data)-1;

%% Save all to disk as .mat file
save('Accelerometer','acc_ts','-v7.3')
save('Gyroscope','gyro_ts','-v7.3')


%% Edit .mat file to time series
% count1 = timeseries(count(:,1), 1:24,'name', 'intersection1');


%% flush the memory
clear data;
clear fid
clear output_filename
clear test
clear test1
disp([' Data from ' input_filename  'saved']);


