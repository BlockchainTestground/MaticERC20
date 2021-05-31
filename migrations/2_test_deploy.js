
const MyERC777 = artifacts.require("MyERC777");

module.exports = function (deployer) {
  deployer.deploy(MyERC777);
};
