classdef test_each < matlab.unittest.TestCase
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
        function result = testEmptyCollections(c)
            X = [];
            Y = {};
            Z = struct(); Z = Z([]);

            eachfun = @(x) addToItems(c,x);

            each(eachfun, X);

            c.assertEqual(c.items, {});
            c.clearItems();

            each(eachfun, Y);

            c.assertEqual(c.items, {});
            c.clearItems();

            each(eachfun, Z);

            c.assertEqual(c.items, {});
            c.clearItems();
        end

        function result = testBasicUse(c)
            eachfun = @(x) addToItems(c,x);
            
            X = 1:10;
            each(eachfun, X);
            c.assertEqual(c.items, num2cell(1:10));
            c.clearItems();

            X = {'one', 'two', 'three'};
            each(eachfun, X);
            c.assertEqual(c.items, {'one', 'two', 'three'});
            c.clearItems();

            Y(1).a = 1; Y(1).b = '2';
            Y(2).a = 3; Y(2).b = '4';
            Y(3).a = 5; Y(3).b = '6';
            each(eachfun, Y);
            c.assertEqual(c.items, {Y(1), Y(2), Y(3)});
            c.clearItems();
        end        
    end
end