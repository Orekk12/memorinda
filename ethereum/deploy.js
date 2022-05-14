const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const compiledEventFactory = require('./build/EventFactory.json');

const provider = new HDWalletProvider(
  'call glow acoustic vintage front ring trade assist shuffle mimic volume reject',
  `https://rinkeby.infura.io/${process.env.RINKEBY_KEY}`
);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0]);

  const result = await new web3.eth.Contract(
    JSON.parse(compiledEventFactory.interface)
  )
    .deploy({ data: compiledEventFactory.bytecode })
    .send({ gas: '1000000', from: accounts[0] });

  console.log('Contract deployed to', result.options.address);
};
deploy();