function out = nest_list(f,x0,n)
	if nargin < 3 || isempty(n) || n < 0
		error('Invalid number of nestings, n. Must be a non-negative integer.');
	else
		out = zeros(n+1,1);
		out(1) = x0;

		for k=2:n+1
			out(k) = f(out(k-1));
		end
	end
end