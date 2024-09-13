import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const EventManagerModule = buildModule("EventManagerModule", (m) => {
  const eventManager = m.contract("Manager");

  return { eventManager };
});

export default EventManagerModule;