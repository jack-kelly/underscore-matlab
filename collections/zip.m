function out = zip(varargin)
	M = numel(varargin);
	
	% Take as many as the smallest collection.
	n = chainer(varargin).map(@numel).reduce(@min).value;

	out = cell(n,1);

	for k = 1:n
		out{k} = map(@(v)fetch(v,k), varargin);
	end
end