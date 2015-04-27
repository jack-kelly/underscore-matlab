function out = foldl(fun, collection, x0)
	if nargin <3 || isempty(x0)
		out = foldr(fun,initial(collection),last(collection));
		return
	end

	out = x0;
	if iscell(collection)
		for k = numel(collection):-1:1
			out = fun(out, collection{k});
		end
	else
		for k = numel(collection):-1:1
			out = fun(out, collection(k));
		end
	end
end