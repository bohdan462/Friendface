import UIKit


struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}


var arrayOfBooks: [Book] = []
let harry: Book = Book(title: "Harry Potter", reasonToRead: "School", hasBeenRead: false)
let swift = Book(title: "Swift basic", reasonToRead: "School", hasBeenRead: true)
arrayOfBooks.append(harry)
arrayOfBooks.append(swift)

//var hasBennRead: [Book] {
//    arrayOfBooks.filter {
//        $0.contains
//    }
//}

arrayOfBooks.filter {
    $0.hasBeenRead == true
}
