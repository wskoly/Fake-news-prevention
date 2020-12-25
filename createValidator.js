for(i=0; i<10; i++)
{
    var area= ['7470','7471','7472','7473','7474','7475','7476','7477','7478','7479',];
    uap.createValidor(area[i], {from: web3.eth.accounts[i], gas:3000000});
    console.log(area[i]);
    if (localStorage) {
        localStorage.setItem('account', 0);
    } else {
        $.cookies.set('account', 0);
    }
}
    