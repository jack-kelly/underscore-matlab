underscore-matlab
=======

This is an experimental set of functional programming tools. There are many of the usual suspects (`map`, `reduce`, `foldl`, etc.) and some less common, but more specifically MATLAB things.

This all was motivated by a desire to have a Mathematica-like `manipulate` function. The early version of this included in the library. Most functions should have at least a basic `help ...` description.

NOTES:

- This was not designed with speed in mind. Full performance evaluations have not been done.

- `each_deep` and `flatten` rely on some unsupported java hacks. This comes with the standard "This could stop working at any time" disclaimer.

Feel free to submit bug reports or give suggestions.