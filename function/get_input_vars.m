%{
	Get the input variables as they are written in an anonymous function.

	e.g.

	getInputVars(@(A,phi,derp) disp({A,phi,derp}) )
	ans = 
    	'A'    'phi'    'derp'

%}
function out = getInputVars(func)
	s = func2str(func);
	T = mtree(s);

	%{ 
	An anonmyous function's string looks like:
	@(arg1, ... , argN) func(...)
	 
	The parse tree of the string representation of func
	will have the "Left" node be the arguments,    i.e. the "@(arg1, ..., argN)" part
	and the "Right" node will be the call pattern, i.e. the "func(...)"          part

	List() just grabs all the nodes from that position, i.e. {arg1, ..., argN}
	instead of just arg1.
	%}
	arg_node  = select(Arg(T), head(indices(Arg(T))));
	var_nodes = List(arg_node.Left);
	tree_inds = indices(var_nodes);

	out = cell(size(tree_inds));

	for k = 1:numel(out)
		out{k} = tree2str(select(var_nodes,tree_inds(k)));
	end
end