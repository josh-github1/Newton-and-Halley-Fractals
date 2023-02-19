% Joshua Ramayrat
% Nicholas
% Zachary
%
% Halley Function

function [ val ] = Halley( a, b, c, d)
	val = a - (2*b*c)/(2*(c^2)-b*d);
end

