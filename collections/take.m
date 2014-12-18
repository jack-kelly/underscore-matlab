function out = take(n, collection)
	if isempty(collection)
		out = [];
	else
		out = collection(1:min(end,n));
	end
end