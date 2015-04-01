% [] = map_deep(fun, collection [, split_strings])
% 
% Applies fun to each element of collection, recursively,
% storing the result.
%
% Optional argument specifying whether to split apart strings.
%
% Note: fun must be able to be stored in containers used at
% all levels of collection.
%
% USAGE:
%
% >> x = map_deep(@sqrt, {1, {2, {3, {4}}}});
% >> [x{1} x{2}{1} x{2}{2}{1} x{2}{2}{2}{1}]
% ans =
% 	1.0000    1.4142    1.7321    2.0000
% >> x = map_deep(@upper, {'aa', {'bb', {'cc', {'dd'}}}});
% >> x{1}
% ans =
% AA
% >> x{2}{1}
% ans =
% BB
% >> x{2}{2}{1}
% ans =
% CC
% >> x{2}{2}{2}{1}
% ans =
% DD
% >> x = map_deep(@(x)x - 1, {'aa', {'bb', {'cc', {'dd'}}}}, true); % operate on ascii code
% >> x{1}
% ans =
% ``
% >> x{2}{1}
% ans =
% aa
% >> x{2}{2}{1}
% ans =
% bb
% >> x{2}{2}{2}{1}
% ans =
% cc
function out = map_deep(fun, collection, split_strings)
	if nargin < 3
		split_strings = false;
	end

	if nargout(fun) == 0
		error('Mapping with a function with no outputs is not supported.')
	end

	
	if ~split_strings && ischar(collection)
		collection = fun(collection);
	elseif iscell(collection)
		for k = 1:numel(collection)
			collection{k} = map_deep(fun,collection{k}, split_strings);
		end
	elseif numel(collection) > 1
		for k = 1:numel(collection)
			collection(k) = map_deep(fun,collection(k), split_strings);
		end
	elseif isscalar(collection)
		collection = fun(collection);
	else
		error('I do not know what to do with this collection.')
	end
		

	out = collection;
end