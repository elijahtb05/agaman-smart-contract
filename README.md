# agaman-smart-contract
Smart Contract created for BUSA3007 Assignment
Lines 1-10 declares the license for the code, says the contract needs to be with 0.8.2 or newer.

Lines 10-13 begins the smart contract definition, stores the wallet address of who deployed the ransaction, and stores the wallet address that represents a dummy central bank wallet.

Lines 14-21 defines a custom data structure named remittance.

Lines 23-24 creates a public array that stores every remittance record ever added.

Lines 25-32 defines an even that gets emitted when a remittance is made 

Line 34-39 sets the deployer as the owner, and sets a hardcoded dummy wallet address to act as the central bank wallet.

Lines 41-49 defines a function that anyone can call to send a dummy remittance. 

Line 50 prevents users from calling the function with zero funds.

Lines 52-54 sends the attached ETH/native coin to the dummy central bank wallet, then reverts the whole transaction if the transfer does not work.

Lines 56-65 adds a new remittance record into the array.

Lines 67-74 fires the event after the remittance is stored, then uses the array index of the newly inserted remittance as its ID.

Lines 77-79 creates a read-only function that returns how many remittance records exist, then gives total number of stored remittances.

Lines 81-91 defines another read-only function that fetches one remittance by its ID/index.

Lines 92-101 loads the selected remittance from storage into temporary memory, then returns each field from that remittance one by one.

Line 102 ends the contract.
