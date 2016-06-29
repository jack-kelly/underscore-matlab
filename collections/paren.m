% out = paren(thing,inds1,inds2,...,indsN)
%
% Functional interface to array slicing / function evaluation
%
% For example, A(1,:,1:3) is equivalent to paren(A,1,':',1:3)
%
% Note: pass the string ':' for :
function out = paren(thing, varargin)
	out = thing(varargin{:});
end