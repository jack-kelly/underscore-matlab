% out = initial(collection)
%
% All but the last element in a collection.
%
% USAGE:
%
% >> initial(1:10)
% ans =
%      1     2     3     4     5     6     7     8     9
function out = initial(collection)
	if isempty(collection)
		out = [];
	else
		out = collection(1:end-1);
	end
end