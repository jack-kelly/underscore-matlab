function out = flatten(collection, split_strings)
	import java.util.LinkedList
	if nargin < 2
		split_strings = false;
	end

	Q = LinkedList();
	each_deep(@(x)add(Q,x),collection,split_strings);
	
	n = Q.size;
	out = cell(n, 1);
	for kk = 1:n
		out{kk} = Q.remove();
	end
end