function [ S_v ] = Skew( v )
%UNTITLED2 Summary of this function goes here

S_v = [  0     -v(3)    v(2);
        v(3)     0     -v(1);
       -v(2)    v(1)      0];


end

