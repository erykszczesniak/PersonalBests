import UIKit

class RunnerListVC: UIViewController {
    
    var runnerTable = UITableView()
    var runnerService = RunnerService()
    var runners: [Runner] = []
    
    var searchBar = UISearchBar()
    var isSearching: Bool = false
    var searchResults: [Runner] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Runner"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(create))
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reloadNotification"), object: nil)
        self.setupSearchBar()
        self.setupRunnerTable()
        self.getAllRunners()
    }
    
    @objc func refresh(sender: UIRefreshControl){
        self.getAllRunners()
        sender.endRefreshing()
    }
    
    @objc func reload(notification: NSNotification){
        self.getAllRunners()
    }
    
    @objc func create() {
        let addRunnerVC = AddRunnerVC()
        addRunnerVC.title = "Add Runner"
        self.navigationController?.pushViewController(addRunnerVC, animated: true)
    }
    
    func getAllRunners() {
        runnerService.getAllRunners() { (res) in
            switch res {
            case .success(let runners):
                self.runners = runners
                self.runnerTable.reloadData()
            case .failure(_):
                self.showAlert(withTitle: "Network Error",
                    withMessage: "Failed to get Runner:",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
            }
        }
    }
    
    func deleteRunner(id: Int) {
        runnerService.deleteRunner(id: id) { (res) in
            switch res {
            case .success(_):
                self.getAllRunners()
            case .failure(_):
                self.showAlert(withTitle: "Network Error",
                    withMessage: "Failed to delete Runner:",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
            }
        }
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor)
        searchBar.placeholder = " Search..."
        searchBar.delegate = self
    }
    
    func setupRunnerTable() {
        view.addSubview(runnerTable)
        setRunnerTableDelegates()
        runnerTable.frame = self.view.frame
        runnerTable.rowHeight = UITableView.automaticDimension
        runnerTable.register(RunnerCell.self, forCellReuseIdentifier: "RunnerCell")
        runnerTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        runnerTable.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
    
    func setRunnerTableDelegates() {
        runnerTable.delegate = self
        runnerTable.dataSource = self
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension RunnerListVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return searchResults.count
        }
        return runners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = runnerTable.dequeueReusableCell(withIdentifier: "RunnerCell") as! RunnerCell
        let runner = runners[indexPath.row]
        if(isSearching){
            cell.setRunner(runner: searchResults[indexPath.row])
        } else {
            cell.setRunner(runner: runner)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            let runnerId = self.runners[indexPath.row].id
            self.deleteRunner(id: runnerId ?? 0)
        })
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addRunnerVC = AddRunnerVC()
        addRunnerVC.runner = self.runners[indexPath.row]
        addRunnerVC.title = "Edit Runner"
        self.navigationController?.pushViewController(addRunnerVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if(textSearched == "") {
            dismissKeyboard()
            isSearching = false
            runnerTable.reloadData()
        } else {
            isSearching = true
            searchResults = runners.filter {
                $0.name!.range(of: textSearched, options: .caseInsensitive) != nil
            }
            runnerTable.reloadData()
        }
    }
}
