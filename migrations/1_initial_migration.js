const Migrations = artifacts.require("Migrations");
const Market = artifacts.require("Market");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Market);
};
