% fullSize - Like size but better
%{ 
%-------------------------------------------------------------------------------
% SYNTAX:
%   result = fullSize(x,<dim>)
%   [r1,r2,...] = fullSize(x,<dim>);
%
% PURPOSE:
%   This function determines the size of x.  If dim is passed, the size of x
%   along dimension dim is returned.  The builtin size function is inadequate
%   for this task because it does not consistently handle dimension numbers or
%   optional dimensions.  It is also not vectorized over dim.
%
%   This function operates under the following principles
%   numel(x) = prod(size(x))
%   ndims = numel(size(x))
%   objects have a minimum dimension but no maximum.  When not otherwised
%   specified, the minimum dimension should be returned.
%  
% INPUT:
%   x       - Object to take the size of
%   dim     - Dimension to evaluate the size over.  If dimensions are requested
%             beyond the minimal dimension the results will be extended
%             appropriately.
%             Default: Minimal set in ascending order
% 
% OUTPUT:
%   result  - Size of the object.  We follow MATLAB's convention by forming our
%             arrays in the 2nd dimension
%
% ASSUMPTIONS: 
%   All input variables are of the correct type, valid(if applicable),
%   and given in the correct order. 
%
% Credits to Joel LeBlanc on this function.
% 
%-------------------------------------------------------------------------------
%}
function varargout = fullSize(x,dim)

	% Compute the fullSize as a vector
	xEmpty = isempty(x);
	if(xEmpty || isscalar(x))
	    result = numel(x);
	    
	else
	    result = size(x);
	    if(result(end)==1)
	        result(end) = [];
	    end
	    
	end

	if(nargin>1)
	    result(end+1:max(dim)) = double(~xEmpty);
	    result = result(dim);
	end

	% Provide the outputs
	if nargout>1
		varargout(1:nargout) = num2cell(result(1:nargout));
	else
	    varargout{1} = result;
	end

end