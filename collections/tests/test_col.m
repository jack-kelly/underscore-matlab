classdef test_col < matlab.unittest.TestCase
    methods (Test)
        function result = testEmptyCollections(c)
            c.assertEqual(col({}), cell(0,1));
            c.assertEqual(col([]), zeros(0,1));
            c.assertEqual(col(struct()), struct());
        end

        function result = testRandomArray(c)
            for k = 1:20
                X = rand(randi(5,1,randi(5)));
                c.assertEqual(col(X), X(:));
            end
        end

        function result = testRandomCell(c)
            for k = 1:20
                X = num2cell(rand(randi(5,1,randi(5))));
                c.assertEqual(col(X), X(:));
            end
        end

        function result = testRandomStruct(c)
            for k = 1:20
                clear X;
                ind = num2cell(randi(5,1,randi(5)));
                X(ind{:}).a = 1;
                c.assertEqual(col(X), X(:));
            end
        end
    end
end