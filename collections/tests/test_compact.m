classdef test_compact < matlab.unittest.TestCase
    methods (Test)
        function result = testErrorOnStruct(c)
            c.verifyError(@()compact(struct()), 'compact:nostructs')
        end

        function result = testEmptyCollections(c)
            c.assertEqual(compact({}), {});
            c.assertEqual(compact([]), []);
        end

        function result = testRemoveZeros(c)
            Y = [1 0 2 0 0 3 0 0 0 4 0 0 0 0 5];
            c.assertEqual(compact(Y), [1 2 3 4 5]);
        end

        function result = testRemoveFalse(c)
            Y = [false false true false false true];
            c.assertEqual(compact(Y), [true true]);
        end

        function result = testRemoveInternalEmpties(c)
            Y = {1,{}, [],2};
            c.assertEqual(compact(Y), {1,2});
        end

        function result = testLeaveNested(c)
            Y = {1,{{}},2};
            c.assertEqual(compact(Y),Y);
        end
    end
end