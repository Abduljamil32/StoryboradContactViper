//
//  CreateInteractor.swift
//  StoryboradContactViper

import Foundation

protocol CreateInteractorProtocol {
    func apiContactCreate(contact: Contact)
}

class CreateInteractor: CreateInteractorProtocol{
    
    var manager: HttpManagerProtocol!
    var response: CreateResponseProtocol!
    
    func apiContactCreate(contact: Contact) {
        manager.apiContactCreate(contact: contact) { result in
            self.response.onContactCreate(isCreated: result)
        }
    }

}
