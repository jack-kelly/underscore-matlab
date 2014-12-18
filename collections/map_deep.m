function out = map_deep(fun, collection, split_strings)
	if nargin < 3
		split_strings = false;
	end
	if isscalar(collection)
		collection = fun(collection);
	elseif ~split_strings && ischar(collection)
		collection = fun(collection);
	elseif iscell(collection)
		for k = 1:numel(collection)
			collection{k} = map_deep(fun,collection{k});
		end
	else
		for k = 1:numel(collection)
			collection(k) = map_deep(fun,collection(k));
		end
	end

	out = collection;
end