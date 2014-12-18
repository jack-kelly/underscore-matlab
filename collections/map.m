function out = map(fun, collection)
	if iscell(collection)
		for k = 1:numel(collection)
			collection{k} = fun(collection{k});
		end
	else
		for k = 1:numel(collection)
			collection(k) = fun(collection(k));
		end
	end
	out = collection;
end