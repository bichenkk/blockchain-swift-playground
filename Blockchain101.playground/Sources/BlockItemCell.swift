import UIKit

class BlockItemCell: UITableViewCell {
    
    public var itemArrowImageView: UIImageView!
    public var itemView: UIView!
    public var itemHashView: UIView!
    public var itemNameLabel: UILabel!
    public var itemTransacionDescLabel: UILabel!
    public var itemTransacionLabel: UILabel!
    public var itemSpentDescLabel: UILabel!
    public var itemSpentLabel: UILabel!
    public var itemDateDescLabel: UILabel!
    public var itemDateLabel: UILabel!
    public var itemHashDescLabel: UILabel!
    public var itemHashLabel: UILabel!
    
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
        // item arrow image view
        let itemArrowImage = UIImage(named: "arrow")
        itemArrowImageView = UIImageView(image: itemArrowImage)
        itemArrowImageView.contentMode = .scaleAspectFit
        addSubview(itemArrowImageView)
        // item view
        itemView = UIView()
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = 10
        itemView.backgroundColor = UIColor.white
        addSubview(itemView)
        // item hash view
        itemHashView = UIView()
        itemHashView.backgroundColor = UIColor.themeBlue
        itemView.addSubview(itemHashView)
        addSubview(itemView)
        // item name label
        itemNameLabel = UILabel()
        itemNameLabel.text = "Block"
        itemNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        itemNameLabel.textAlignment = .center
        itemNameLabel.sizeToFit()
        itemView.addSubview(itemNameLabel)
        // desc label
        itemTransacionDescLabel = UILabel()
        itemTransacionDescLabel.text = "Transactions"
        itemSpentDescLabel = UILabel()
        itemSpentDescLabel.text = "Total Spent"
        itemDateDescLabel = UILabel()
        itemDateDescLabel.text = "Created At"
        itemHashDescLabel = UILabel()
        itemHashDescLabel.text = "Hash"
        let descLabels: [UILabel] = [itemTransacionDescLabel,
                                     itemSpentDescLabel,
                                     itemDateDescLabel,
                                     itemHashDescLabel]
        descLabels.forEach {
            $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
            $0.textColor = .gray
            $0.textAlignment = .center
            $0.sizeToFit()
            itemView.addSubview($0)
        }
        // content label
        itemTransacionLabel = UILabel()
        itemSpentLabel = UILabel()
        itemDateLabel = UILabel()
        itemHashLabel = UILabel()
        let contentLabels: [UILabel] = [itemTransacionLabel,
                                        itemSpentLabel,
                                        itemDateLabel,
                                        itemHashLabel]
        contentLabels.forEach {
            $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .center
            $0.sizeToFit()
            itemView.addSubview($0)
        }
        itemHashView.addSubview(itemHashDescLabel)
        itemHashView.addSubview(itemHashLabel)
        itemHashDescLabel.textColor = .white
        itemHashLabel.textColor = .white
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        itemView.backgroundColor = UIColor.white
        itemHashView.backgroundColor = UIColor.themeBlue
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        itemView.backgroundColor = UIColor.white
        itemHashView.backgroundColor = UIColor.themeBlue
    }
    
}
