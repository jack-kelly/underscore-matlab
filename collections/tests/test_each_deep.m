classdef test_each_deep < matlab.unittest.TestCase
    properties
        items
    end

    methods (TestMethodSetup)
        function createItems(c)
            c.items = {};
        end
    end

    methods (TestMethodTeardown)
        % 
    end

    methods
        function addToItems(obj, x)
            n = numel(obj.items);
            obj.items{n+1} = x;
        end

        function clearItems(obj)
            obj.items = {};
        end
    end

    methods (Test)
        function result = testEmptyCollectionsSimple(c)
            X = [];
            Y = {};
            Z = struct(); Z = Z([]);

            eachfun = @(x) addToItems(c,x);

            each_deep(eachfun, X);

            c.assertEqual(c.items, {});
            c.clearItems();

            each_deep(eachfun, Y);

            c.assertEqual(c.items, {});
            c.clearItems();

            each_deep(eachfun, Z);

            c.assertEqual(c.items, {});
            c.clearItems();
        end

        function result = testEmptyCollectionsDeep(c)
            X = {[], [], []};
            Y = {{}, {}, {}};
            z = struct(); z = z([]);
            Z = {z, z, z};

            eachfun = @(x) addToItems(c,x);

            each_deep(eachfun, X);

            c.assertEqual(c.items, {});
            c.clearItems();

            each_deep(eachfun, Y);

            c.assertEqual(c.items, {});
            c.clearItems();

            each_deep(eachfun, Z);

            c.assertEqual(c.items, {});
            c.clearItems();
        end

        function result = testBasicUse(c)
            eachfun = @(x) addToItems(c,x);
            
            X = 1:10;
            each_deep(eachfun, X);
            c.assertEqual(c.items, num2cell(1:10));
            c.clearItems();

            X = {'one', 'two', 'three'};
            each_deep(eachfun, X);
            c.assertEqual(c.items, {'one', 'two', 'three'});
            c.clearItems();

            Y(1).a = 1; Y(1).b = '2';
            Y(2).a = 3; Y(2).b = '4';
            Y(3).a = 5; Y(3).b = '6';
            each_deep(eachfun, Y);
            c.assertEqual(c.items, {Y(1), Y(2), Y(3)});
            c.clearItems();
        end

        function result = testBasicUseDeep(c)
            eachfun = @(x) addToItems(c,x);
            
            X = {1,{2},{[3]},{{{4}}}};
            each_deep(eachfun, X);
            c.assertEqual(c.items, num2cell(1:4));
            c.clearItems();

            X = {{{{{{{{'one'}}}}}}}, 'two', {{'three','four'}}};
            each_deep(eachfun, X);
            c.assertEqual(c.items, {'one', 'two', 'three','four'});
            c.clearItems();

            each_deep(eachfun, X,true);
            c.assertEqual(c.items, num2cell('onetwothreefour'));
            c.clearItems();
        end        
    end
end