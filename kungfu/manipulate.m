% h = manipulate(f, lims)
% 
% MANIPULATE
% 
% Generates a figure with sliders to interact with a passed in function
% and watch how it changes.
% 
% For a good starting example, try out:
% >> manipulate(@(x) x^2, {{'x',0,2,0.1}} )
% and
% >> manipulate(@(n)im(magic(n)), {{'n',5,15,1}})
% 
% INPUTS
% 	f    - an anonymous function handle. if f returns a graphics handle,
% 		   the graphics object will be displayed in the manipulate panel.
% 		   Otherwise, the manipulate panel will display the text output as
% 		   if f had been evaluated at the command prompt without a
% 		   terminating semicolon (;).
% 
% 	lims - a cell array of cell arrays, one for each input to f,
% 		   in the format
% 				lims{k} = {varname, start, end[, step]} where
% 					varname - string of variable name, e.g. 'x'
% 					start   - start value for slider
% 					end     - end value for slider
% 					step    - (optional) step size for slider. if omitted,
% 							  50 equal steps will be used
% 
% OUTPUTS
% 	h - figure handle for the manipulate
% 
% NOTES
% 	Plot functions that do not return a valid graphics object will probably not work.
% 	Functions that call figure() inside will not work properly with the manipulate
% 	figure -- every time you move the slider, a new figure will pop up. This can be
%   remedied by changing figure() calls to gcf() calls
function varargout = manipulate(f, lims, varargin)
	[f, vars, lims, steps, post_f] = validate(f, lims, varargin{:});

	screenSize = drop(2,get(groot, 'ScreenSize'));

	slider_w = 48;
	vars_w   = numel(vars)*slider_w;

	h                  = figure;
	h.Name             = 'Manipulate Slider';
	h.NumberTitle      = 'off';
	h.Units			   = 'pixels';
	h.Position 		   = [screenSize/3 screenSize/2];

	% positions are [left bottom width height]
	var_panel = uipanel( h, 'Title', 'Inputs','FontSize',8,'BackgroundColor','white', ...
						'Units', 'pixels','Position',[0, 0, vars_w, screenSize(2)/2]);

	out_panel = uipanel( h, 'Title', 'Output','FontSize',8,'BackgroundColor','white', ... 
					 	'Units', 'pixels','Position',[vars_w+1, 0,  screenSize(1)/2-vars_w, screenSize(2)/2]);

	N = numel(vars);
    
	var_map = containers.Map();

	for k = 1:N

		[lo, hi] = deal(lims{k}{:});

		label  = uicontrol(var_panel,'Style','text', ...
				  'Units', 'pixels', ...
				  'Position', [(k-1)*slider_w, screenSize(2)/2 - 40, slider_w,20], ...
				  'String', vars{k});

		slider = uicontrol(var_panel,'Style', 'Slider', ...
							'Min', lo, 'Max', hi, 'Value', lo, ...
							'SliderStep', [steps{k} steps{k}], ...
						 	'Units', 'pixels', ...
						 	'Position',[(k-1)*slider_w, 20, slider_w, screenSize(2)/2 - 60], ...
						 	'Callback', curry_n(@slider_callback,f,post_f,vars{k}));
		
		text   = uicontrol(var_panel,'Style', 'edit', ...
						   'String', num2str(lo), ...
						   'Units', 'pixels', ...
				 	       'Position',[(k-1)*slider_w, 0, slider_w, 20], ...
				 	       'Callback', curry_n(@text_callback,f,post_f,vars{k}));


		var_map(vars{k}) = struct('slider', slider, 'text', text, 'label', label, ...
								  'min',lo, 'max', hi, 'value', lo, 'step', steps{k} );
	end
	
	h.WindowScrollWheelFcn = curry(@scrollwheel_callback, f);
	h.SizeChangedFcn       = @resize_callback;
	
	% Set up the data that will be held in the manipulate slider.
	h.UserData.var_map   = var_map;
	h.UserData.vars      = vars;
	h.UserData.axes      = [];
	h.UserData.var_panel = var_panel;
	h.UserData.out_panel = out_panel;
	h.UserData.slider_w  = slider_w;
	
	initialize_output(f,post_f,h)

	eval_manipulated(f,post_f,h)

	if nargout > 0
		varargout{1} = h;
	end
end

function initialize_output(f,post_f,h)
	args = map(@(v) h.UserData.var_map(v).value, h.UserData.vars );

	ax = axes(h.UserData.out_panel);

	out = f(args{:});
    
    if ~isvalid(ax)
        ax = h.UserData.out_panel;
    end

	if isa(out,'handle')
		h.UserData.axes = ax;
	else
		delete(ax);
		s = evalc('f(args{:})');
		
		% 2017a changes the behavior of evalc
		if size(s,1) > 1
			s = join(s,'\n');
		end
		
		t = uicontrol(h.UserData.out_panel,'Style','text','String',s);
		t.Units = 'normalized';
		t.Position = [0.01 0.01 .98 .98];
		t.HorizontalAlignment = 'left';
	end

	post_f(args{:});

end

function eval_manipulated(f,post_f,h)
	args = map(@(v) h.UserData.var_map(v).value, h.UserData.vars );

	if ~isempty(h.UserData.axes) 
		axes(h.UserData.axes);
		f(args{:});
	else
		s = evalc('f(args{:})');
		% 2017a changes the behavior of evalc
		if size(s,1) > 1
			s = join(s,'\n');
		end
		h.UserData.out_panel.Children.String = s;
	end

	post_f(args{:});
end

function slider_callback(f, post_f, variable, source, data)
	h = source.Parent.Parent; % figure handle. immediate parent is panel
	
	v = source.Value;
	v = clamp(v, [h.UserData.var_map(variable).min h.UserData.var_map(variable).max]);
	source.Value = v;
    
    var_data = h.UserData.var_map(variable);
    var_data.value = v;
    var_data.text.String = num2str(v);

	h.UserData.var_map(variable) = var_data;

	eval_manipulated(f,post_f,h);
end

function text_callback(f,post_f, variable, source, data)
	h = source.Parent.Parent; % figure handle. immediate parent is panel
	v = real(str2double(source.String));

	v = clamp(v, [h.UserData.var_map(variable).min h.UserData.var_map(variable).max]);

	source.String = num2str(v);

    var_data = h.UserData.var_map(variable);
    var_data.value = v;
    var_data.slider.Value = v;
    
    h.UserData.var_map(variable) = var_data;
    
	eval_manipulated(f,post_f,h);
end

function scrollwheel_callback(f, source, data)
	N = numel(source.UserData.vars);

	k = ceil(source.CurrentPoint(1)/source.UserData.slider_w);

	% only scroll when we're on the actual scrollbars
	if k < 1 || k > N
		return
	end

	variable = source.UserData.vars{k};
	slider   = source.UserData.var_map(variable).slider;

	if data.VerticalScrollCount > 0
		v = min(slider.Value + slider.SliderStep(1)*(slider.Max-slider.Min),slider.Max);
	elseif data.VerticalScrollCount < 0
		v = max(slider.Value - slider.SliderStep(1)*(slider.Max-slider.Min),slider.Min);
	end
	if v ~= slider.Value
		slider.Value = v;
		slider.Callback(slider);
	end
end

function resize_callback(hObj,event)
	slider_w = hObj.UserData.slider_w;
	vars_w   = numel(hObj.UserData.vars)*slider_w;

	hObj.Position(3:4) = max( hObj.Position(3:4), [2*vars_w 100] );
	figSize = hObj.Position(3:4);

	hObj.UserData.var_panel.Position = [0, 0, vars_w, figSize(2)];
	hObj.UserData.out_panel.Position = [vars_w+1, 0,  figSize(1)-vars_w, figSize(2)];

	for k = 1:numel(hObj.UserData.vars)
		variable = hObj.UserData.vars{k};

		label = hObj.UserData.var_map(variable).label;
		label.Position  = [(k-1)*slider_w, figSize(2) - 40, slider_w,20];
		
		slider = hObj.UserData.var_map(variable).slider;
		slider.Position = [(k-1)*slider_w, 20, slider_w, figSize(2) - 60];
		
		text = hObj.UserData.var_map(variable).text;
		text.Position   = [(k-1)*slider_w, 0, slider_w, 20];
	end
end

function [f,vars, limits, steps, post_f] = validate(f,lims,varargin)
	vars = map(@head, lims);
	limits = cell(1,numel(vars));
	steps = cell(1,numel(vars));

	for k = 1:numel(vars)
		limits{k} = lims{k}(2:3);
		if numel(lims{k}) < 4
			steps{k} = 1/50;
		else
			steps{k} = lims{k}{4} / (limits{k}{2} - limits{k}{1});
		end
	end

	% Get the postprocess function
	if ~isempty(varargin)
		post_f = chain(varargin{:});
	else
		post_f = @pass;								
	end

	functionVars = get_input_vars(f);

	% If the function doesn't take varargin, make sure the variables
	% match what the user put in, otherwise, sort the input ranges to
	% match up with the argument order for the function
	if not(isequal(functionVars,{'varargin'}) || isequal(functionVars, 0) )
		if ~isequal(sort(vars), sort(get_input_vars(f))) 
			error('Variable name mismatch. Make sure your variables used in the limits are the same as in the function.');
		end

		shuffle_inds = zeros(size(vars));

		for k = 1:numel(vars)
			shuffle_inds(k) = find(cell2mat(map(@(s)isequal(vars{k},s),functionVars) ));
		end

		vars = vars(shuffle_inds);
		lims = lims(shuffle_inds);
        steps = steps(shuffle_inds);
        limits = limits(shuffle_inds);
	end
end