% slideshow(images, [update_call, colormap])

% SLIDESHOW - a handy tool to scroll through stacks of images.
%{
%-------------------------------------------------------------------------------
%	h = slideshow(images, [update_call, colormap])
%
% INPUTS:
%	images 		- A stack of images. 
%				  Can be in several forms:
%				  	1) an [M N   numImages] array of grayscale images
%				  	2) an [M N L numImages] array of color images
%				  	3) a cell array with numImages elements, each a different
%				  	   image of possibly different sizes
% 
%	update_call - a function with prototype f(k) that is called
%				  every time the frame is drawn. A classic example
%				  would be @(k) title(k)
% 
%	colormap    - a string indicating which colormap to display images
%				  e.g. 'gray', 'hot', etc.
%
% USAGE:
%
%	>> slideshow(randn(100,100,50))
%   >> slideshow(cat(4, imread('test1.png'), imread('test2.png')))
%   >> slideshow({randn(100,100,1), randn(100,200,1), imread('test1.png')})
%   >> slideshow(randn(100,100,50), @(k)title(sprintf('Frame %d',k)), 'gray')
%-------------------------------------------------------------------------------
%}
function [varargout] = slideshow(images, varargin)
	[images, n, iter, update_call, cmap] = validate(images, varargin{:});

	h = figure;
	ax      = axes('Units', 'normalized', 'Position',[0.05 0.15,0.90,0.80]);
	imagesc(iter(images,1))
	colormap(cmap)
	update_call(1);
	
	control = uicontrol('Style', 'Slider', ...
						'Min', 1, 'Max', n, 'Value', 1, ...
						'SliderStep', [1/n 1/n], ...
					 	'Units', 'normalized', ...
					 	'Tag', 'valueSlider', ...
					 	'Position',[0.025 0.025,0.75,0.05], ...
					 	'Callback', curry_n(@slider_callback,ax,images, iter, update_call, cmap));
	
	text_control = uicontrol('Style', 'edit', ...
							 'Min', 1, 'Max', 1, ...
							 'String', '1', ...
							 'Units', 'normalized', ...
							 'Tag', 'valueEdit', ...
					 	     'Position',[0.80 0.025,0.15,0.05], ...
					 	     'Callback', curry_n(@text_callback,ax,images, iter, update_call, cmap));

	h.WindowScrollWheelFcn = curry_n(@scrollwheel_callback, ax,images,iter, update_call, cmap);

	if nargout > 0
		varargout = h;
	end
end

function slider_callback(ax, images, iter, update_call, cmap, source, data)
	k = round(source.Value);

	obj = guihandles(source.Parent);
	obj.valueEdit.String = num2str(k);

	axes(ax); imagesc(iter(images,k)); colormap(cmap); update_call(k); drawnow;
end

function text_callback(ax, images, iter,update_call, cmap, source, data)
	obj = guihandles(source.Parent);
	k = clamp(round(real(str2double(source.String))), [obj.valueSlider.Min obj.valueSlider.Max] );
	obj.valueSlider.Value = k;
	axes(ax); imagesc(iter(images,k)); update_call(k); drawnow;
end

function scrollwheel_callback(ax,images,iter,update_call, cmap, source, data)
	obj = guihandles(source);

	if data.VerticalScrollCount > 0
		obj.valueSlider.Value = clamp(obj.valueSlider.Value + 1, [obj.valueSlider.Min obj.valueSlider.Max] );
	elseif data.VerticalScrollCount < 0
		obj.valueSlider.Value = clamp(obj.valueSlider.Value - 1, [obj.valueSlider.Min obj.valueSlider.Max] );
	end
	slider_callback(ax,images,iter,update_call,cmap, obj.valueSlider,data);
end

function [images, n, iter, update_call, cmap] = validate(images,varargin)
	if isempty(images)
		error('Empty image data.')
	end

	if nargin < 2 || isempty(varargin{1})
		update_call = @pass;
	else
		update_call = varargin{1};
	end

	if nargin < 3 || isempty(varargin{2})
		cmap = 'default';
	else
		cmap = varargin{2};
	end

	% assert(isa(update_call, 'function_handle'))

	if nargin(update_call) == 0
		update_call = @(varargin) update_call();
	end

	if iscell(images)
		n = numel(images);
		iter = @(I, k) I{clamp(k,[1 n])};
	elseif isnumeric(images) || islogical(images)
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