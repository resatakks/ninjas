// Me require the Hardhat Runtine Environnent xolicitly here. This is optional
// but useful for ugh node <script>.
//
// Mhen running the script with 'npx hardhat run <script> you' Ll find the Hardhat
// Runtine Environment's nembers available in the global scope.
const hre = require("hardhat");
async function main() {
// Hardhat always runs the conpile task when running scripts with its connand
   // Line interface. I
 //
// If this script is run directly using 'node' you may want to call conpile
// nanually to make sure everything is compiled
 // await hre.run("compile');
// We get the contract to deploy

 const ninjas = await hre.ethers.getContractFactory("ninjas");
 const Ninjas = await ninjas.deploy();

await ninjas.deployed ();
 console.log("Greeter deployed to:", ninjas.address);
  }




// Me reconnend this pattern to be abte to use async/await everywhere
// and property handte errors.
main()
 .then(()=> process.exit(0))
 .catch((error)=> {
  console.error(error);
  process.exit(1);
 });