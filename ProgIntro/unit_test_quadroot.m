function unit_test_quadroot()

    res = [
        sort(quadroot(1,2,1)) == [-1,-1]
        sort(quadroot(1,0,-4)) == [-2,2]
        sort(quadroot(1,-3,2)) == [1,2]
        sort(quadroot(1,5,6)) == [-3,-2]
        sort(quadroot(1,-5,6)) == [2,3]
        sort(quadroot(2,-10,12)) == [2,3]
        ];

    assert(min(min(res)), 'test failed');
	disp('test pass')
end
