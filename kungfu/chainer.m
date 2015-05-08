%{
	A simple object to chain together many functional
	operations. Can often help readability of complex operations.

	Examples:

	>> chainer(1:10000).map(@(x)1/x).map(@(x)x^2).sum.value
	ans =
	    1.6448

	>> chainer(magic(3)).col.foldl(@plus).value
	ans =
	    45

	NOTE: Some functions, such as sum, prod, etc. will error
	if you try to use them on non-numeric types.
%}
classdef chainer
	properties(SetAccess = private, GetAccess = public)
		value
	end
	methods
		function obj = chainer(value)
			obj.value = value;
		end

		function obj = col(obj, varargin)
			obj = chainer(col(obj.value, varargin{:}));
		end
		function obj = compact(obj, varargin)
			obj = chainer(compact(obj.value, varargin{:}));
		end
		function obj = contains(obj, varargin)
			obj = chainer(contains(obj.value, varargin{:}));
		end
		function each(obj, varargin)
			each(varargin{:}, obj.value);
		end
		function each_deep(obj, varargin)
			each_deep(varargin{:}, obj.value);
		end
		function obj = cell2mat(obj, varargin)
			obj = chainer(cell2mat(obj.value, varargin{:}));
		end
		function obj = mat2cell(obj, varargin)
			obj = chainer(mat2cell(obj.value, varargin{:}));
		end	
		function obj = curly(obj, varargin)
			obj = chainer(curly(obj.value, varargin{:}));
		end
		function obj = dot_(obj, varargin)
			obj = chainer(dot_(obj.value, varargin{:}));
		end
		function obj = drop(obj, varargin)
			obj = chainer(drop(varargin{:},obj.value));
		end
		function obj = diff(obj, varargin)
			obj = chainer(diff(obj.value,varargin{:}));
		end
		function obj = fetch(obj, varargin)
			obj = chainer(fetch(obj.value, varargin{:}));
		end
		function obj = flatten(obj, varargin)
			obj = chainer(flatten(obj.value, varargin{:}));
		end
		function obj = reduce(obj, varargin)
			obj = chainer(foldr(varargin{:}, obj.value));
		end
		function obj = foldr(obj, varargin)
			obj = chainer(foldr(varargin{:}, obj.value));
		end
		function obj = foldl(obj, varargin)
			obj = chainer(foldl(varargin{:}, obj.value));
		end
		function obj = head(obj, varargin)
			obj = chainer(head(obj.value, varargin{:}));
		end
		function obj = initial(obj, varargin)
			obj = chainer(initial(obj.value, varargin{:}));
		end
		function obj = last(obj, varargin)
			obj = chainer(last(obj.value, varargin{:}));
		end
		function obj = map(obj, varargin)
			obj = chainer(map(varargin{:}, obj.value));
		end
		function obj = map_deep(obj, varargin)
			obj = chainer(map_deep(varargin{:}, obj.value));
		end
		function obj = paren(obj, varargin)
			obj = chainer(paren(obj.value, varargin{:}));
		end
		function obj = prod(obj, varargin)
			if isnumeric(obj.value)
				obj = chainer(prod(obj.value, varargin{:}));
			else
				obj = chainer(reduce(@times, obj.value));
			end
		end
		function obj = select(obj, varargin)
			obj = chainer(select(varargin{:}, obj.value));
		end
		function obj = sum(obj, varargin)
			if isnumeric(obj.value)
				obj = chainer(sum(obj.value, varargin{:}));
			else
				obj = chainer(reduce(@plus, obj.value));
			end
		end
		function obj = reject(obj, varargin)
			obj = chainer(reject(varargin{:}, obj.value));
		end
		function obj = tail(obj, varargin)
			obj = chainer(tail(obj.value, varargin{:}));
		end
		function obj = take(obj, varargin)
			obj = chainer(take(varargin{:}, obj.value));
		end
		function obj = zip(obj, varargin)
			obj = chainer(zip(obj.value, varargin{:}));
		end
		function obj = unzip(obj, varargin)
			obj = chainer(unzip(obj.value, varargin{:}));
		end
	end
end