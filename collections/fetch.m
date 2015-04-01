% out = fetch(collection,k)
%
% Grab the kth element of collection.
%
% USAGE:
%
% >> fetch(1:10, 5)
% ans =
% 		5
function out = fetch(collection,k)
	if iscell(collection)
		out = collection{k};
	else
		out = collection(k);
	end
end