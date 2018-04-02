import UIKit

public class BlockchainViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public let cellReuseIdentifier = "BlockItemCell"
    public let cellHeight = CGFloat(150)
    public var backgroundImageView: UIImageView!
    public var buildingImageView: UIImageView!
    public var tableView: UITableView!
    public var headerView: UIView!
    public var headerTitleLabel: UILabel!
    public var headerSubtitleLabel: UILabel!
    public var blockchain: Blockchain?
    
    public convenience init(blockchain: Blockchain) {
        self.init()
        self.blockchain = blockchain
        backgroundImageView = UIImageView(image: UIImage(named: "background"))
        buildingImageView = UIImageView(image: UIImage(named: "building"))
        tableView = UITableView()
        headerView = UIView()
        headerTitleLabel = UILabel()
        headerSubtitleLabel = UILabel()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildingImageView.contentMode = .scaleAspectFit
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        // add header view
        headerTitleLabel.textColor = UIColor.white
        headerTitleLabel.text = "Blockchain 101 ⛓"
        headerTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerTitleLabel.sizeToFit()
        headerSubtitleLabel.textColor = UIColor.white
        headerSubtitleLabel.text = "A Demo For Blockchain Data Structure"
        headerSubtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        headerSubtitleLabel.sizeToFit()
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(headerSubtitleLabel)
        view?.addSubview(backgroundImageView)
        view?.addSubview(buildingImageView)
        view?.addSubview(tableView)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
        headerTitleLabel.frame = CGRect(x: 20,
                                        y: 0,
                                        width: view.frame.size.width,
                                        height: headerTitleLabel.frame.height)
        headerSubtitleLabel.frame = CGRect(x: 20,
                                           y: headerTitleLabel.frame.height + 10,
                                           width: view.frame.size.width,
                                           height: headerSubtitleLabel.frame.height)
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.size.width,
                                  height: 10 * 2 + headerTitleLabel.frame.height + headerSubtitleLabel.frame.height)
        tableView.tableHeaderView = headerView
        backgroundImageView.frame = view.frame
        if let buildingImage = buildingImageView.image {
            let buildingImageProportion = buildingImage.size.width / buildingImage.size.height
            let buildingImageViewFrame = CGRect(x: 0,
                                                y: view.frame.height - view.frame.width / buildingImageProportion,
                                                width: view.frame.size.width,
                                                height: view.frame.width / buildingImageProportion)
            buildingImageView.frame = buildingImageViewFrame
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockchain?.blockItems.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BlockItemCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
                return BlockItemCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
            }
            return cell as! BlockItemCell
        }()
        adjustCellLayout(cell)
        cell.itemArrowImageView.isHidden = indexPath.row == 0
        if let blockItem = self.blockchain?.blockItems[indexPath.row] {
            cell.itemNameLabel.text = indexPath.row == 0 ? "Genesis Block" : "Block \(indexPath.row)"
            cell.itemTransacionLabel?.text = "\(blockItem.transactionItems.count)"
            let spent = blockItem.transactionItems.reduce(0, { (result, transaction) -> Double in
                return result + transaction.amount
            })
            cell.itemSpentLabel?.text = "\(spent) BTC"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
            cell.itemDateLabel?.text = dateFormatter.string(from: blockItem.createdAt)
            cell.itemHashLabel?.text = "\(blockItem.hashValue)"
        }
        return cell
    }
    
    func adjustCellLayout(_ cell: BlockItemCell) {
        cell.itemArrowImageView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: tableView.frame.width,
                                               height: 10)
        cell.itemView.frame = CGRect(x: 20,
                                     y: 20,
                                     width: tableView.frame.width - 20 * 2,
                                     height: cellHeight - 10 * 3) // 120
        cell.itemNameLabel.frame = CGRect(x: 0,
                                          y: 0,
                                          width: cell.itemView.frame.width,
                                          height: 30)
        let descLabels: [UILabel] = [cell.itemTransacionDescLabel,
                                     cell.itemSpentDescLabel,
                                     cell.itemDateDescLabel]
        descLabels.enumerated().forEach {
            let width = cell.itemView.frame.width / 3
            let frame = CGRect(x: CGFloat($0) * width,
                               y: cell.itemNameLabel.frame.maxY,
                               width: width,
                               height: 15)
            $1.frame = frame
        }
        let contentLabels: [UILabel] = [cell.itemTransacionLabel,
                                        cell.itemSpentLabel,
                                        cell.itemDateLabel]
        contentLabels.enumerated().forEach {
            let width = cell.itemView.frame.width / 3
            let frame = CGRect(x: CGFloat($0) * width,
                               y: cell.itemTransacionDescLabel.frame.maxY,
                               width: width,
                               height: 20)
            $1.frame = frame
        }
        cell.itemHashView.frame = CGRect(x: 0,
                                         y: cell.itemTransacionLabel.frame.maxY + 10,
                                         width: cell.itemView.frame.width,
                                         height: 50)
        cell.itemHashDescLabel.frame = CGRect(x: 0,
                                              y: 5,
                                              width: cell.itemView.frame.width,
                                              height: 15)
        cell.itemHashLabel.frame = CGRect(x: 0,
                                          y: cell.itemHashDescLabel.frame.maxY,
                                          width: cell.itemView.frame.width,
                                          height: 20)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let block = blockchain?.blockItems[indexPath.row] {
            let viewController = TransactionsViewController(blockItem: block)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
