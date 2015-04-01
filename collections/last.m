% out = last(collection)
%
% Returns the last element of the collection.
%
% USAGE:
% 
% >> tail(1:10)
% ans =
%	10
% >> tail([])
% ans = 
% 	[]
function out = last(collection)
	if isempty(collection)
		out = []
	elseif iscell(collection)
		out = collection{end};
	else
		out = collection(end);
	end
end