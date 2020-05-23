import UIKit

//Starting with Starwars API

struct Person: Codable {
    enum PersonKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
        case films //unkeyed
        case starships
        case vehicles
    }
    
    
    let name: String
    let height: Int
    let hairColor: String
    let films: [URL]
    let starships: [URL]
    let vehicles: [URL]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let heightString = try container.decode(String.self, forKey: .height)
        self.height = Int(heightString) ?? 0
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
        
        //Approach #1 to decoding an array of URLs //Good for everything
        var filmsContainer = try container.nestedUnkeyedContainer(forKey: .films) //unkeyed
        var filmURLs: [URL] = []
        while filmsContainer.isAtEnd == false {
            //try to pull out the next value
            let filmString = try filmsContainer.decode(String.self)
            if let filmURL = URL(string: filmString) {
                filmURLs.append(filmURL)
            }
        }
        self.films = filmURLs
        
        //Approach #2 to decoding an array of URLs
        let vehicleStrings = try container.decode([String].self, forKey: .vehicles)
        self.vehicles = vehicleStrings.compactMap { URL(string: $0 )}
        
        //Approach #3 //Works only for array of urls
        starships = try container.decode([URL].self, forKey: .starships)
    }
    
    func encode(to encoder: Encoder) throws { //from person struct to data
        var container = encoder.container(keyedBy: PersonKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(hairColor, forKey: .hairColor)
        try container.encode("\(height)", forKey: .height)
        
        //Approach #1 to encode an array
        var filmsContainer = container.nestedUnkeyedContainer(forKey: .films)
        for filmURL in films {
            try filmsContainer.encode(filmURL.absoluteString)
        }
        //Approach #2
        let vehiclesStrings = vehicles.map { $0.absoluteString }
        try container.encode(vehiclesStrings, forKey: .vehicles )
        
        //Approach #3
        try container.encode(starships, forKey: .starships)
    }
    
}


let url = URL(string: "https://swapi.dev/api/people/1/")!
let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()
let luke = try! decoder.decode(Person.self, from: data) //DO NOT CONSTRUCT THIS WAY
print(luke)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let lukeData = try! encoder.encode(luke)
let lukeString = String(data: lukeData, encoding: .utf8)
print(lukeString!)

//Custom encode plist
let plistEncoder = PropertyListEncoder()
plistEncoder.outputFormat = .xml
let plistData = try! plistEncoder.encode(luke)
let plistString = String(data: plistData, encoding: .utf8)!
print(plistString)
