//
//  EditPresenter.swift
//  StoryboradContactViper
import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
    
}

class EditPresenter: EditPresenterProtocol{
    
    var interactor: EditInteractorProtocol!
    var routing: EditRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiCallContact(id: Int) {
        controller.showProgress()
        interactor.apiCallContact(id: id)
    }
    
    func apiEditContact(id: Int, contact: Contact) {
        controller.showProgress()
        interactor.apiEditContact(id: id, contact: contact)
    }
    
}
