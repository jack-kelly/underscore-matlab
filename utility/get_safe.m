% a protected call to get(obj,propery)
% Will not throw error if property does not exist in obj, but will
% throw any other errors (e.g., obj doesn't exist)
function out = get_safe(varargin)
	try
		out = get(varargin{:});
	catch e
		if e.identifier ~= 'MATLAB:hg:InvalidProperty'
			rethrow(e)
		end
		out = [];
	end
end