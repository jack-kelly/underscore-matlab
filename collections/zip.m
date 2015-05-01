%{
	out = zip(S_1 [, S_2, ... ])
	
	Takes any number of collections S_1, ... , S_k and 
	produces tuples
		(S_1(1), S_2(1), ... , S_k(1))
		(S_1(2), S_2(2), ... , S_k(2))
		...
		(S_1(N), S_2(N), ... , S_k(N))

	Where N = min( |S_1|, |S_2|, ... , |S_k| )

	Example:

	>> X = zip(1:10,20:35,{'a','b','c','d','e','f'})
	X = 
	    {1x3 cell}
	    {1x3 cell}
	    {1x3 cell}
	    {1x3 cell}
	    {1x3 cell}
	    {1x3 cell}
	>> X{:}
	ans = 
	    [1]    [20]    'a'
	ans = 
	    [2]    [21]    'b'
	ans = 
	    [3]    [22]    'c'
	ans = 
	    [4]    [23]    'd'
	ans = 
	    [5]    [24]    'e'
	ans = 
	    [6]    [25]    'f'
%}
function out = zip(varargin)
	M = numel(varargin);
	
	% Take as many as the smallest collection.
	n = chainer(varargin).map(@numel).reduce(@min).value;

	out = cell(n,1);

	for k = 1:n
		out{k} = map(@(v)fetch(v,k), varargin);
	end
end