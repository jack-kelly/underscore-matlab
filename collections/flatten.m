% out = flatten(collection, split_strings)
% 
% Flattens a collection, removing any nested collections
% and puts them into a new container in the order it traverses
% them (depth first).
%
% Note: will NOT include empty lists as objects.
%
% USAGE:
%
% >> flatten({1, {2, {3, {4}}}})
% ans = 
%     [1]
%     [2]
%     [3]
%     [4]
% >> flatten({1, {2, {3, {}}}})
% ans = 
%     [1]
%     [2]
%     [3]
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