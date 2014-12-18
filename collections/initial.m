function out = initial(collection)
	if isempty(collection)
		out = [];
	else
		out = collection(1:end-1);
	end
end