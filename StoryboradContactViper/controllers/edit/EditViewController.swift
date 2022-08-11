//
//  EditViewController.swift
//  StoryboradContactViper

import UIKit

protocol EditRequestProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
}

protocol EditResponseProtocol {
    func onCallContact(contact: Contact)
    func onEditContact(result: Bool)
}

class EditViewController: BaseViewController, EditResponseProtocol {
    var presenter: EditRequestProtocol!
    
    @IBOutlet weak var newNameText: UITextField!
    @IBOutlet weak var newPhoneText: UITextField!
    
    var ContactID: String = "1"
    var Information : Contact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViper()
        presenter.apiCallContact(id: Int(ContactID) ?? 0)
    }


    
    // MARK: - METHODS
    func initViews(){
    
        DispatchQueue.main.async {
            self.newPhoneText.text = self.Information.phone!
            self.newNameText.text = self.Information.name!
        }
        
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }

    func onCallContact(contact: Contact) {
        self.hideProgress()
        Information = contact
        initViews()
    }
    
    func onEditContact(result: Bool) {
        self.hideProgress()
        if result {
            self.dismiss(animated: true, completion: nil)
        }else{
            
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func editTapped(_ sender: Any) {
        presenter.apiEditContact(id: Int(ContactID)!, contact: Contact(name: newNameText.text!, phone: newPhoneText.text!))
    }
}
