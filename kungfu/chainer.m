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
		function obj = curly(obj, varargin)
			obj = chainer(curly(obj.value, varargin{:}));
		end
		function obj = drop(obj, varargin)
			obj = chainer(drop(varargin{:},obj.value));
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
		function obj = select(obj, varargin)
			obj = chainer(select(varargin{:}, obj.value));
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
	end
end