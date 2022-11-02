javascript:
function cleanupTable() {
    var table = document.getElementsByClassName('TransactionsTable__transaction-list___2u3Ds')[0];
    var rows = table.rows;  
    rows[0].remove()
    rows[0].remove()

    for (var j = 0; j < rows.length; j++) {
        document.getElementsByClassName('OneLinkNoTx')[0].remove()
        document.getElementsByClassName('TransactionsRow__data-cell___1SMYO TransactionsRow__running_balance___2mG6o  TransactionsRow__noRunningBalance___k5Rd4')[0].remove();
        rows[j].deleteCell(0);
        rows[j].deleteCell(0);
    }
    console.log(rows);
}
cleanupTable()

document.getElementsByClassName('OneLinkNoTx')[0].remove()
document.getElementsByClassName('TransactionsRow__data-cell___1SMYO TransactionsRow__expandCollapse___1XnN-')[0].remove();
document.getElementsByClassName('TransactionsRow__data-cell___1SMYO TransactionsRow__running_balance___2mG6o  TransactionsRow__noRunningBalance___k5Rd4')[0].remove();
document.getElementsByClassName('TransactionsRow__data-cell___1SMYO TransactionsRow__running_balance___2mG6o  TransactionsRow__noRunningBalance___k5Rd4').length

document.body.innerHTML = 
  "<html><head><title></title></head><body>" + "test" + "</body>";
window.print();

document.getElementsByClassName('OneLinkNoTx').parentNode.removeChild('OneLinkNoTx');
document.getElementsByClassName('OneLinkNoTx')[0].parentNode

document.getElementsByClassName('OneLinkNoTx')[0].parentNode.remove()
div.parentNode.removeChild(div);

document.getElementsByClassName('TransactionsTable__transaction-list___2u3Ds')[0];
document.getElementsByClassName('TransactionsTable__transaction-list___2u3Ds')[0].rows;
