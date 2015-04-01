% a protected call to set(obj,propery)
% Will not throw error if property does not exist in obj, but will
% throw any other errors (e.g., obj doesn't exist)
function out = set_safe(varargin)
	try
		out = set(varargin{:});
	catch e
		if e.identifier ~= 'MATLAB:hg:InvalidProperty'
			rethrow(e)
		end
		out = [];
	end
end