% out = isin(collection, object)
%
% Returns true if collection isin object,
% false otherwise. Undefined for structs.
%
% USAGE:
%
% >> X = {1, 3, 'a',pi};
% >> isin(X,pi)
% ans =
%      1
% >> isin(X,8)
% ans =
%      0
% >> isin(X,'a')
% ans =
%      1
% >> isin(X,'pi')
% ans =
%      0
function out = isin(collection, object)
    if isstruct(collection)
        error('isin:nostructs','Behavior of isin() undefined on structs.');
    end

	out = ~isempty(compact(map(curry(@isequal,object),collection)));
end