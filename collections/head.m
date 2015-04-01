% out = head(collection)
%
% Returns the first element of the collection.
%
% USAGE:
% 
% >> head(1:10)
% ans =
%	1
% >> head([])
% ans = 
% 	[]
function out = head(collection)
	if isempty(collection)
		out = [];
	elseif iscell(collection)
		out = collection{1};
	else
		out = collection(1);
	end
end