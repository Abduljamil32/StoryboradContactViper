//
//  HomePresenter.swift
//  StoryboradContactViper

import Foundation

protocol HomePresenterProtocol: HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(id: String)
}

class HomePresenter: HomePresenterProtocol{
    
    var interactor: HomeInteractorProtocol!
    var routing: HomeRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactList() {
        controller.showProgress()
        interactor.apiContactList()
    }
    
    func apiContactDelete(contact: Contact) {
        controller.showProgress()
        interactor.apiContactDelete(contact: contact)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
    func navigateEditScreen(id: String) {
        routing.navigateEditScreen(id: id)
    }
    
}
