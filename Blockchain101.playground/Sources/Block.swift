import Foundation

public struct Block : Hashable {
    public static func ==(lhs: Block, rhs: Block) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    public private(set) var previousBlockHash: Int
    public private(set) var transactionItems: [Transaction]
    public private(set) var createdAt: Date
    public var hashValue : Int {
        get {
            var hash = previousBlockHash
            transactionItems.forEach{ hash += $0.hashValue }
            return "\(hash)".hash
        }
    }
    public init(transactionItems:[Transaction], previousBlockHash: Int) {
        self.transactionItems = transactionItems
        self.previousBlockHash = previousBlockHash
        self.createdAt = Date()
    }
}
