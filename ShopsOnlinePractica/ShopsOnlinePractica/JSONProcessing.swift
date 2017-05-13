
import UIKit

//MARK: - Errors
enum JSONErrors : Error{
    case missingField(name:String)
    case incorrectValue(name: String, value: String)
    case emptyJSONObject
    case emptyJSONArray
}


//MARK: - Aliases
typealias JSONObject    = String    // We'll only receive strings
typealias JSONDictionary = [String : JSONObject]
typealias JSONArray = [JSONDictionary]

//MARK: - Decodification
func decode(data dict: JSONDictionary) throws -> Shop{
    
   // validate first
    try validate(dictionary: dict)
    
    // extract from dict
    func extract(key: String) -> String{
        return dict[key]!   // we know it can't be missing because we validated first!
    }
    
    // parsing
    let name = extract(key: "name")
    let address = extract(key: "address")
    let description_en = extract(key: "description_en")
    let description_es = extract(key: "description_es")
    let gps_lat = extract(key: "gps_lat")
    let gps_lon = extract(key: "gps_lon")
    
    return Shop(name: name, address: address, description_en:
                description_en, description_es: description_es,
                gps_lat: gps_lat, gps_lon: gps_lon)
}

func decode(shop dict: JSONDictionary?) throws -> Shop{
    
    guard let d = dict else {
        throw JSONErrors.emptyJSONObject
    }
    return try decode(data:d)
}

func decode(shops dicts: JSONArray) throws -> [Shop]{
    
    return try dicts.flatMap{
        try decode(data:$0)
    }
}

func decode(shops dicts: JSONArray?) throws -> [Shop]{
    guard let ds = dicts else {
        throw JSONErrors.emptyJSONArray
    }
    return try decode(shops: ds)
}


//MARK: - Validation
// Validation should be kept waya from processing to
// insure the single responsability principle
// https://medium.com/swift-programming/why-swift-guard-should-be-avoided-484cfc2603c5#.bd8d7ad91
private
func validate(dictionary dict: JSONDictionary) throws{
    
    func isMissing() throws{
        for key in dict.keys{
            guard let value = dict[key] else{
                throw JSONErrors.missingField(name: key)
            }
            guard value.characters.count > 0  else {
                throw JSONErrors.incorrectValue(name: key, value: value)
            }
        }
        
    }
    
    try isMissing()
    
}


//MARK: - Parsing
func parseCommaSeparated(string s: String)->[String]{
    
    return s.components(separatedBy: ",").map({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }).filter({ $0.characters.count > 0})
}

