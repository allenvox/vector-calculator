import Foundation

typealias Coordinates = (x: Double, y: Double, z: Double)
var Points: [String: Coordinates] = [:]
var Vectors: [String: Coordinates] = [:]

print("Vector Calculator by ladvood")
func menu() {
    print("\nAdd...")
    print("[1] Points")
    print("[2] Vectors")
    print("Calculate...")
    print("[3] Vector length")
    print("[4] Scalar multiplication of 2 vectors")
    print("[5] Vector multiplication of 2 vectors")
    //print("[6] ")
    print("[7] Angle between 2 vectors")
    print("List of all...")
    print("[8] Points")
    print("[9] Vectors")
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
        checkEnough(dict: Vectors, type: "vectors", need: 1)
        calcLength()
    case "4":
        checkEnough(dict: Vectors, type: "vectors", need: 2)
        ScalarMultiplication()
    case "5":
        checkEnough(dict: Vectors, type: "vectors", need: 2)
        VectorMultiplication()
    case "7":
        checkEnough(dict: Vectors, type: "vectors", need: 2)
        angleBetweenVectors()
    case "8":
        checkEnough(dict: Points, type: "points", need: 1)
        listOf(dict: Points, type: "points")
    case "9":
        checkEnough(dict: Vectors, type: "vectors", need: 1)
        listOf(dict: Vectors, type: "vectors")
    case "0":
        return
    default:
        print("You input something strange... Try again.")
        menu()
    }
}

func VectorMultiplication(){
    print("\nCalculating vector multiplication of 2 vectors")
    print("Enter the names of 2 saved vectors:")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 2 else {
            print("You input something strange... We need only the names of 2 vectors. Try again.")
            VectorMultiplication()
            return
        }
        let v1 = String(args[0])
        let v2 = String(args[1])
        guard Vectors[v1] != nil else {
            print("A vector with name \"\(v1)\" doesn't exist. Try again.")
            VectorMultiplication()
            return
        }
        guard Vectors[v2] != nil else {
            print("A vector with name \"\(v2)\" doesn't exist. Try again.")
            VectorMultiplication()
            return
        }
        let result = multiply_vector(v1x: Vectors[v1]!.x, v1y: Vectors[v1]!.y, v2x: Vectors[v2]!.x, v2y: Vectors[v2]!.y, v1z: Vectors[v1]!.z, v2z: Vectors[v2]!.z)
        print("\nVector multiplication of 2 vectors (\"\(v1)\" and \"\(v2)\") equals to \(result).")
        menu()
    }
}

func multiply_vector(v1x: Double, v1y: Double, v2x: Double, v2y: Double, v1z: Double, v2z: Double) -> Double {
    let cos = cosin(v1x: v1x, v1y: v1y, v2x: v2x, v2y: v2y, v1z: v1z, v2z: v2z)
    let sinus = sqrt(1 - cos*cos)
    let result = Len(x: v1x, y: v1y, z: v1z) * Len(x: v2x, y: v2y, z: v2z) * sinus
    return result
}

func angleBetweenVectors(){
    print("\nCalculating angle between 2 vectors")
    print("Enter the names of 2 saved vectors:")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 2 else {
            print("You input something strange... We need only the names of 2 vectors. Try again.")
            angleBetweenVectors()
            return
        }
        let v1 = String(args[0])
        let v2 = String(args[1])
        guard Vectors[v1] != nil else {
            print("A vector with name \"\(v1)\" doesn't exist. Try again.")
            angleBetweenVectors()
            return
        }
        guard Vectors[v2] != nil else {
            print("A vector with name \"\(v2)\" doesn't exist. Try again.")
            angleBetweenVectors()
            return
        }
        let v1x = Vectors[v1]!.x
        let v1y = Vectors[v1]!.y
        let v1z = Vectors[v1]!.z
        
        let v2x = Vectors[v2]!.x
        let v2y = Vectors[v2]!.y
        let v2z = Vectors[v2]!.z
        
        let cos = cosin(v1x: v1x, v1y: v1y, v2x: v2x, v2y: v2y, v1z: v1z, v2z: v2z)
        let result = acos(cos) * 180 / Double.pi
        print("\nAngle between 2 vectors (\"\(v1)\" and \"\(v2)\") equals to \(result) degrees.")
        menu()
    }
}

func cosin(v1x: Double, v1y: Double, v2x: Double, v2y: Double, v1z: Double, v2z: Double) -> Double {
    let scalarMultiplication = multiply_scalar(v1x: v1x, v1y: v1y, v2x: v2x, v2y: v2y, v1z: v1z, v2z: v2z)
    let multiplicationOfLengths = Len(x: v1x, y: v1y, z: v1z) * Len(x: v2x, y: v2y, z: v2z)
    let result = scalarMultiplication / multiplicationOfLengths
    return result
}

func checkEnough(dict: [String: Coordinates], type: String, need: Int){
    guard dict.count > need-1 else {
        print("You have \(dict.count) saved \(type). Program needs at least \(need). Add or create some more to do this operation.")
        menu()
        return
    }
}

func ScalarMultiplication(){
    print("\nCalculating scalar multiplication of 2 vectors")
    print("Enter the names of 2 saved vectors:")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count == 2 else {
            print("You input something strange... We need only the names of 2 vectors. Try again.")
            ScalarMultiplication()
            return
        }
        let v1 = String(args[0])
        let v2 = String(args[1])
        guard Vectors[v1] != nil else {
            print("A vector with name \"\(v1)\" doesn't exist. Try again.")
            ScalarMultiplication()
            return
        }
        guard Vectors[v2] != nil else {
            print("A vector with name \"\(v2)\" doesn't exist. Try again.")
            ScalarMultiplication()
            return
        }
        let result = multiply_scalar(v1x: Vectors[v1]!.x, v1y: Vectors[v1]!.y, v2x: Vectors[v2]!.x, v2y: Vectors[v2]!.y, v1z: Vectors[v1]!.z, v2z: Vectors[v2]!.z)
        print("\nScalar multiplication of 2 vectors (\"\(v1)\" and \"\(v2)\") equals to \(result).")
        menu()
    }
}

func multiply_scalar(v1x: Double, v1y: Double, v2x: Double, v2y: Double, v1z: Double, v2z: Double) -> Double {
    return v1x*v2x + v1y*v2y + v1z*v2z
}

func listOf(dict: [String: Coordinates], type: String){
    print("\nList of saved \(type):")
    print("(format: name - coordinates)")
    for i in dict {
        let name = i.key
        let x = i.value.x
        let y = i.value.y
        let z = i.value.z
        print(" \(name) - (\(x),\(y),\(z))")
    }
    print("End.")
    menu()
}

func addPoints(){
    print("\nAdding a point")
    print("Enter point's Name, X-Y-Z coordinates of point in this format:")
    print("<name> <x> <y> [z]")
    print("(if Z isn't specified, it'll be set to 0)\n")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count > 2 else {
            print("You input something strange... Check the format and try again.")
            addPoints()
            return
        }
        let name = String(args[0])
        if let x = Double(args[1]) {
            if let y = Double(args[2]) {
                let z: Double
                if args.count == 3 { z = 0 } else { z = Double(args[3])! }
                let coordinates = (x,y,z)
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
                print("Added point \"\(name)\" with coordinates (\(x);\(y);\(z)).")
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
                addVectors()
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
            createVecfromPts()
            return
        }
        let name = String(args[0])
        let p1 = String(args[1])
        let p2 = String(args[2])
        guard Points[p1] != nil else {
            print("A point with name \"\(p1)\" doesn't exist. Please, try again and enter the name of an existing point.")
            createVecfromPts()
            return
        }
        guard Points[p2] != nil else {
            print("A point with name \"\(p2)\" doesn't exist. Please, try again and enter the name of an existing point.")
            createVecfromPts()
            return
        }
        let p1x = Points[p1]!.x
        let p1y = Points[p1]!.y
        let p1z = Points[p1]!.z
        
        let p2x = Points[p2]!.x
        let p2y = Points[p2]!.y
        let p2z = Points[p2]!.z
        
        let vx = p2x-p1x
        let vy = p2y-p1y
        let vz = p2z-p1z
        let coordinates = (vx,vy,vz)
        Vectors[name] = coordinates
        print("Added vector \"\(name)\" with coordinates (\(vx);\(vy);\(vz)")
        menu()
    }
}

func addVecCoordinates(){
    print("\nCreating a vector by entering its coordinates")
    print("Enter vector's Name, X-Y-Z coordinates of vector in this format:")
    print("<name> <x> <y> [z]")
    print("(if Z isn't specified, it'll be set to 0)\n")
    if let answer = readLine() {
        if answer == "" { menu(); return }
        let args = answer.split(separator: " ")
        guard args.count > 2 else {
            print("You input something strange... Check the format and try again.")
            addVecCoordinates()
            return
        }
        let name = String(args[0])
        if let x = Double(args[1]) {
            if let y = Double(args[2]) {
                let z: Double
                if args.count == 3 { z = 0 } else { z = Double(args[3])! }
                let coordinates = (x,y,z)
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
                print("Added vector \"\(name)\" with coordinates (\(x);\(y);\(z)).")
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
        let result = Len(x: Vectors[name]!.x, y: Vectors[name]!.y, z: Vectors[name]!.z)
        print("\nLength of vector \"\(name)\" equals to \(result).")
        menu()
    }
}

func Len(x: Double, y: Double, z: Double) -> Double{
    return sqrt(x*x + y*y + z*z)
}

menu()
