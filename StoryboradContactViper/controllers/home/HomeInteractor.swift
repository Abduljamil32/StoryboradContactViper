//
//  HomeInteractor.swift
//  StoryboradContactViper

import Foundation

protocol HomeInteractorProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
}

class HomeInteractor: HomeInteractorProtocol{
    var manager: HttpManagerProtocol!
    var response: HomeResponseProtocol!
    
    func apiContactList() {
        manager.apiContactList { (result) in
            self.response.onContactList(contact: result)
        }
    }
    
    func apiContactDelete(contact: Contact) {
        manager.apiContactDelete(contact: contact) { result in
            self.response.onContactDelete(isDeleted: result)
        }
    }
    
}
