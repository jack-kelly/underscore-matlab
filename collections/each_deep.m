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