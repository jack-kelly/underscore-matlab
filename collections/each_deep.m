% [] = each_deep(fun, collection [, split_strings])
% 
% Applies fun to each element of collection, recursively,
% without storing the result.
%
% Optional argument specifying whether to split apart strings.
%
% USAGE:
%
% >> each_deep(@disp, {1, {2, {3, {4}}}})
%     1
%     2
%     3
%     4
% >> each_deep(@disp, {'aa', {'bb', {'cc', {'dd'}}}})
% aa
% bb
% cc
% dd
% >> each_deep(@disp, {'aa', {'bb', {'cc', {'dd'}}}}, true)
% a
% a
% b
% b
% c
% c
% d
% d
function each_deep(fun, collection, split_strings)
	if nargin < 3
		split_strings = false;
	end
	if iscell(collection)
		for k = 1:numel(collection)
			each_deep(fun, collection{k},split_strings);
		end
	elseif isscalar(collection)
		fun(collection);
	elseif ~split_strings && ischar(collection)
		fun(collection);
	else
		for k = 1:numel(collection)
			fun(collection(k));
		end
	end
end