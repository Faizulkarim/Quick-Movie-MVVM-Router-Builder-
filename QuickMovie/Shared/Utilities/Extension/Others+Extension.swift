//
//  Others+Extension.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import UIKit

extension String {
    
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }


}
//MARK: Decodable
extension Decodable {
    
    static func decode(data: Data?) -> Self? {
        guard let data = data else { return nil }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Self.self, from: data)
        } catch(let error) {
            print(error)
            return nil
        }
    }
}

//MARK: Encodable
extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do { return try encoder.encode(self) } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var postDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    var paramString: String {
        let strFromDict = (postDictionary.compactMap ({ (key ,value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        return "?" + strFromDict
    }
    
    
}



