function out = select(fun, collection)
	inds = 1:numel(collection);
	inds = map(compose(fun, curry(@fetch, collection)), inds) == 1;
	out = collection(inds); 
end