function out = head(collection)
	if isempty(collection)
		out = []
	elseif iscell(collection)
		out = collection{1};
	else
		out = collection(1);
	end
end