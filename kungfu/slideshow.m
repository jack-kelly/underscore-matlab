function [varargout] = slideshow(images, varargin)
	[images, n, iter, update_call] = validate(images, varargin{:});

	h = figure;
	ax      = axes('Units', 'normalized', 'Position',[0.05 0.15,0.90,0.80]);
	imagesc(iter(images,1))
	update_call(1);
	
	control = uicontrol('Style', 'Slider', ...
						'Min', 1, 'Max', n, 'Value', 1, ...
						'SliderStep', [1/n 1/n], ...
					 	'Units', 'normalized', ...
					 	'Tag', 'valueSlider', ...
					 	'Position',[0.025 0.025,0.75,0.05], ...
					 	'Callback', curry_n(@slider_callback,ax,images, iter, update_call));
	
	text_control = uicontrol('Style', 'edit', ...
							 'Min', 1, 'Max', 1, ...
							 'String', '1', ...
							 'Units', 'normalized', ...
							 'Tag', 'valueEdit', ...
					 	     'Position',[0.80 0.025,0.15,0.05], ...
					 	     'Callback', curry_n(@text_callback,ax,images, iter, update_call));

	h.WindowScrollWheelFcn = curry_n(@scrollwheel_callback, ax,images,iter, update_call);

	if nargout > 0
		varargout = h;
	end
end

function slider_callback(ax, images, iter,update_call, source, data)
	k = round(source.Value);

	obj = guihandles(source.Parent);
	obj.valueEdit.String = num2str(k);

	axes(ax); imagesc(iter(images,k)); update_call(); drawnow;
end

function text_callback(ax, images, iter,update_call, source, data)
	obj = guihandles(source.Parent);
	k = clamp(round(real(str2double(source.String))), [obj.valueSlider.Min obj.valueSlider.Max] );
	obj.valueSlider.Value = k;
	axes(ax); imagesc(iter(images,k)); update_call(k); drawnow;
end

function scrollwheel_callback(ax,images,iter,update_call, source, data)
	obj = guihandles(source);

	if data.VerticalScrollCount > 0
		obj.valueSlider.Value = clamp(obj.valueSlider.Value + 1, [obj.valueSlider.Min obj.valueSlider.Max] );
	elseif data.VerticalScrollCount < 0
		obj.valueSlider.Value = clamp(obj.valueSlider.Value - 1, [obj.valueSlider.Min obj.valueSlider.Max] );
	end
	slider_callback(ax,images,iter,update_call,obj.valueSlider,data);
end

function [images, n, iter, update_call] = validate(images,varargin)
	if isempty(images)
		error('Empty image data.')
	end

	if nargin < 2 || isempty(varargin{1})
		update_call = @pass;
	else
		update_call = varargin{1};
	end

	% assert(isa(update_call, 'function_handle'))

	if nargin(update_call) == 0
		update_call = @(varargin) update_call();
	end

	if iscell(images)
		n = numel(images);
		iter = @(I, k) I{clamp(k,[1 n])};
	elseif isnumeric(images)
		if numdims(images) == 4
			n = full_size(images,4);
			iter = @(I, k) squeeze(I(:,:,:,clamp(k, [1 n])));
		else
			n = full_size(images,3);
			iter = @(I, k) I(:,:,clamp(k, [1 n]));
		end
	else
		error('Unsupported format for images.');	
	end
end