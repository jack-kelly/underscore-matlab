% out = select(fun, collection)
%
% Returns a container of same type as collection
% with only the objects that return true for fun
% inside.
%
% USAGE
% 
% >> select(@(x) x > 0, -5:5)
% ans =
%      1     2     3     4     5
% >> select(@(x) x < 0, -5:5)
% ans =
%     -5    -4    -3    -2    -1
% >> select(@(x)numel(x)<5,{1:2,1:3,1:5,1:7})
% ans = 
%     [1x2 double]
%     [1x3 double]
function out = select(fun, collection)
	inds = 1:numel(collection);
	inds = map(compose(fun, curry(@fetch, collection)), inds) == 1;
	out = collection(inds); 
end