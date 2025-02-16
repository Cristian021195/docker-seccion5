let times = 0;
const syncDB = () => {
    times++;
    console.log('Tick cada 5s', times);
    return times;
}

module.exports = {
    syncDB
}