% out = tail(collection)
%
% Returns everything but the head (first element)
% of a collection.
%
% USAGE:
%
% >> tail(1:10)
% ans =
%     2     3     4     5     6     7     8     9    10
function out = tail(collection)
	if isempty(collection)
		out = [];
	else
		out = collection(2:end);
	end
end