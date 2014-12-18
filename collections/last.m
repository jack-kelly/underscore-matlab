function out = last(collection)
	if isempty(collection)
		out = []
	elseif iscell(collection)
		out = collection{end};
	else
		out = collection(end);
	end
end