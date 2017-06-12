
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
    let gps_lat = (dict.value(forKey: "gps_lat") as! String).trimmingCharacters(in: .whitespaces)
    let gps_lon = (dict.value(forKey: "gps_lon") as! String).trimmingCharacters(in: .whitespaces)
    let url = dict.value(forKey: "url") as! String
    let img = dict.value(forKey: "img") as! String
    let logo_img = dict.value(forKey: "logo_img") as! String
    let image: AsyncData
    let logoImage: AsyncData
    let mapImage: AsyncData
    let imgFileHash = String(img.hashValue)
    let logoFileHash = String(logo_img.hashValue)

    // AsyncData
    let mainBundle = Bundle.main
    let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
    if URL(string: img) != nil {
        image = AsyncData(url: URL(string: img)!, defaultData: try! Data(contentsOf: defaultImage), nameFileHash: imgFileHash)
    } else {
        image = AsyncData(url: defaultImage, defaultData: try! Data(contentsOf: defaultImage), nameFileHash: imgFileHash)
    }
    
    if URL(string: logo_img) != nil {
        logoImage = AsyncData(url: URL(string: logo_img)!, defaultData: try! Data(contentsOf: defaultImage), nameFileHash: logoFileHash)
    } else {
        logoImage = AsyncData(url: defaultImage, defaultData: try! Data(contentsOf: defaultImage), nameFileHash: logoFileHash)
    }
    
    let urlMapImage = "http://maps.googleapis.com/maps/api/staticmap?center=" +
        gps_lat +
        "," +
        gps_lon +
        "&zoom=17&size=320x220&scale=2&markers=%7Ccolor:0x9C7B14%7C" +
        gps_lat +
        "," +
        gps_lon
    
    let mapImageHash = String(urlMapImage.hashValue)
    
    mapImage = AsyncData(url: URL(string: urlMapImage)!, defaultData: try! Data(contentsOf: defaultImage), nameFileHash: mapImageHash)
    
    image.data
    logoImage.data
    mapImage.data
    
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
                _logo: logoImage,
                _mapImage: mapImage,
                imgFileHash: imgFileHash,
                logoFileHash: logoFileHash,
                mapImageHash: mapImageHash,
                mapImageUrl: urlMapImage
    )
}

func decode(shops dicts: JSONArray?) throws -> [Shop]{
    guard let ds = dicts else {
        throw JSONErrors.emptyJSONArray
    }
    return try decode(shops: ds)
}
