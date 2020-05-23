import UIKit

var middleNsame: String? = nil
if let unwrappedMiddleName = middleNsame { // if nil nothing would happen. unwrappedMiddleName good to use only in scope of {} whne use {return}
    print(unwrappedMiddleName)
}
// guard is good within the scope of a method or function

//func withdrawMoney(amountString: String) {
//    // verify that amount string can be a number and is greater than 0
//    guard let amount = Double(amountString) else {return} //return means return from the function
//    if amount > 0 {
//        print("Proccessing request to withdraw \(amount) dollars from bsnk sccount")
//    }
//}
//
//withdrawMoney(amountString: "200")
//withdrawMoney(amountString: "cat") //because we set guard it wont let run code because value is set to nil

func withdrawMoney(amountString: String) {
    // verify that amount string can be a number and is greater than 0
    guard let amount = Double(amountString),
        amount > 0 else {
            print("Invalisd amonunt to withdraw")
            return
    }
    if amount > 0 {
        print("Proccessing request to withdraw \(amount) dollars from bsnk sccount")
    }
}
withdrawMoney(amountString: "cat") // will print invalid amount

// how to use optional chaining to short circuit evaluation when a value is nil

class Oven {
    func bakeFood() {
        print("Baking food") //init is udes to give value to properties. Here is no property
    }
}

class Kitchen {
    var oven: Oven? // here property is optional
    
    func sweepFloor() {
        print("Sweeping the floor")
    }
}

var kitchen: Kitchen? = nil
kitchen?.sweepFloor() //we should to have kitchen in order to sweep the floor

kitchen?.oven?.bakeFood()// we should have kitchen in order to access oven and we need to have oven to backe food

//if you create kitchen, but dont have an oven, the kitchen can be swept, but the oven wont do anything because it is nill

kitchen = Kitchen()
kitchen?.sweepFloor()
kitchen?.oven?.bakeFood() //wont print anything because wee did not give oven to the kitchen
kitchen?.oven = Oven()
kitchen?.oven?.bakeFood()

//**Note** the down side is that nothing happenes when the kitchen or the oven are not set with optionl chaining

// use the nill coalesing operator (??) to provide a defauld value when expression is nil

let userinput: String = "moo"

let numberOfDogs = Int(userinput) ?? 0 //would print 0, and default value needs to be of the same type

// Combining optionsl chaining and nil coalescing

var wordOfTheDay: String? = "Butterfly"
var numberOfLetters = wordOfTheDay?.count ?? 0

print("The word of the day \(wordOfTheDay ?? "") has \(numberOfLetters) letters")

//use class inheritance and composition

class Shape {
    var color: String
    var position: CGPoint
    
    init(color: String, position: CGPoint = .zero) {
        self.color = color
        self.position = position
    }
    
}

class Square: Shape {
    var edgeWidth: Double
    
    init(color: String, edgeWidth: Double) {
        self.edgeWidth = edgeWidth
        super.init(color: color) //giving eccess to init in super class
    }
}

class Rectangle: Shape {
    var width: Double
    var height: Double
    
    init(color: String, width: Double, height: Double) {
        self.width = width
        self.height = height
        super.init(color: color)
    }
}

//create imstances of the type:

let shape = Shape(color: "Green")
let square = Square(color: "Red", edgeWidth: 5)
let rectangle = Rectangle(color: "Blue", width: 3, height: 7)

var shapes: [Shape] = []
shapes.append(contentsOf: [square, rectangle, shape])

for shape in shapes {
    print(shape.color)
}

// use is operator

let shape2: Shape = square

if shape2 is Square {
    print("Squer found")
}

// as? - conditional downcasting

for shape in shapes {
    if let square = shape as? Square {
        print(square.edgeWidth)
    } else if let rectangle = shape as? Rectangle {
        print(rectangle.height)
    } else {
        print(shape.color)
    }
}

// as! - forced dowcasting

var someShape: Shape
someShape = Rectangle(color: "Orange", width: 50, height: 40)

let orangeRactangle = someShape as! Rectangle
//let redSquare = someShape as! Square // it will crush
print("it is an \(orangeRactangle.color) rectangle")
//print("it is an \(redSquare.color) square")
