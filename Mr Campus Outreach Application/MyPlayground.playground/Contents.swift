//: Playground - noun: a place where people can play

import UIKit
//Reverse linkedList
/*
class Node{
    let value : Int
    var next : Node?
    
    init(val : Int, n : Node?) {
        self.value = val
        self.next = n
    }
}

let threeNode = Node(val: 3, n: nil)
let twoNode = Node(val: 2, n: threeNode)
let oneNode = Node(val: 1, n: twoNode)

func printList(head : Node?){
    var currentNode = head
    print("Print regular list")
    while currentNode != nil {
        print(currentNode?.value ?? -1)
        currentNode = currentNode?.next
    }
}

printList(head: oneNode)

func reverseList(head : Node?) -> Node?{
    
    var currentNode = head
    var prev : Node?
    var next : Node?
    print("Reversed list")
    while currentNode != nil {
        next = currentNode?.next
        currentNode?.next = prev
        prev = currentNode
        currentNode = next
    }
    return prev
}

let myReversedList = reverseList(head: oneNode)

printList(head: myReversedList)

*/

//Binary search
/*
let numbers = [1,2,4,6,8,9,11,13,16,17,20]
var hundred = [Int]()

for x in 1...100{
    hundred.append(x)
}

func binarySearch(seachValue: Int , array : [Int]) -> Bool{
    var leftIndex = 0
    var rightIndex = array.count - 1
    while leftIndex <= rightIndex {
        let middleIndex = (leftIndex + rightIndex)/2
        let middleValue = array[middleIndex]
        
        if middleValue == seachValue {
            return true
        }
        
        if seachValue < middleValue {
            rightIndex = middleIndex - 1
        }
        
        if seachValue > middleValue {
            leftIndex = middleIndex + 1
        }
    }
    
    return false
}

binarySearch(seachValue: 100, array: hundred)


//Recursive Binary Search Tree

//          10
//         /  \
//        5    14
//       /     / \
//      1     11  20
class Node{
    let value : Int
    var leftChild : Node?
    var rightChild : Node?
    
    init(v: Int, l: Node?, r: Node?) {
        self.value = v
        self.leftChild = l
        self.rightChild = r
        
    }
}

let twenty = Node(v: 20, l: nil, r: nil)
let eleven = Node(v: 11, l: nil, r: nil)
let one = Node(v: 1, l: nil, r: nil)

let five = Node(v: 5, l: one, r: nil)
let fourteen = Node(v: 14, l: eleven, r: twenty)

let tenRoot = Node(v: 10, l: five, r: fourteen)


func search(node : Node?, searchValue : Int) -> Bool{
    
    if node == nil{
        return false
    }
    
    if node?.value == searchValue{
        return true
    }else if (searchValue < node!.value){
        return search(node: node?.leftChild, searchValue: searchValue)
    }else{
        //recursion
        return search(node: node?.rightChild, searchValue: searchValue)
    }
    
}

search(node: tenRoot, searchValue: 11)

//efficiency check
let list = [1,5,10,11,14,20]
let index = list.index(where: {$0 == 20})

*/


































