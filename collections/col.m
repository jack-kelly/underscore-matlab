% out = col(collection)
%
% Converts the top-level array-shape
% to a column vector. Will not do anything
% fancy to internal stuff.
%
% A functional version version of A(:)
%
% USAGE: 
%
% out = col(A)
%
function out = col(collection)
	out = collection(:);
end