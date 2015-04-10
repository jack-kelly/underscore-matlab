% Curry several arguments from a function:
%
%	curried = curry_n(f,args)
%
% Note: curries from the front. 
%
% Example:
% >> f = @(x,y,z) x*z + y
% >> f(3,4,2)
% ans =
% 		10
% >> g = curry_n(f,3,4)  % g(z) = f(3,4,z)
% >> g(2)
% ans =
% 		10
function curried = curry_n(f,varargin)
	arg = varargin;
	curried = @(varargin) f(arg{:},varargin{:});
end