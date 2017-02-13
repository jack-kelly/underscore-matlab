% Returns a set of indices slicing an N dimensional array
% along the d-th dimension with index k
% 
% Example:
% 
% >> dim_slice(3,2,3)
% 
% ans =
%    {':',3,':'}
% 
% >> dim_slice(5,4,1)
% 
% ans =
%    {':',':',':',':',1}
function result = dim_slice(N,d,k)
    result = cell(1,N);
    [result{1:N}] = deal(':');
    result{d} = k;
end