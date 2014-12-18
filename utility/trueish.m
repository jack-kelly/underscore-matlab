function out = trueish(thing)
	if iscell(thing)
		out = ~isempty(thing);
	elseif isstruct(thing)
		out = true;
	elseif thing
		out = true;
	else
		out = false;
	end
end