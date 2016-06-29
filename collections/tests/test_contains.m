classdef test_contains < matlab.unittest.TestCase
    methods (Test)
        function result = testErrorOnStruct(c)
            c.verifyError(@()contains(struct()), 'contains:nostructs')
        end

        function result = testEmptyCollections(c)
            c.assertFalse(contains({},1));
            c.assertFalse(contains([],1));
        end

        function result = testInternalEmpties(c)
            Y = {[],{}};
            c.assertTrue(contains(Y,{}));
            c.assertTrue(contains(Y,[]));
        end

        function result = testBasicUse(c)
            X = {1, 3, 'a', pi};
            c.assertTrue(contains(X,pi));
            c.assertFalse(contains(X,8));
            c.assertTrue(contains(X,'a'));
            c.assertFalse(contains(X,'pi'));
        end

        function result = testNestedValue(c)
            X = {1, 3, 'a', {pi}};
            c.assertFalse(contains(X,pi));
        end
    end
end