const CampaignFactory = require("./artifacts/contracts/Campaign.sol/CampaignFactory.json");
const Campaign = require("./artifacts/contracts/Campaign.sol/Campaign.json");
const { ethers } = require("ethers");
require("dotenv").config({ path: "./.env.local" });

const main = async () => {
  const provider = new ethers.providers.JsonRpcProvider(
    process.env.NEXT_PUBLIC_RPC_URL
  );

  const contract = new ethers.Contract(
    process.env.NEXT_PUBLIC_ADDRESS,
    CampaignFactory.abi,
    provider
  );

  const getDeployedCampaign = contract.filters.campaignCreated(
    null,
    null,
    null,
    null,
    null,
    null,
    "education"
  );
  let events = await contract.queryFilter(getDeployedCampaign);
  let event = events.reverse();
  console.log(event);

  // const provider = new ethers.providers.JsonRpcProvider(
  //   process.env.NEXT_PUBLIC_RPC_URL
  // );

  // const contract = new ethers.Contract(
  //   process.env.NEXT_PUBLIC_ADDRESS,
  //   Campaign.abi,
  //   provider
  // );

  // const Donations = contract.filters.donated(
  //   "0x4B0E784Ed3aa426e2f17C5724B4815Ab2e1494aC"
  // );
  // const AllDonations = await contract.queryFilter(Donations);

  // const DonationsData = AllDonations.map((e) => {
  //   return {
  //     donar: e.args.donar,
  //     amount: parseInt(e.args.amount),
  //     timestamp: parseInt(e.args.timestamp),
  //   };
  // });

  // console.log(DonationsData);
};

main();
