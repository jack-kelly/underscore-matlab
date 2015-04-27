function out = clamp(x, range)
	if numel(range) ~= 2
		error('Range must be in format [lo hi], where lo/hi are real (possibly infinite) numbers');
	end
	out = min(max(range(1), x), range(2));
end