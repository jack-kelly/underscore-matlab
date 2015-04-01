% out = map(fun, collection)
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
function out = map(fun, collection)
	if iscell(collection)
		for k = 1:numel(collection)
			collection{k} = fun(collection{k});
		end
	else
		for k = 1:numel(collection)
			collection(k) = fun(collection(k));
		end
	end
	out = collection;
end