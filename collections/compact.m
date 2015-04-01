% out = compact(collection)
%
% Removes values that are not true-ish.
% This includes 0, false, and objects that return true
% for isempty()
%
% USAGE:
%
% >> X = {1, [], 0, -1, {'12345',123},{}};
% >> compact(X)
% ans = 
%     [1]    [-1]    {1x2 cell}
%
% >> Y = [1 0 2 0 0 3 0 0 0 4 0 0 0 0 5];
% >> compact(Y)
% ans =
%      1     2     3     4     5
%
function out = compact(collection)
	if isnumeric(collection)
		out = collection(find(collection));
	else
		inds = map(@trueish,collection);
		if iscell(inds)
			inds = cell2mat(inds);
		end
		out = collection(inds);
	end
end