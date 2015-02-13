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