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
%	>> Y();
%
%	is equivalent to
%
%	>> f();
%	>> g();
%	>> h();
%
%	NOTE: Does NOT return any values.
%
%	Will error if collection cannot contain
%	return type of fun (usually from non-numeric 
%	functions mapped to numeric arrays).
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
%-------------------------------------------------------------------------------
%}
function out = chain(varargin)
	out = @() each(@(f)f(), varargin);
end