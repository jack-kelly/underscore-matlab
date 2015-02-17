% Compose functions:
%
% >> % Set h(x) = f(g(x))
% >> h = compose(f,g);
%
% >> % set d(x) = a(b(c(x)))
% >> d = compose(a,b,c);
%
% >> % Calling with a single argument composes with identiy.
% >> % s(x) = t(x)
% >> s = compose(t);
function out = compose(f,varargin)
	if nargin == 0 || isempty(f)
		error('No functions supplied.')
	end
	if isempty(varargin)
		out = f;
	else
		inside = compose(head(varargin),varargin{2:end});
		out = @(varargin) f(inside(varargin{:}));
	end
end