//
//  CreateViewController.swift
//  StoryboradContactViper
//


import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    var presenter: CreateRequestProtocol!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    var item = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }


    
    // MARK: - METHODS
    func initViews(){
        configureViper()
    }
    

    func configureViper(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    
    // MARK: - Actions
    
    @IBAction func createTapped(_ sender: Any) {
        if nameText.text != "" && phoneText.text != "" {
            presenter.apiContactCreate(contact: Contact(name: nameText.text!, phone: phoneText.text!))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func onContactCreate(isCreated: Bool) {
        if isCreated {
            self.navigationController?.popViewController(animated: true)
        }else{
            
        }
    }
}
