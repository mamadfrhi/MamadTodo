
![Swift](https://img.shields.io/badge/Swift-5.6.1-orange) ![CoreData](https://img.shields.io/badge/CoreData-3.2-blue) ![build](https://img.shields.io/badge/build-passing-brightgreen) ![Architecture](https://img.shields.io/badge/Architecture-MVVM-orange) ![UI/UnitTests](https://img.shields.io/badge/UI%2FUNIT-Tests-brightgreen)
## What is it? 🙋🏻

It's a Todo iOS Application with **offline support** by the use of Core Data which has been developed as a code challenge. It's written **purely in Swift** without using 3rd party frameworks. The project included **_Unit Tests_ for the _Core Data_ Layer** and **UI Tests** exist as well.


## What do you want to show by this project❓

How DO I **respect** the topics below while developing a software:

* Reusability of the code 🔁
* Clean Code Principles 🧼
* SOLID Principles 🥰
* Design Patterns 🖌
* Loose coupling 🙇🏻‍♂️
* Abstraction ☁️
* Modularity 🧱
* Testability 🧪
* and Clean Architecture for sure! 😁

## Architecture (heart of the app❤️)
#### MVVM-C + Services

<img src="https://www.uplooder.net/img/image/46/4aaf75fe14df0917b9a23bee6abee30b/architecture-diagram.jpg" alt="J" width="300"/>


## Why⁉️
#### MVVM?🏛
MVC architecture in iOS translated to Massive View Controller. The first reason for this choice is because soon or late the code base converts to a spaghetti code-base easily.  The second one is that I highly believe in sOlid principles, especially the o one which means **Open For Extension** So, I used this architecture to make a passive ViewController by outsourcing business logic to the ModelView layer.

#### Coordinator Design Pattern?🚦
It makes the app coordination super simple. Plus, it brings loosely coupling between ViewControllers. Thus, we'll have a more testable codebase. In another way, a Coordinator is like a company that knows how to make each scene(VCs and VMs).

#### Services?🧑🏻‍🔧
This layer is simply responsible for communicating with whatever exists outside of the application. Like API calls, Bluetooth, saving on storage or database, etc.
Again, I highly respect the SOLID principles. On the diagram image on part services, you can see **Dependency Inversion**. For example, in the future, if we would like to use Realm instead of Core Data, we can simply implement the *Storage* protocol in a class that uses Realm and easily inject it into the services layer instead of the current implementation of the Storage which is using Core Data. Thus, again, this brings **Modularity** and **Open For Extention** principles to the code-base.

#### Models?🫥

1. Todo
    * Simply represent a todo model which fetchs from the HDD (a pure model)
2. TodoViewData
    * It's a wrapper(decorator) around each Todo which do some preprocess on data before use them on ViewControllers.
3. TodoObject
   * It contains both models above + TodoNSManagedObject of each Todo. It uses as a container which knows 3 aspects of each todo. How its NSObject, ViewData and pure model represented.

#### CoreData testability?😍

If we use the same Core Data stack for the application and the same one for the tests. It's near impossible to test the Core Data CRUD actions.
Why? Because if you use the same stack for saving on disk using the application, your disk data gets changes,so, you must always change your test accordingly.

<img src="https://www.uplooder.net/img/image/13/fc5c2227e79f65b8313313bd84bdabd4/simple.png" alt="J" width="300"/>

**Solution?** ✨
Make 2 different stacks which makes storage and Core Data layer of the application super **testable** and **runs tests super faster**.

<img src="https://www.uplooder.net/img/image/28/728fb3e26193ed163305f680e3b72fdb/medium.png" alt="J" width="300"/>

[Images' source](https://github.com/jrasmusson/swift-arcade/tree/master/CoreData/images)

**How to reach it?** 🧠

<img src="https://www.uplooder.net/img/image/99/80402952ef313e980b9ac940a569e937/Untitled-3.jpeg" alt="J" width="600"/>

The left one uses by the application to really save on disk.

The right one uses by the test cases. It's created on memory that is why tests run very fast.

## Video 🎥




https://user-images.githubusercontent.com/28094207/171158800-46c7ab9b-cd53-427b-9d28-ed9a742bb5fa.mov





#### The last words
I invite you to see **Unit Tests** of the Core Data and application itself as well as **UI Tests**. I used GWT method to make the tests cleaner.

**Attention**☝🏼
Before running `UITests`, press `Command⌘ + k` on the `Simulator` to toggle the software keyboard.

### Diagram
You can find the diagram file in the repo and open it in [here](https://app.diagrams.net/) 


#
#
<details>
<summary>Project Definition</summary>
<br>

## Project:

We would like you to build a simple "to-do" app which consists of tasks in list and task detail in detail screen.

### Technical Requirements:

* Feel free to use any architecture or design pattern
* Do not use any reactive paradigm (SwiftUI, RxSwift etc.)
* You can build the user interface with XIBs || Storyboards || Code
* For the local storage, you should use Realm or CoreData

### Evaluation Criteria:

* For the local storage, you should use Realm or CoreData
* Keep code as clean as possible
* Your code should be easy to maintain
* Do not try to build a fancy UI, your implementation details are more important
* Consistency on code convention and indentation
* Library usage (No more and less than required)
* Git usage
* A README.md which describes technical details/decisions
* Unit Tests or UI Tests are bonus

### Submission:

After completing the assignment, create a pull request to `main` branch.
Then please send an email to the People Department with the link of the GitHub repo.
</details>
