% Common alias
% SEE foldr
% out = reduce(fun, collection, x0)
function out = reduce(varargin)
	out = foldr(varargin{:});
end