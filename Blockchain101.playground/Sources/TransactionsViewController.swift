import UIKit

public class TransactionsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public let cellReuseIdentifier = "TransactionItemCell"
    public let cellHeight = CGFloat(75)
    public var backgroundImageView: UIImageView!
    public var buildingImageView: UIImageView!
    public var tableView: UITableView!
    public var headerView: UIView!
    public var headerTitleLabel: UILabel!
    public var headerSubtitleLabel: UILabel!
    public var blockItem: Block?
    
    public convenience init(blockItem: Block) {
        self.init()
        self.blockItem = blockItem
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
        headerTitleLabel.text = "Block 🗃"
        headerTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerTitleLabel.sizeToFit()
        headerSubtitleLabel.textColor = UIColor.white
        headerSubtitleLabel.text = "\(blockItem?.hashValue ?? 0)"
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
        return blockItem?.transactionItems.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionItemCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
                return TransactionItemCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
            }
            return cell as! TransactionItemCell
        }()
        adjustCellLayout(cell)
        if let transactionItem = self.blockItem?.transactionItems[indexPath.row] {
            cell.itemFromLabel?.text = transactionItem.from
            cell.itemToLabel?.text = transactionItem.to
            cell.itemAmountLabel?.text = "\(transactionItem.amount)"
        }
        return cell
    }
    
    func adjustCellLayout(_ cell: TransactionItemCell) {
        cell.itemView.frame = CGRect(x: 20,
                                     y: 10,
                                     width: tableView.frame.width - 20 * 2,
                                     height: cellHeight - 10 * 2)
        let descLabels: [UILabel] = [cell.itemFromDescLabel,
                                     cell.itemToDescLabel,
                                     cell.itemAmountDescLabel]
        descLabels.enumerated().forEach {
            let width = cell.itemView.frame.width / 3
            let frame = CGRect(x: CGFloat($0) * width,
                               y: 10,
                               width: width,
                               height: 15)
            $1.frame = frame
        }
        let contentLabels: [UILabel] = [cell.itemFromLabel,
                                        cell.itemToLabel,
                                        cell.itemAmountLabel]
        contentLabels.enumerated().forEach {
            let width = cell.itemView.frame.width / 3
            let frame = CGRect(x: CGFloat($0) * width,
                               y: cell.itemFromDescLabel.frame.maxY,
                               width: width,
                               height: 20)
            $1.frame = frame
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //        let viewController = TransactionsViewController()
    //        viewController.blockItem = self.blockchain?.blockItems[indexPath.row]
    //        self.navigationController?.pushViewController(viewController, animated: true)
    //    }
    
}
