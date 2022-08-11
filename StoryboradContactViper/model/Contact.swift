import Foundation

struct Contact: Decodable{
    var id : String? = ""
    var name: String? = ""
    var phone: String? = ""
    
    init(){}
    
    init(name: String, phone: String){
        self.name = name
        self.phone = phone
    }
    
    init(id: String, name: String, phone: String){
        self.id = id
        self.name = name
        self.phone = phone
    }
    
}
