
## What is it? 🙋🏻

It's a Todo application with offline suppoert by the use of Core Data which has been developed as a code challenge. It's written purely in Swift without using 3rd party frameworks.


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

change the image
<img src="https://www.uplooder.net/img/image/46/4aaf75fe14df0917b9a23bee6abee30b/architecture-diagram.jpg" alt="J" width="300"/>


## Why?
#### MVVM?
MVC architecture in iOS translated to Massive View Controller. The first reason for this choice is because soon or late the code base converts to a spaghetti code-base easily.  The second one is that I highly believe in sOlid principles, especially the o one which means **Open For Extension** So, I used this architecture to make a passive ViewController by outsourcing business logic to ModelView layer.
#### Coordinator Design Patter?
It makes the app coordination super simple. Plus, it brings loosly coupling betweein ViewControllers. Thus, we'll have a more testable code base. In other way, Coordinator is like a company that knows how to make each scene(VCs and VMs).
#### Services?
This layer is simply responsible for communicating with whatever exists outside of the application. Like API calls, Bluetooth, saving on storage or database, etc.
Again, I highly respect the SOLID principles. On the diagram image on part services, you can see **Dependency Inversion**. For example, in the future, if we would like to use Realm instead of Core Data, we can simply implement the *Storage* protocol in a class that uses Realm and easily inject it into the services layer instead of the current implementation of the Storage which is using Core Data. Thus, again, this brings **Modularity** and **Open For Extention** principles to the code-base.
#### Models?
1. Todo
    * Simply represent a todo (a pure model)
2. TodoViewData
    * It's a wrapper around each Todo which do some preprocess on data before use them on ViewControllers.
3. TodoObject
   * It contains both models above + TodoNSManagedObject of each Todo. It uses as a container which knows 3 aspects of each todo. How its NSObject, ViewData and pure model represented.
#### CoreData testability?
If we use the same Core Data stack for the application and the same one for the tests. It's near impossible to test the Core Data CRUD actions.
Why? Because if you use the same stack for saving on disk using the application, your disk data gets changes,so, you must always change your test accordingly.
<img src="https://www.uplooder.net/img/image/13/fc5c2227e79f65b8313313bd84bdabd4/simple.png" alt="J" width="300"/>

**Solution?**
Make 2 different stacks which makes storage and Core Data layer of the application super **testable** and **runs tests super faster**.
<img src="https://www.uplooder.net/img/image/28/728fb3e26193ed163305f680e3b72fdb/medium.png" alt="J" width="300"/>
**Difference?**
<img src="https://www.uplooder.net/img/image/99/80402952ef313e980b9ac940a569e937/Untitled-3.jpeg" alt="J" width="600"/>
The left one uses by the application to really save on disk.
The right one uses by the test cases. It's created on memory that is why tests run very fast.
## Video 🎥


#### The last word
I invite you to see **Unit Tests** of the Core Data and application itself as well as **UI Tests**. I used GWT method to make the tests cleaner.

### Diagram
You can find the diagram file in the repo and open it in [here](draw.io) 
