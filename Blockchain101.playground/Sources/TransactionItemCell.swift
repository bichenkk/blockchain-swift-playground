import UIKit

class TransactionItemCell: UITableViewCell {
    
    public var itemView: UIView!
    public var itemFromDescLabel: UILabel!
    public var itemFromLabel: UILabel!
    public var itemToDescLabel: UILabel!
    public var itemToLabel: UILabel!
    public var itemAmountDescLabel: UILabel!
    public var itemAmountLabel: UILabel!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIView()
        self.selectedBackgroundView = UIView()
        // item view
        itemView = UIView()
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = 10
        itemView.backgroundColor = UIColor.white
        addSubview(itemView)
        // desc label
        itemToDescLabel = UILabel()
        itemToDescLabel.text = "To"
        itemFromDescLabel = UILabel()
        itemFromDescLabel.text = "From"
        itemAmountDescLabel = UILabel()
        itemAmountDescLabel.text = "Amount"
        let descLabels: [UILabel] = [itemToDescLabel,
                                     itemFromDescLabel,
                                     itemAmountDescLabel]
        descLabels.forEach {
            $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
            $0.textColor = .gray
            $0.textAlignment = .center
            $0.sizeToFit()
            itemView.addSubview($0)
        }
        // content label
        itemToLabel = UILabel()
        itemFromLabel = UILabel()
        itemAmountLabel = UILabel()
        let contentLabels: [UILabel] = [itemToLabel,
                                        itemFromLabel,
                                        itemAmountLabel]
        contentLabels.forEach {
            $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .center
            $0.sizeToFit()
            itemView.addSubview($0)
        }
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        itemView.backgroundColor = UIColor.white
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        itemView.backgroundColor = UIColor.white
    }
    
}
