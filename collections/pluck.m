function out = pluck(field, struct_array)
	out = {struct_array(:).(field)};
end