const { syncDB } = require("../../tasks/sync-db");

describe('Pruebas en syncDB', ()=>{

    test('Debe ejecutarse dos veces', ()=>{
        syncDB();
        const times = syncDB();
        expect(times).toBe(2);
    })

});