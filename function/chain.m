% CHAIN - create a function that executes functions in sequence.
%{
%-------------------------------------------------------------------------------
%	out = chain(fun1, [fun2, ... ,funN]  )
%
%	Chain together a sequence of functions (fun1 ... funN) to evalaute in
%	turn. 
%
%	For example, consider the functions f, g and, h.
%	If we call Y = chain(f,g,h), then
%
%	>> Y(a, b, c, ... );
%
%	is equivalent to
%
%	>> f(a, b, c, ... );
%	>> g(a, b, c, ... );
%	>> h(a, b, c, ... );
%
%	NOTE: Does NOT return any values.
%
%	USAGE:
%
%	>> f = chain(@()disp(1), @()disp(2), @()disp(3))
%	f = 
%	    @()each(@(f)f(),varargin)
%	>> f()
%	     1
%	     2
%	     3
%   >> F = chain(@(a,b,c)disp(a+b), @(a,b,c)disp(b+c), @(a,b,c)disp(c+a))
%   F = 
%       @(varargin)each(@(f)f(varargin{:}),funcs)
%   >> F(1,2,3)
%        3
%        5
%        4
%-------------------------------------------------------------------------------
%}
function out = chain(varargin)
    funcs = varargin; clear varargin;
	out = @(varargin) each(@(f)f(varargin{:}), funcs);
end