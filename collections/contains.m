function out = contains(collection, object)
	out = any(map(curry(@isequal,object),collection));
end