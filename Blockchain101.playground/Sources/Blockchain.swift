import Foundation

public class Blockchain {
    public private(set) var blockItems: [Block] = [Block]()
    public private(set) var lastBlockHash = 0
    public func add(_ newBlock: Block) {
        if lastBlockHash == 0 || lastBlockHash == newBlock.previousBlockHash {
            blockItems.append(newBlock)
            lastBlockHash = newBlock.hashValue
            print("Added a block with hash:\(lastBlockHash)")
        } else {
            print("Failed to add a block with hash:\(newBlock.hashValue)")
        }
    }
    public init() {}
}
