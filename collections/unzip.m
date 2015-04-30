function out = unzip(zipped)
	M = chainer(zipped).map(@numel).head.value;
	n = numel(zipped);
	
	out = cell(M,1);

	for k = 1:M
		out{k} = chainer(zipped).map( @(v)fetch(v,k) ).value;
	end
end