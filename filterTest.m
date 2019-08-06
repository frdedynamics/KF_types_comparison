clear all; close all; clc
read_log_script

ld = load('data.mat');

acc = ld.sensorData.Acceleration;
gyro = ld.sensorData.AngularVelocity;
mag = ld.sensorData.MagneticField;

viewer = HelperOrientationViewer;

qe = ecompass(accel, magneto);
for ii=1:size(accel,1)
    viewer(qe(ii));
    pause(0.01);
end