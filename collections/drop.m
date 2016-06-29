% out = drop(n, collection)
%
% Drop the first n elements of collection.
% Note, indexing is linear, so it will always return a vector.
%
% USAGE:
%
% >> drop(3, 1:10)
% ans =
%      4     5     6     7     8     9    10
% >> drop(20, 1:10)
% []
% >> drop(2, {'a',3,[],'last'})
% ans = 
%     []    'last'
% >> drop(7,'I love pancakes!')
% ans =
% pancakes!
function out = drop(n, collection)
	if isempty(collection) || n > numel(collection)
		out = collection([]); % ensures return collection type is the same
	else
		out = collection(n+1:end);
	end
end