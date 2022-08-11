

import UIKit

protocol HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(id: String)
}

protocol HomeResponseProtocol {
    func onContactList(contact: [Contact])
    func onContactDelete(isDeleted: Bool)
}

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {
 
    
    var presenter: HomeRequestProtocol!
    @IBOutlet weak var tableView: UITableView!
    var items: Array<Contact> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }


    
    // MARK: - METHODS
    
    func initView(){
        initNavigation()
        configureViper()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.apiContactList()
    }
    
    func initNavigation(){
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Contact list VIPER"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }

    func onContactList(contact: [Contact]) {
        self.hideProgress()
        self.refreshTableView(contacts: contact)
    }
    
    func onContactDelete(isDeleted: Bool) {
        self.hideProgress()
        presenter.apiContactList()
    }
    

    func refreshTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.ContactID = id
        let navigationController = UINavigationController(rootViewController: vc)
        print(vc.ContactID)
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func leftTapped(){
        presenter.apiContactList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    // MARK: - TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    //MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete here")
            
            completion(true)
            self.presenter.apiContactDelete(contact: contact)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Edit here")
            
            completion(true)
            
            self.callEditViewController(id: contact.id!)
            
        }
    }
}
