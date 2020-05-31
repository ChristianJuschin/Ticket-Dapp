pragma solidity 0.5.12;

contract Tickets{


    address internal owner;

    modifier onlyOwner(){
      require(msg.sender == owner);
      _;
    }

    constructor() public {
      owner = msg.sender;
    }

    function endContract() public onlyOwner {
    selfdestruct(msg.sender);
    }


    struct Customer{
        address payable money;
        uint id;
        string lastName;
        string surName;
        uint age;
        bool young;
    }

    uint private balance;

    Customer [] private contacters;

    function createCustomer(string memory lastName, string memory surName, uint age) public payable{

        require(contacters.length<100);

        balance += msg.value;

        Customer memory newCustomer;
        newCustomer.lastName = lastName;
        newCustomer.surName = surName;
        newCustomer.age = age;

        if(age <= 25){
            newCustomer.young = true;
            require(msg.value >= 140000000000000000 wei);
        }
        else {
            newCustomer.young = false;
            require(msg.value >= 360000000000000000 wei);
        }
        newCustomer.money = msg.sender;

        contacters.push(newCustomer);

    }


    function getCustomer(uint index) public view onlyOwner returns(string memory lastName, string memory surName, uint age, address money){

        return (contacters[index].lastName, contacters[index].surName, contacters[index].age, contacters[index].money);

    }

    function withdrawAll() public onlyOwner{

        uint toTransfer = balance;
        balance = 0;
        msg.sender.transfer(toTransfer);

    }

    function ticketsLeft() public view returns(uint count) {

        count = 100 - contacters.length;
        return count;

    }

    function deleteCustomer (uint index) public onlyOwner {

        if (contacters[index].age <= 25){
            balance = balance - 140000000000000000 wei;
            contacters[index].money.transfer(140000000000000000 wei);
        }
        else {
            balance = balance - 360000000000000000 wei;
            contacters[index].money.transfer(360000000000000000 wei);
        }

        delete contacters[index];

    }

}
