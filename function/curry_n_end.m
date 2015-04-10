% Curry several arguments from the end of a function:
%
%	curried = curry_n_end(f,args)
% 
%
% SEE ALSO: curry_end, curry, curry_n
function curried = curry_n(f,varargin)
	arg = varargin;
	curried = @(varargin) f(varargin{:},arg{:});
end