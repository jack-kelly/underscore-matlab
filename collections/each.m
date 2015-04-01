% [] = each(fun, collection)
%
% Apply fun to each element of collection,
% without storing the result.
%
% USAGE:
%
% >> each(@disp, [1 2 3 4])
%     1
%     2
%     3
%     4
function each(fun, collection)
	if iscell(collection)
		for k = 1:numel(collection)
			fun(collection{k});
		end
	else
		for k = 1:numel(collection)
			fun(collection(k));
		end
	end
end