% Curry an argument from a function (off the end)
%
%	curried = curry(f,arg)
%
% Note: curries from the back. 
%
% Example:
% >> f = @(x,y) x + y
% >> f(3,4)
% ans =
% 		7
% >> g = curry_end(f,4)  % g(x) = f(x,4)
% >> g(3)
% ans =
% 		7
function curried = curry_end(f,arg)
	curried = @(varargin) f(varargin{:},arg);
end