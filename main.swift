import Foundation

typealias Coordinates = (x: Int, y: Int)
var Points: [String: Coordinates] = [:]
var Vectors: [String: Coordinates] = [:]

print("Vector Calculator by ladvood")
func menu() {
    print("\nAdd...")
    print("[1] Points")
    print("[2] Vectors")
    print("")
    print("Calculate...")
    print("[3] Vector length")
    //print("[4] Vector scalar multiplication")
    //print("List of all...")
    //print("[8] Points")
    //print("[9] Vectors")
    print("[0] Quit\n")
    let answer = readLine()
    switch answer {
    case nil:
        return
    case "1":
        addPoints()
    case "2":
        addVectors()
    case "3":
        guard Vectors.count > 0 else {
            print("There are no saved vectors. Create one and try again.")
            menu()
            return
        }
        calcLength()
    case "0":
        return
    default:
        print("You input something strange... Try again.")
        menu()
    }
}

func addPoints(){
    print("\nAdding a point")
    print("Enter point's Name, X and Y coordinates of point in this format:")
    print("<name> <x> <y>\n")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 3 else {
            print("You input something strange... Check the format and try again.")
            addPoints()
            return
        }
        let name = String(args[0])
        if let x = Int(args[1]) {
            if let y = Int(args[2]) {
                let coordinates = (x,y)
                if Points[name] != nil {
                    print("A point with name \"\(name)\" already exists.")
                    print("Want to delete it? (y/n)")
                    print("If you choose \"no\" then you'll be redirected back to the \"Adding a point\" section.")
                    if let answer = readLine() {
                        if answer == "y" {
                            Points.removeValue(forKey: name)
                        } else { addPoints() }
                    }
                }
                Points[name] = coordinates
                print("Added point \"\(name)\" with coordinates (\(x);\(y)).")
            }
        }
    }
    print("Want to add another point? (y/n)")
    if let answer = readLine() {
        if answer == "y" {
            addPoints()
        } else { menu() }
    }
}
func addVectors(){
    print("\nAdding a vector")
    print("I want to...")
    print("[1] Create a new vector from existing saved points")
    print("[2] Add a new vector by entering its coordinates\n")
    if let answer = readLine() {
        switch answer {
        case "1":
            if Points.count < 2 {
                print("You saved less than 2 points so far! Add another points or create a vector using another option.")
            } else { createVecfromPts() }
        case "2":
            addVecCoordinates()
        default:
            menu()
        }
    }
}

func createVecfromPts(){
    print("\nCreating a vector from 2 points")
    print("Enter vector's Name and 2 saved points' names (from beginning to the ending point) in this format:")
    print("<name> <point1> <point2>\n")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 3 else {
            print("You input something strange... Check the format and try again.")
            addVecCoordinates()
            return
        }
        let name = String(args[0])
        let point1 = String(args[1])
        let point2 = String(args[2])
        guard Points[point1] != nil else {
            print("A point with name \"\(point1)\" doesn't exist. Please, try again and enter the name of an existing point.")
            createVecfromPts()
            return
        }
        guard Points[point2] != nil else {
            print("A point with name \"\(point2)\" doesn't exist. Please, try again and enter the name of an existing point.")
            createVecfromPts()
            return
        }
        let p1x = Points[point1]!.x
        let p1y = Points[point1]!.y
        
        let p2x = Points[point2]!.x
        let p2y = Points[point2]!.y
        
        let vx = p2x-p1x
        let vy = p2y-p1y
        let coordinates = (vx,vy)
        Vectors[name] = coordinates
        print("Added vector \"\(name)\" with coordinates (\(vx);\(vy))")
        print("from point \"\(point1)\" with coordinates (\(p1x);\(p1y))")
        print("and point \"\(point2)\" with coordinates (\(p2x);\(p2y))")
        menu()
    }
}

func addVecCoordinates(){
    print("\nCreating a vector by entering its coordinates")
    print("Enter vector's Name, X and Y coordinates of vector in this format:")
    print("<name> <x> <y>\n")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 3 else {
            print("You input something strange... Check the format and try again.")
            addVecCoordinates()
            return
        }
        let name = String(args[0])
        if let x = Int(args[1]) {
            if let y = Int(args[2]) {
                let coordinates = (x,y)
                if Vectors[name] != nil {
                    print("A vector with name \"\(name)\" already exists.")
                    print("Want to delete it? (y/n)")
                    print("If you choose \"no\" then you'll be redirected back to the menu section.")
                    if let answer = readLine() {
                        if answer == "y" {
                            Vectors.removeValue(forKey: name)
                        } else { menu() }
                    }
                }
                Vectors[name] = coordinates
                print("Added vector \"\(name)\" with coordinates (\(x);\(y)).")
            }
        }
    }
    print("Want to add another vector by entering its coordinates? (y/n)")
    if let answer = readLine() {
        if answer == "y" {
            addVecCoordinates()
        } else { menu() }
    }
}

func calcLength(){
    print("\nCalculating lenght of a vector")
    print("Enter saved vector's name:")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let name = answer
        guard Vectors[name] != nil else {
            print("A vector with name \"\(name)\" doesn't exist. Try again.")
            calcLength()
            return
        }
        let x = Double(Vectors[name]!.x)
        let y = Double(Vectors[name]!.y)
        let length = sqrt(x*x + y*y)
        print("\nLength of vector \"\(name)\" equals to \(length)")
        menu()
    }
}

menu()
