classdef test_drop < matlab.unittest.TestCase
    methods (Test)
        function result = testEmptyCollections(c)
            c.assertEqual(drop(1,{}),{})
            c.assertEqual(drop(1,[]),[])

            % struct returns a 1x1 struct with no fields...
            X = struct();
            X = X([]);

            c.assertEqual(drop(1,X), X);
        end

        function result = testBasicUse(c)
            X = 1:10;
            Y = num2cell(X); 
            
            for k = 0:10
                c.assertEqual(drop(k, X), X((k+1):10))
                c.assertEqual(drop(k, Y), Y((k+1):10))
            end
        end
    end
end