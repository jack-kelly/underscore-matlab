% Curry an argument from a function:
%
%	curried = curry(f,arg)
%
% Note: curries from the front. 
%
% Example:
% >> f = @(x,y) x + y
% >> f(3,4)
% ans =
% 		7
% >> g = curry(f,3)  % g(y) = f(3,y)
% >> g(4)
% ans =
% 		7
function curried = curry(f,arg)
	curried = @(varargin) f(arg,varargin{:});
end