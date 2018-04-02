import UIKit
import PlaygroundSupport

/*:
 ⛓ Blockchain 101 with Swift Playground
 ======
 
 Blockchain is a very hot topic now with the hype of cryptocurrencies such as  Bitcoin or Ethereum. Everyone tells that blockchain is very secure with immutable data stored.
 
 In fact, blockchain is a very simple hashed linked list and it can be implemented very easily. This Swift playground is a demo for beginners to understand Blockchain easily.
 
 ![Blockchain](blockchain.png)
 
 > This is personally done by CHEN KA KIT for WWDC 2018 scholarship.
 
 */


/*:
 ## 💵 Transaction Structure
 
 It includes
 * **from**: The wallet address of sender
 * **to**: The wallet address of receiver
 * **amount**: The amount of money to transfer
 
 Note
 > It is a hashable struct which we can get a unique hashValue with the content of transaction.
 

 */

/*:
 ## 🗃 Block Structure
 
 It basically contains
 * **previousBlockHash**: The hash string of previous block
 * **transactionItems**: An array of transaction items to be recorded
 * **createdAt**: The date time when the block is created
 
 Note
 > It is a hashable struct which we can get a unique hashValue with the content of block. And if you check carefully, you will find the current hash of the block is also formed by the previous block hash.
 

 */

/*:
 ## ⛓ BlockChain
 
 It basically contains
 * **blockItems**: An array of block items recorded
 * **lastBlockHash**: The hash string of the last block
 * **add(_ newBlock: Block)**: The function to add new block into the blockchain. We simplifly it so only the block with the previous blockhash can be added to the blockchain.
 
 Note
 > when we add a new block to the Blockchain, the new block must have the identical previous block hash as the blockchain's last block hash, this makes a hashed linked list.
 

 */

/*:
 ## Blockchain Operation
 
 ### Start our blockchain
 1. Create a blockchain object.
 2. We add the blockchain object into our blockchain view controller, which helps us to view the data easier through the UITableView and we can even view the transactions recorded by each block.
 
 */

var blockchain = Blockchain()

/*:

 2. We add the blockchain object into our blockchain view controller, which helps us to view the data easier through the UITableView and we can even view the transactions recorded by each block.
 
 */

let viewController = BlockchainViewController(blockchain: blockchain)
let navigationController = BaseNavigationController(rootViewController: viewController)
PlaygroundPage.current.liveView = navigationController
PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 
 3. Create a genesis block, which is the very first block of the blockchain. (We put the first transaction to 🎩  Satoshi Nakamoto who is the creator of Bitcoin.)
 
 > In each block, the first transaction is always called Coinbase. It is a special transaction which the miner can assign a certain amount of Bitcoin to the miner himself as the reward of mining.
 
 */

let transaction0 = Transaction(from: "Coinbase", to: "Satoshi Nakamoto", amount: 50)
let genesisBlock = Block(transactionItems: [transaction0], previousBlockHash: 0)

/*:
 
 4. Add the genesis block to the blockchain.
 
 */

blockchain.add(genesisBlock)
viewController.tableView.reloadData()

/*:
 
 5. We have 1 block item in our blockchain now! 😃
 

 */

/*:
 
 ### How a transaction is recorded to blockchain
 1. 🙎🏻‍♀️ Mary wants to transfer 10 BTC to 🙋🏻‍♂️ Ken
 2. 🙎🏻‍♀️ Mary creates transaction 1 and broadcast it in the Bitcoin network.
 
 */

let transaction1 = Transaction(from: "Mary", to: "Ken", amount: 10)

/*:
 
 3. ⛏ Miners receives this transaction and they start to do mining by calculating a puzzle.
 4. The fastest miner who solved the puzzle has the right to record the transactions to a block and add it to the blockchain. Don't forget to add the coinbase transaction for miner himself!
 
 */

let block1 = Block(transactionItems: [Transaction(from: "Coinbase", to: "Miner", amount: 50),
                                      transaction1],
                   previousBlockHash: genesisBlock.hashValue)
blockchain.add(block1)
viewController.tableView.reloadData()

/*:
 
 5. A new block (block1) is Added! 😃
 

 */

/*:
 
 ### Try it again with another 2 transaction
 1. 🙋🏻‍♂️ Ken wants to buy a ☕️ coffee at Philz Coffee with 1 BTC
 2. 🙋🏻‍♂️ Ken creates transaction 2 and broadcast it in the Bitcoin network.
 
 */

let transaction2 = Transaction(from: "Ken", to: "Philz Coffee", amount: 1)

/*:
 
 3. After that, 🙋🏻‍♂️ Ken wants to buy a 🍔 In-N-Out Burger with 1 BTC
 4. 🙋🏻‍♂️ Ken creates transaction 3 and broadcast it in the Bitcoin network.
 
 */

let transaction3 = Transaction(from: "Ken", to: "In-N-Out Burger", amount: 1)

/*:
 
 5. ⛏ Miners will collect the transactions in 10 minutes and the fastest miner who solved the puzzle has the right to record this transaction to a block and add it to the blockchain.
 
 */

let block2 = Block(transactionItems: [Transaction(from: "Coinbase", to: "Miner", amount: 50),
                                      transaction2,
                                      transaction3],
                   previousBlockHash: block1.hashValue)
blockchain.add(block2)
viewController.tableView.reloadData()

/*:
 
 6. A new block (block2) is Added. 😃
 

 */

/*:
 
 ### How if Ken tries to cheat the blockchain
 1. 🙋🏻‍♂️ Ken wants to change the record of buying ☕️ coffee with 1 BTC to 0.1 BTC
 2. 🙋🏻‍♂️ Ken creates transaction 4 and broadcast it in the Bitcoin network.
 */

let transaction4 = Transaction(from: "Ken", to: "Cafe", amount: 0.1)

/*:
 3. ⛏ The fastest miner also works with Ken to cheat the blockchain and he didn't validate the transaction.
 */

let block3 = Block(transactionItems: [], previousBlockHash: block1.hashValue)
blockchain.add(block3)
viewController.tableView.reloadData()

/*:
 4. However, the block will be rejected because it is not matching the previous block hash. (Ken needs to use the hash of block 1 as the previousBlockHash because Ken has money in block 1)
 
 > In fact this case is much more complicated. We can discuss after the workshop.
 * The miner needs to have enough computing power to revert all the blocks backwards.
 
 5. Block 3 is rejected in the blockchain! 😞
 

 
 */

/*:
 
 ### 🎓 You now understand blockchain is actually a simple linked list!
 It always follows the steps
 1. Create transactions
 2. Create block with **previous block hash**
 3. Mining for Proof of work
 4. Add the block to the blockchain
 5. Done! ❤️
 
 Now try to record your new transactions into the blockchain!
 

 
 */


