if (typeof web3 !== 'undefined') {
	web3 = new Web3(web3.currentProvider);
} else {
	// set the provider you want from Web3.providers
	web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

web3.eth.defaultAccount = web3.eth.accounts[0];

var uapContract = web3.eth.contract([
	{
		"constant": false,
		"inputs": [],
		"name": "validatorWeight",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getNewsCount",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_area",
				"type": "string"
			}
		],
		"name": "createValidor",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_newsID",
				"type": "string"
			},
			{
				"name": "_personalR",
				"type": "string"
			}
		],
		"name": "giveRating",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_title",
				"type": "string"
			},
			{
				"name": "_message",
				"type": "string"
			},
			{
				"name": "_area",
				"type": "string"
			}
		],
		"name": "createNews",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "validatorRating",
		"outputs": [
			{
				"name": "id",
				"type": "uint256"
			},
			{
				"name": "newsId",
				"type": "uint256"
			},
			{
				"name": "vId",
				"type": "uint256"
			},
			{
				"name": "areaWeight",
				"type": "uint256"
			},
			{
				"name": "pRating",
				"type": "uint256"
			},
			{
				"name": "finalRating",
				"type": "uint256"
			},
			{
				"name": "vAddress",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_id",
				"type": "uint256"
			}
		],
		"name": "getNews",
		"outputs": [
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "vRatingTracker",
		"outputs": [
			{
				"name": "newsId",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "newses",
		"outputs": [
			{
				"name": "id",
				"type": "uint256"
			},
			{
				"name": "title",
				"type": "string"
			},
			{
				"name": "message",
				"type": "string"
			},
			{
				"name": "area",
				"type": "string"
			},
			{
				"name": "rating",
				"type": "uint256"
			},
			{
				"name": "finalRating",
				"type": "uint256"
			},
			{
				"name": "isRated",
				"type": "bool"
			},
			{
				"name": "ratingCount",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "validators",
		"outputs": [
			{
				"name": "id",
				"type": "uint256"
			},
			{
				"name": "pWeight",
				"type": "uint256"
			},
			{
				"name": "area",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	}
]);

var uap = uapContract.at('0x95451F1316c394543B77033D167a4062cbce25F2');
console.log(uap);
balance = web3.eth.getBalance(web3.eth.accounts[0]);
console.log(balance);