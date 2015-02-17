% Removes values that are not true-ish.
% This includes false, empty arrays, empty cell arrays, etc.
function out = compact(collection)
	if isnumeric(collection)
		out = collection(find(collection));
	else
		inds = map(@trueish,collection);
		if iscell(inds)
			inds = cell2mat(inds);
		end
		out = collection(inds);
	end
end