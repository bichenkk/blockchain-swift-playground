import Foundation

public struct Transaction : Hashable {
    
    public static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    public private(set) var from: String
    public private(set) var to: String
    public private(set) var amount: Double
    public var hashValue : Int {
        get {
            return "\(from) => \(to), \(amount)".hash
        }
    }
    public init(from: String, to: String, amount: Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}
