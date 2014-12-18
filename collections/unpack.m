function varargout = unpack(collection)
	n = numel(collection);
	if isnumeric(collection) || isstruct(collection)
		for k = 1:n
			varargout{k} = collection(k);
		end
	elseif iscell(collection)
		[varargout{1:n}] = collection{:};
	else
		varargout{1} = collection;
	end
end