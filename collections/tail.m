function out = tail(collection)
	if isempty(collection)
		out = [];
	else
		out = collection(2:end);
	end
end