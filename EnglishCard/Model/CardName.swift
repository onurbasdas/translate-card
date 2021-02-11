//
//  CardName.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 10.02.2021.
//

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

// Child Struct
struct Child {

    var turkish: String
    var english: String

    var dictionary:[String:Any] {
        return [
            "turkish": turkish,
            "english": english,
        ]
    }

}

//Child Extension
extension Child : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let  turkish = dictionary["turkish"] as? String,
            let english = dictionary["english"] as? String else {
                return nil
        }
        self.init(turkish: turkish, english: english)
    }
}
