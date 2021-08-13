//
//  
//
//  Created by Khatib Mahad H. on 8/11/21.
//

import Foundation
import CoreData

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonImage
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSetting]
    let moves: [PokemonMoveSetting]
}

/*class ManagedPokemon: NSManagedObject {

    @NSManaged var  id: Int
    @NSManaged var  name: String
    @NSManaged var  height: Int
    @NSManaged var  weight: Int
    @NSManaged var  sprites: ManagedPokemonImage

    var pokemon : Pokemon {
       get {
        return Pokemon(id: self.id, name: self.name, height: self.height, weight: self.weight, sprites: sprites.sprites, types: [], stats: [], moves: [])
        }
        set {
            self.id = newValue.id
            self.name = newValue.name
            self.height = newValue.height
            self.weight = newValue.weight
            self.sprites = ManagedPokemonImage(sprites: newValue.sprites)
                
                //PokemonImage(frontDefault: newValue.sprites.frontDefault, frontShiny: newValue.sprites.frontShiny, backDefault: newValue.sprites.backDefault, backShiny: newValue.sprites.backShiny)
        }
     }
}*/

struct PokemonImage: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let backDefault: String?
    let backShiny: String?
    
    func getAllImagesURL() -> [String] {
        var images = [String]()
        
        if let front = frontDefault {
            images.append(front)
        }
        if let frontShiny = frontShiny {
            images.append(frontShiny)
        }
        if let back = backDefault {
            images.append(back)
        }
        if let backShiny = backShiny {
            images.append(backShiny)
        }
        return images
    }
}

/*class ManagedPokemonImage: NSManagedObject {

    @NSManaged var  frontDefault: String?
    @NSManaged var  frontShiny: String?
    @NSManaged var  backDefault: String?
    @NSManaged var  backShiny: String?

    var sprites : PokemonImage {
       get {
        return PokemonImage(frontDefault: self.frontDefault, frontShiny: self.frontShiny, backDefault: self.backDefault, backShiny: self.backShiny)
        }
        set {
            self.frontDefault = newValue.frontDefault
            self.frontShiny = newValue.frontShiny
            self.backDefault = newValue.backDefault
            self.backShiny = newValue.backShiny
        }
     }
}
*/

