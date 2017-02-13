% out = nest(f,x0,n)
% applies a function f n times to x0
function out = nest(f,x0,n)
	if nargin < 3 || isempty(n) || n < 0
		error('Invalid number of nestings, n. Must be a non-negative integer.');
	else
		out = x0;

		for k=2:n+1
			out = f(out);
		end
	end
end