
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

func decode(data dict: NSDictionary) throws -> Shop{
    
    // parsing
    
    let name = dict.value(forKey: "name") as! String
    let address = dict.value(forKey: "address") as! String
    let description_en = dict.value(forKey: "description_en") as! String
    let description_es = dict.value(forKey: "description_es") as! String
    let gps_lat = dict.value(forKey: "gps_lat") as! String
    let gps_lon = dict.value(forKey: "gps_lon") as! String
    let url = dict.value(forKey: "url") as! String
    let img = dict.value(forKey: "img") as! String
    let logo_img = dict.value(forKey: "logo_img") as! String
    let image: AsyncData
    let logoImage: AsyncData

    // AsyncData
    let mainBundle = Bundle.main
    let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
    if URL(string: img) != nil {
        image = AsyncData(url: URL(string: img)!, defaultData: try! Data(contentsOf: defaultImage))
    } else {
        image = AsyncData(url: defaultImage, defaultData: try! Data(contentsOf: defaultImage))
    }
    
    if URL(string: logo_img) != nil {
        logoImage = AsyncData(url: URL(string: logo_img)!, defaultData: try! Data(contentsOf: defaultImage))
    } else {
        logoImage = AsyncData(url: defaultImage, defaultData: try! Data(contentsOf: defaultImage))
    }
    
    image.data
    logoImage.data
    
    return Shop(name: name,
                address: address,
                description_en: description_en,
                description_es: description_es,
                gps_lat: gps_lat,
                gps_lon: gps_lon,
                url: url,
                img: img,
                logo_img: logo_img,
                _image: image,
                _logo: logoImage
    )
}

func decode(shops dicts: JSONArray?) throws -> [Shop]{
    guard let ds = dicts else {
        throw JSONErrors.emptyJSONArray
    }
    return try decode(shops: ds)
}
