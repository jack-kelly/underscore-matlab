% out = take(n, collection)
%
% Returns the first n elements of collection
% or the entire collection if n > the number
% of objects in collection.
%
% USAGE:
%
% >> take(5,1:10)
% ans =
%      1     2     3     4     5
% >> take(3,{'a',pi})
% ans = 
%     'a'    [3.1416]
function out = take(n, collection)
	if isempty(collection)
		out = [];
	else
		out = collection(1:min(end,n));
	end
end