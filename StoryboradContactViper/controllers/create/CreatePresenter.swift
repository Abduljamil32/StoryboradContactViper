//
//  CreatePresenter.swift
//  StoryboradContactViper

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
}

class CreatePresenter: CreatePresenterProtocol{
    
    var interactor: CreateInteractorProtocol!
    var routing: CreateRoutingProtocol!
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        controller.showProgress()
        interactor.apiContactCreate(contact: contact)
    }
    
}
