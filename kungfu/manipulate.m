function h = manipulate(f, lims, varargin)
	[f, vars, lims, steps] = validate(f, lims, varargin{:});

	% Find all non-manipulate figures before we call the function for the first time
	root_children_init = get(groot,'Children');

	if ~isempty(root_children_init)
		valid_figure_inds = cell2mat(map(@(s)not(strcmp(s,'Manipulate Slider')), {root_children_init.Name}));
		root_children_init = root_children_init(valid_figure_inds);
	end

	h                  = figure;
	h.NextPlot         = 'new';
	h.ToolBar          = 'none';
	h.Name             = 'Manipulate Slider'
	h.NumberTitle      = 'off';
	% h.HandleVisibility = 'off';

	N = numel(vars);
    
	var_map = containers.Map();

	for k = 1:N

		[lo, hi] = deal(lims{k}{:});

		uicontrol('Style','text', ...
				  'Units', 'normalized', ...
				  'Position', [0.001, 1 - k/N,0.19,1/N], ...
				  'String', vars{k});

		slider = uicontrol('Style', 'Slider', ...
							'Min', lo, 'Max', hi, 'Value', lo, ...
							'SliderStep', [steps{k} steps{k}], ...
						 	'Units', 'normalized', ...
						 	'Position',[0.2, 1 - k/N,0.60,1/N], ...
						 	'Callback', curry_n(@slider_callback,f,vars{k}));
		
		text   = uicontrol('Style', 'edit', ...
						   'String', num2str(lo), ...
						   'Units', 'normalized', ...
				 	       'Position',[0.80, 1 - k/N,0.18,1/N], ...
				 	       'Callback', curry_n(@text_callback,f,vars{k}));

		h.WindowScrollWheelFcn = curry(@scrollwheel_callback, f);

		var_map(vars{k}) = struct('slider', slider, 'text', text, 'min',lo, 'max', hi, 'value', lo, 'step', steps{k} );
	end
	
	% Set up the data that will be held in the manipulate slider.
	h.UserData.var_map = var_map;
	h.UserData.vars    = vars;
	h.UserData.fig     = [];
	
	eval_manipulated(f,h.UserData)

	% Find out what figures the manipulate function created.
	root_children_post = get(groot,'Children');
	if ~isempty(root_children_post)
		valid_figure_inds = cell2mat(map(@(s)not(strcmp(s,'Manipulate Slider')), {root_children_post.Name}));
		root_children_post = root_children_post(valid_figure_inds);
	end

	% Find any new figures since we evaluated the manipulated function
	manipulate_figs = setdiff(root_children_post, root_children_init);

	% Not sure how to handle the dynamic "switching between figures" yet
	assert(numel(manipulate_figs) < 2,'Manipulate:numFigs','Functions creating more than 1 figure are not currently supported.')

	h.UserData.fig     = head(manipulate_figs);
	
	% Make initial size a little nicer.
	h.Position(end) = 20*N;
end

function eval_manipulated(f,user_data)
	args = map(@(v) user_data.var_map(v).value, user_data.var_map.keys );
	
	if ~isempty(user_data.fig) 
		figure(user_data.fig); 
	end
	
	f(args{:})
end

function slider_callback(f,variable, source, data)
	h = source.Parent;
	
	v = source.Value;
	v = clamp(v, [h.UserData.var_map(variable).min h.UserData.var_map(variable).max]);
	source.Value = v;
    
    var_data = h.UserData.var_map(variable);
    var_data.value = v;
    var_data.text.String = num2str(v);

	h.UserData.var_map(variable) = var_data;

	eval_manipulated(f,h.UserData);
end

function text_callback(f,variable, source, data)
	h = source.Parent;
	v = real(str2double(source.String));

	v = clamp(v, [h.UserData.var_map(variable).min h.UserData.var_map(variable).max]);

	source.String = num2str(v);

    var_data = h.UserData.var_map(variable);
    var_data.value = v;
    var_data.slider.Value = v;
    
    h.UserData.var_map(variable) = var_data;
    
	eval_manipulated(f,h.UserData);
end

function scrollwheel_callback(f, source, data)
	N = numel(source.UserData.vars);
	k = clamp(ceil(N * (1 - source.CurrentPoint(2)/source.Position(4))), [1 N]);

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

function [f,vars, limits, steps] = validate(f,lims,varargin)
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

	functionVars = get_input_vars(f);

	% If the function doesn't take varargin, make sure the variables
	% match what the user put in, otherwise, sort the input ranges to
	% match up with the argument order for the function
	if not(isequal(functionVars,{'varargin'}))
		if ~isequal(sort(vars), sort(get_input_vars(f))) 
			error('Variable name mismatch. Make sure your variables used in the limits are the same as in the function.');
		end

		shuffle_inds = zeros(size(vars));

		for k = 1:numel(vars)
			shuffle_inds(k) = find(cell2mat(map(@(s)isequal(vars{k},s),functionVars) ));
		end

		vars = vars(shuffle_inds);
		lims = lims(shuffle_inds);
	end
end