% X = generate(f,input_args)
%
% Create a collection X using f to generate the elements so that
% X{k} = f(args_k{:}) 
%            where args_k is a cell of the elements of input_args{k} 
%            or input_args(k,:) depending on the type of input_args
% 
% Differs from MAP in a few ways.
%  1) container type is not assumed to be the same as input_args
%  2) inputs to f are not vector inputs, but rather separate arguments
function X = generate(f, inputs, uniform_q)
    if nargin < 3 || isempty(uniform_q)
        uniform_q = false;
    end

    if isnumeric(inputs)
        if numdims(inputs) == 1
            inputs = inputs(:);
        end
        if numdims(inputs) > 2
            error('numdims(inputs) must be 1 or 2');
        end

        nIn  = size(inputs,1);
        nArg = size(inputs,2);
        X = cell(nIn,1);
        for k = 1:nIn
            [args{1:nArg}] = dealVec(inputs(k,:));
            X{k} = f(args{:});
        end

    elseif iscell(inputs)
        nIn  = numel(inputs);
        X = cell(nIn,1);
        for k = 1:nIn
            X{k} = f(inputs{k}{:});
        end
    else
        error('Unsupported input type.')
    end

    if uniform_q
        X = cat(1,X{:});
    end
end