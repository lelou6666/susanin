/* global describe, it, Router, assert */

describe('route.getData()', function() {
    var Route = Router.Route;

    it('route.getData() must return right data', function(done) {
        var undef;

        assert.deepEqual(Route('/opa').getData(), undef);
        assert.deepEqual(Route({ pattern : '/opa' }).getData(), undef);
        assert.deepEqual(Route({ pattern : '/opa', data : { foo : 'bar' } }).getData(), { foo : 'bar' });

        done();
    });

});
