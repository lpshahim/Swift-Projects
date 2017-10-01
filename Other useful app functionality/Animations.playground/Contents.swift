//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"


3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
XCPShowView(identifier: "Container View", view: containerView)

let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
circle.center = containerView.center
circle.layer.cornerRadius = 25.0

let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
circle.backgroundColor = startingColor

containerView.addSubview(circle);

let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white

containerView.addSubview(rectangle)

UIView.animate(withDuration: 2.0, animations: { () -> Void in
    let endingColor = UIColor(red: (255.0/255.0), green: (61.0/255.0), blue: (24.0/255.0), alpha: 1.0)
    circle.backgroundColor = endingColor
    
    let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
    
    circle.transform = scaleTransform
    
    let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
    
    rectangle.transform = rotationTransform
})




PlaygroundPage.current.liveView = containerView

