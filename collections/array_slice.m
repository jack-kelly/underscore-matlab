% out = array_slice(collection,inds1,inds2,...,indsN)
%
% Functional interface to array slicing
%
% For example, A(1,:,1:3) is equivalent to array_slice(A,1,':',1:3)
function out = array_slice(collection, varargin)
	out = collection(varargin{:});
end