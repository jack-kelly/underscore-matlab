% Recursively count the number of elements in something. 
% Does NOT split strings apart by default. Does not count
% empty things.
%
% e.g.:   >> X = {[1 2 3], {'abc',{}},{{{{{134}}}}}}
%         >> numel_deep(X)
%		  ans =
% 				5
function n = numel_deep(collection, split_strings)
	if nargin < 2
		split_strings = false;
	end

	n = 0;
	
	if iscell(collection)
		for k = 1:numel(collection)
			n = n + numel_deep(collection{k}, split_strings);
		end
	elseif numel(collection) > 1
		for k = 1:numel(collection)
			n = n + numel_deep(collection(k), split_strings);
		end
	elseif isscalar(collection)
		n = n + 1;
	elseif  ~split_strings&&ischar(collection)
		n = n + 1;
	else
		error('I do not know what to do with this collection.')
	end	
end