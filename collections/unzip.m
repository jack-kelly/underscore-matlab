%{
	out = unzip(zipped)
	
	Takes "zipped" tuples t_k and produces
	lists of 
		the first  element from each tuple, 
		the second element from each tuple,
		etc.

	Effectively, the "reverse" of zip().

	NOTE: not an *inverse* of zip(), because
	there is potentially operations in taking place.
	Compare the output of the example unzip() with
	the input in the example for zip().

	Example:

	>> X = zip(1:10,20:35,{'a','b','c','d','e','f'});
	>> unzip(X)
	ans = 
	    {6x1 cell}
	    {6x1 cell}
	    {6x1 cell}
	>> xs{:}
	ans = 
	    [1]
	    [2]
	    [3]
	    [4]
	    [5]
	    [6]
	ans = 
	    [20]
	    [21]
	    [22]
	    [23]
	    [24]
	    [25]
	ans = 
	    'a'
	    'b'
	    'c'
	    'd'
	    'e'
	    'f'
%}
function out = unzip(zipped)
	M = chainer(zipped).map(@numel).head.value;
	n = numel(zipped);
	
	out = cell(M,1);

	for k = 1:M
		out{k} = chainer(zipped).map( @(v)fetch(v,k) ).value;
	end
end