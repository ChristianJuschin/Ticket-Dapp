var web3 = new Web3(Web3.givenProvider);
var contractInstance;

$(document).ready(function() {
    window.ethereum.enable().then(function(accounts){
      contractInstance = new web3.eth.Contract(abi, "0x9F11db119A151987C8088035454471871dcd8Ff4", {from: accounts[0]});
      console.log(contractInstance);
    });

    $("#get_data_button").click(fetchAndDisplay);
    $("#add_data_button").click(inputData);


});

function inputData(){
  var lastName = $("#ln_input").val();
  var surName = $("#sn_input").val();
  var age = $("#age_input").val();

  if (age > 25){
  contractInstance.methods.createCustomer(lastName, surName, age).send({value: 360000000000000000})
    .on('transactionHash', function(hash){
      console.log("tx hash");
    })
    .on('confirmation', function(confirmationNumber, receipt){
        console.log("conf");
    })
    .on('receipt', function(receipt){
      console.log(receipt);
    })
  }
  else{
    contractInstance.methods.createCustomer(lastName, surName, age).send({value: 140000000000000000})
      .on('transactionHash', function(hash){
        console.log("tx hash");
      })
      .on('confirmation', function(confirmationNumber, receipt){
          console.log("conf");
      })
      .on('receipt', function(receipt){
        console.log(receipt);
      })
  }

}

function fetchAndDisplay(){
  contractInstance.methods.ticketsLeft().call().then(function(res){
    displayInfo(res);
    console.log(res);
  });
}

function displayInfo(res){

  $("#ticketsleft_output").text(res);

}
