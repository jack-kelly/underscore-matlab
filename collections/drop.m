function out = drop(n, collection)
	if isempty(collection) || n > numel(collection)
		out = [];
	else
		out = collection(end+1:end);
	end
end