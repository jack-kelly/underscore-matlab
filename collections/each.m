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