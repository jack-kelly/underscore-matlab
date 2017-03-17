% out = foldr(fun, collection, x0)
function out = foldr(fun, collection, x0)
	if nargin <3 || isempty(x0)
		out = foldr(fun,tail(collection),head(collection));
		return
	end

	out = x0;
	if iscell(collection)
		for k = 1:numel(collection)
			out = fun(out, collection{k});
		end
	else
		for k = 1:numel(collection)
			out = fun(out, collection(k));
		end
	end
end