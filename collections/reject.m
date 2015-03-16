function out = reject(fun, collection)
	out = select(compose(@not,fun), collection);
end