// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit

public final class UIKitDesingImpl: UITableViewController {
    private lazy var models: [UIKitDesingImplDataModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    convenience init(models: [UIKitDesingImplDataModel]) {
        self.init(nibName: nil, bundle: nil)
        self.models = models
        tableView.register(UIKitDesingCell.self, forCellReuseIdentifier: UIKitDesingCell.reuseIdentifier)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIKitDesingCell.reuseIdentifier, for: indexPath) as? UIKitDesingCell else {
            return UITableViewCell()
        }
        setup(cell: cell, with: models[indexPath.row])
        return cell
    }
    
    private func setup(cell: UIKitDesingCell, with model: UIKitDesingImplDataModel) {
        cell.nameLabel.text = model.name
        cell.surnameLabel.text = model.surname
        cell.userImage = model.image
    }
}
