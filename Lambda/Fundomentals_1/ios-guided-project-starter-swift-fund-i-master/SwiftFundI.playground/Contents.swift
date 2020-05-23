//: # Swift Fundamentals I
//: ## Hello, World!
//: As tradition dictates, any exploration of a new language needs to start with "hello, world"

let helloWorld = "Hellow world"
print(helloWorld)

//: ## Comments
//: A comment is text that is ignored by the compiler. So it can be plain text, or even code. If it formatted like the examples below, it will be completely ignored when the project is built. Comments are notes to yourself or others about how a given block of code functions.

// A single line comment is one with two slashes as the first characters
/*
 * A multi-line comment
 * is one that is bounded by
 * /* and */ characters
 */

//: ## Identifiers
//: first character A-Z or a-z or _, followed by any of these plus 0-9



//: ## Mutability
//: There are two kinds of containers that hold values in Swift. One kind is called a constant, because once a value has been set, it cannot change for the lifetime of that container. Constants are declared with the `let` keyword.
let students = 30
let staff = 4
let totalPeople = students + staff


//: Variables are declared with the 'var' keyword
var appleCount = 10
appleCount = appleCount + 5
print(appleCount)


//: ## Type Inference and Explicit Typing
//: All containers in Swift must have a type set on them. The containers we've seen so far had their types set implicitly. This is called _type inference_. Meaning the kind of object stored in the container was determined by looking at what kind of value was assigned to the container.
let ios = "Apples operating system"


//: In the line above, the constant `ios` stores a value "Apple's mobile operating system". This value is a `String`, so the data type of `ios` is `String`. The type was _inferred_ by the value provided.
//: Another way to type a container is to set it explicitly. See some examples of this below.

let price: Double = 1299.99
let onSale: Bool = false
let modelName: String = "MacBook"
let discountQry: Int = 15
if onSale == true {
    print("\(modelName) on sale for \(price)")
} else {
    print("\(modelName) at regular price: \(price). But at least \(discountQry) for special pricing")
}
//: ## Type Safety
//: Once a container's data type is set, it cannot hold a value of any other type
var life = 42



//: ## Type Coercion
//: Types are never automatically converted into another type.
let label = "The width is"
let width = 94

let widthLabel = label + String(width) //Type Coercing

let x: Int = 12
let y: Double = 3.2

Double(x) / y


//: ## String Interpolation and Concatenation
//: Using the `+` operator with two strings is called _string concatentation_. One string is appended to the end of another.
let heigthLabel = "The height is" + " 100"


//: The below example shows the _string interpolation_ characters (`\()`). These allow a `String` (or non-string) value to be placed in-line inside a larger `String` literal value. If the value is not already a `String`, it will be converted.
let anotherWithLabel = "The width is \(12 + 27)"


//: ## Collections
//: ### Arrays
//: A Swift array is a collection of like objects, and they are stored in the order they are added. Accessing a particular element is done by using its index value (which starts at 0).

let shipCaptains = ["Malcolm", "Jean", "Han", "James"]
let sameCaptains = ["Malcolm", "Jean", "Han", "James"]
let differentsCaptains = ["Kathryn", "Poe"] //Start counting from 0 index
//to access syntax of array Name[0]
print(shipCaptains[2])


//: Array equality is determined by looking at each element. If all elements are the same, and in the same order, the two arrays are equal.
if shipCaptains == sameCaptains {
    print("Equal")
} else {
    print("Not Equal!")
}


//: Since `shipCaptains` was declared as a constant, we must convert it to a mutable array before we can add entries.
var moreCaptains = shipCaptains
//three ways to incert elemets into the array
//First way
moreCaptains.append("Kathryn Janeway")
print(moreCaptains)
//this is for modefine the value in the array
moreCaptains[1] = "Poe dameron"
// or inserting at specific index
moreCaptains.insert("Poe Dameron", at: 1)
//remove
moreCaptains.remove(at: 2)



//: ### Dictionaries
//: A Swift dictionary is similar to an array in that is a collection, but the items are stored in no particular order. To access an item, its associated key is provided. Dictionaries are also called "key-value" stores. The key has a type, and the value can have the same or a different type.
var occupations = ["tim" : "firefighter", "john" : "ios developer", "murphey" : "web developer", "josh" : "web developer"]
occupations["john"]
print(occupations["tim"]!)


//: ## Looping
//: ### `for`
//: `for` loops allow for iterating over a collection of elements (usually an array), examining each element in turn.

let scores = [75, 43, 103, 87, 12, 13, 19]

var passingStudents = 0

for score in scores {
    if score > 70 {
        passingStudents += 1
    }
}

print("\(passingStudents) students scored a passing grade of 70 or higher.")

//: ### `switch`
//: `switch` statements are useful when a multiple-choice path is possible for your code, and you want to choose a single path at runtime, based on some criteria.
let number = 1

switch number {
case 1:
    print("got 1")
case 2:
    print("got 2")
case 3, 4, 5: //can do multiple cases on one line OR 6...22
    print("Got 3 or 4 or 5")
default:
    print("got nothing")
}

//switch characters {
//case "a", "e", "i", "o", "u":
//    print("The character is a vowel")
//default:
//    print("Th echaracter is consonant")
//}

//: ## Functions
//: A function in Swift is nothing more than a collection of instructions that accomplish some task. The advantage to grouping the instructions into a function is that the function can then be called whenever that task should be performed, rather than having to list out those instrutions a second, third, or nth time.
//Internall and external parameters names
//Internal is udes withing the scope of the function
//exturnal is seen when calling the func

func avarageScore(scores: [Int]) {
    var totalScores = 0
    
    for score in scores  {
        totalScores += score
    }
    
    let score = totalScores / scores.count
    print(score)
    
}
avarageScore(scores: scores)
avarageScore(scores: [1,2,3,4,5,6,7,8,9,10])


func avarageScoreWithPrecision(scores:[Int]) -> Double {
    
    var totalScore: Double = 0
    for score in scores {
        totalScore += Double(score)
    }
    return totalScore/Double(scores.count)
}
let preciseAvarageScore = avarageScoreWithPrecision(scores: scores)
print(preciseAvarageScore)


//: ## Tuples
//: Tuples are a lightweight way of grouping related values into a single compound value.

let carrots = (name: "Carrots", aisle: 4, category: "produce", count: 20)
print(carrots.aisle)
print(carrots.category)
