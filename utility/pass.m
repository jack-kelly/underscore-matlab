% varargout = pass(varargin)
% 
% passes inputs to outputs -- effectively does nothing
% useful as a "default" function in many situations
function varargout = pass(varargin)
	[varargout{1:min(nargin,nargout)}] = varargin{1:min(nargin,nargout)};
end