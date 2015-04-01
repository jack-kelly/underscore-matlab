% out = reject(fun, collection)
%
% Works like select, but *removes*
% objects for which fun returns true.
%
% SEE: select
function out = reject(fun, collection)
	out = select(compose(@not,fun), collection);
end