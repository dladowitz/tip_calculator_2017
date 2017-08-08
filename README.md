# Pre-work - *Tip calculator*

**Tip Calculator** is a tip calculator application for iOS.

Submitted by: **David Ladowitz**

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
* Bill splitting

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/GGoDfE4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: 
    "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** 
XCode is a great IDE, with lots of autocomplation help. 
    Swift looks a lot more approachable than Objective-C, with less verbose syntax. It seems closer to Ruby, which is nice. 
    Compared to CSS, iOS does a good job of making things look nice without extensive knowledge of frameworks.
    
 IBOutlets connect the attributes of Storyboard Objects with your code, allowing you to set things like text and color programattically. IBActions connect funtionality of Storyboard Objects with your code, allowing you to run code on interactions (like button presses).
 
 They appear to be implemented as an XML style of markup in the storyboard, XML type attributes holding things like eventType and id.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** In general, a strong reference is set up when a class instance is assigned to variable (or a constant or property). 
ARC will not deallocate the instance from memory while a strong reference still exists. 
The strong reference is broken when the variable no longer references the object, usually by setting the variable to nil. 

A strong reference cycle is setup when two objects reference each other. 
For example a Person class my have a child and parent property. 
If two Person objects are created and reference each other a Strong Reference Cycle is setup. 

Example
Person 1

parent: Person2

child: nil

Person 2
parent: nil
child: Person1

A Strong Reference Cycle for Closures is setup when a class instance has property which is a Closure and that closure references a property within the class.
For example a Person class my have a ‘employer’ property that is a Closure and also references the person’s name. 
In this case the closure acts like it’s own class instance (maybe it is one) and references the Person instance

Example
Person Class
name: ‘David’
employer:  () -> String = { “\(self.name) works at Facebook” }].


## License

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
