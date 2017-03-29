classdef test_isin < matlab.unittest.TestCase
    methods (Test)
        function result = testErrorOnStruct(c)
            c.verifyError(@()isin(struct()), 'isin:nostructs')
        end

        function result = testEmptyCollections(c)
            c.assertFalse(isin({},1));
            c.assertFalse(isin([],1));
        end

        function result = testInternalEmpties(c)
            Y = {[],{}};
            c.assertTrue(isin(Y,{}));
            c.assertTrue(isin(Y,[]));
        end

        function result = testBasicUse(c)
            X = {1, 3, 'a', pi};
            c.assertTrue(isin(X,pi));
            c.assertFalse(isin(X,8));
            c.assertTrue(isin(X,'a'));
            c.assertFalse(isin(X,'pi'));
        end

        function result = testNestedValue(c)
            X = {1, 3, 'a', {pi}};
            c.assertFalse(isin(X,pi));
        end
    end
end