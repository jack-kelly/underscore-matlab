% Curry several arguments from the end of a function:
%
%	curried = rcurry_n(f,args)
% 
%
% SEE ALSO: rcurry, curry, curry_n
function curried = rcurry_n(f,varargin)
	arg = varargin; clear varargin;
	curried = @(varargin) f(varargin{:},arg{:});
end