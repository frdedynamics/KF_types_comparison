function [ Out ] = ExpSk( M )
%UNTITLED3 Summary of this function goes here

Out = eye(3) + Skew(M/norm(M))*sin(norm(M)) + (Skew(M/norm(M)))^2*(1 - cos(norm(M)));


end

