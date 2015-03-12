function out = fetch(collection,k)
	if iscell(collection)
		out = collection{k};
	else
		out = collection(k);
	end
end