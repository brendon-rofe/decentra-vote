require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.18", // Specify the Solidity version you want to use
  networks: {
    hardhat: {
      chainId: 1337 // Set the chainId to avoid MetaMask issues during testing
    },
  },
};