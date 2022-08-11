//
//  HttpManager.swift
//  StoryboardContact

import Foundation

protocol HttpManagerProtocol{
    
    func apiContactList(completion: @escaping ([Contact]) -> Void)
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void)
    
    func apiCallContact(id:Int, completion: @escaping (Contact) -> Void)
    func apiEditContact(id: Int, contact: Contact, completion: @escaping (Bool) -> Void)
    
    func apiContactCreate(contact: Contact, completion: @escaping (Bool) -> Void)
}

class HttpManager: HttpManagerProtocol{
    
    func apiContactCreate(contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            switch response.result {
            case .success:
                print("SUCCESS")
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
    
    func apiCallContact(id: Int, completion: @escaping (Contact) -> Void) {
        AFHttp.get(url: AFHttp.API_POST_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id), handler: { response in
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Contact.self, from: response.data!)
                completion(decode)
            case let .failure(error):
                print(error)
                completion(Contact())
            }
        })
    }
    
    func apiEditContact(id: Int, contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            switch response.result {
            case .success:
                print("SUCCESS")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
    
    func apiContactList(completion: @escaping ([Contact]) -> Void) {
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty()) { response in
         
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                completion(contacts)
                
            case let .failure(error):
                print(error)
                completion([Contact]())
            }
        }
    }
    
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.del(url: AFHttp.API_POST_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    
}
