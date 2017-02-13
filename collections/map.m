% out = map(fun, collection, [dim])
%
% Apply fun to each element of collection and
% store result in same kind of collection.
%
% Will error if collection cannot contain
% return type of fun (usually from non-numeric 
% functions mapped to numeric arrays).
%
% USAGE:
%
% >> map(@sqrt,1:5)
% ans =
%     1.0000    1.4142    1.7321    2.0000    2.2361
% >> map(@(A)repmat(A,1,5), {'a','b','c'})
% ans = 
%     'aaaaa'    'bbbbb'    'ccccc'
% >> map(@sum, {1:5,1:10,1:15})
% ans = 
%     [15]    [55]    [120]
% 
% OPTIONAL: pass dim to map over a specific dimension
% 
function out = map(fun, collection, dim)
	% regular mode
	if nargin < 3 || isempty(dim)
		if iscell(collection)
			for k = 1:numel(collection)
				collection{k} = fun(collection{k});
			end
		else
			for k = 1:numel(collection)
				collection(k) = fun(collection(k));
			end
		end
	% map over specific dim
	else
		N = max(numdims(collection), dim);
		K = size(collection,dim);
		if iscell(collection)
			for k = 1:K
				inds = dim_slice(N,dim,k);
				collection(inds{:}) = fun(collection(inds{:}));
			end
		else
			for k = 1:K
				inds = dim_slice(N,dim,k);
				collection(inds{:}) = fun(collection(inds{:}));
			end
		end
	end
	out = collection;
end