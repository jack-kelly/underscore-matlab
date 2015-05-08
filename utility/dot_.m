% out = dot_(thing, field)
%
% Functional interface to '.' with objects and structs
%
% For example, thing.stuff is equivalent to dot_(thing,'stuff')
%
% Note: pass the string ':' for :
function out = dot_(thing, field)
	out = thing.(field);
end