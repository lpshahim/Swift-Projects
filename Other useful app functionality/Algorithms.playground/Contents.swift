//: Playground - noun: a place where people can play

import UIKit


/*var listNumbers = [Int]()

for numbers in 1...10{
    listNumbers.append(Int(arc4random_uniform(10)))
}

listNumbers = listNumbers.sorted() */

//***************************************************
//binary search

/*func binarySearch(searchValue:Int, data:[Int]) -> Bool{
    let sortedArray : [Int] = data.sorted()
    
    
    
    var leftIndex = 0
    var rightIndex = sortedArray.count - 1
    
    while (leftIndex <= rightIndex){
    
        let middleIndex = (leftIndex + rightIndex) / 2
        let middleValue = data[middleIndex]
        
        if (searchValue == middleValue){
            return true
        }
        
        if (searchValue < middleValue){
            rightIndex = middleIndex - 1
        }
        
        if (searchValue > middleValue){
            leftIndex = middleIndex + 1
        }
        
    }
    
    
    return false
}

binarySearch(searchValue: 5, data: listNumbers)*/
 

//*************************************************

//Most common name in array

/*func mostCommonName(array : [String]) -> String{
    
    var nameCountDictionary = [String: Int]()
    
    for name in array {
        if let count = nameCountDictionary[name]{
            nameCountDictionary[name] = count + 1
        }else{
            nameCountDictionary[name] = 1
        }
    }
    
    var mostCommonName = ""
    
    for key in nameCountDictionary.keys{
        if mostCommonName == "" {
            mostCommonName = key
        }else{
            let count = nameCountDictionary[key]
            if count! > (nameCountDictionary[mostCommonName])!{
                mostCommonName = key
            }
        }
        
        print("\(key): \(nameCountDictionary[key]!)")
    }
    
    return mostCommonName
}

mostCommonName(array:["Louis", "Gisele", "Peter", "Peter", "Peter", "Gisele", "Gisele", "Gisele"])*/


