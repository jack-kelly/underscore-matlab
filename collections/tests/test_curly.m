classdef test_curly < matlab.unittest.TestCase
    methods (Test)
        function result = testOnlyCell(c)
            c.verifyError(@()curly(struct(),1), 'curly:noncell')
            c.verifyError(@()curly(1,1), 'curly:noncell')
            c.verifyError(@()curly(matlab.unittest.TestResult,1),'curly:noncell')
        end

        function result = testSimpleIndices(c)
            X = {1,2,'a',pi,{3}};

            c.assertEqual(curly(X,1),1)
            c.assertEqual(curly(X,2),2)
            c.assertEqual(curly(X,3),'a')
            c.assertEqual(curly(X,4),pi)
            c.assertEqual(curly(X,5),{3})
        end

        function result = testColon(c)
            X = {1, 2, 3, 4, 'duck'};
            
            A = curly(X,':');
            c.assertEqual(A, 1);

            [A,B] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 2);

            [A,B,C] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 2);
            c.assertEqual(C, 3);

            [A,B,C,D] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 2);
            c.assertEqual(C, 3);
            c.assertEqual(D, 4);

            [A,B,C,D,E] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 2);
            c.assertEqual(C, 3);
            c.assertEqual(D, 4);
            c.assertEqual(E, 'duck');
        end

        function result = testColonHigherDimensions(c)
            X = {1,2;'a','b'};
            
            A = curly(X,':');
            c.assertEqual(A, 1);

            [A,B] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 'a');

            [A,B,C] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 'a');
            c.assertEqual(C, 2);

            [A,B,C,D] = curly(X,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 'a');
            c.assertEqual(C, 2);
            c.assertEqual(D, 'b');

            [A,B] = curly(X,':',1);
            c.assertEqual(A, 1);
            c.assertEqual(B, 'a');

            [A,B] = curly(X,':',2);
            c.assertEqual(A, 2);
            c.assertEqual(B, 'b');

            [A,B] = curly(X,1,':');
            c.assertEqual(A, 1);
            c.assertEqual(B, 2);

            [A,B] = curly(X,2,':');
            c.assertEqual(A, 'a');
            c.assertEqual(B, 'b');

        end
    end
end