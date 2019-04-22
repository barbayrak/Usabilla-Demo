# Usabilla iOS Assignment
![logo](https://i.ibb.co/xJZny5B/Screen-Shot-2019-04-23-at-00-05-45.png)

## Assignment
You can reach the assignment pdf from [here](https://drive.google.com/file/d/1nZIHp8aQ7ublGeB7mXqDU5nFGo76Mbga/view?usp=sharing) 

### Context
- [Assignment](#assignment)
- [How To Run](#how-to-run)
- [Project Details](#projcet-details)
- [Project Overview Videos](#project-features-videos)
- [Core ML](#coreml)
- [Core Data - Offline Sync](#core-data-offline-sync)


## How To Run
First install dependencies
```ruby
pod install
```
then run the app

## Project Details
#### Architecture
MVVM
#### Orientation Support
Landscape , Portrait (both ways)
#### Device Support
Universal (iPad , iPhone) -> iOS
#### Storyboards
Multiple Storyboards(LaunchScreen.storyboard,Dashboard.storyboard,Insight.storyboard)
#### Unit Tests
15 Unit Tests with Quick & Nible
#### UI Tests
7 UI Tests With Default XCTest
#### Pods
Charts(For chart visuals)<br/>
Quick & Nimble (Unit Testing,BDD)<br/>

## Project Overview Videos
- [Change Chart Types On The Go](https://vimeo.com/331863283)
- [Orientation and Device Support](https://vimeo.com/331863396)
- [Dashboard View Customization](https://vimeo.com/331863308)
- [Filter Dashboard](https://vimeo.com/331863336)
- [Insights](https://vimeo.com/331863363)

## Core ML
What i want for Insight screen is to trend analyze on ratings so that i can show users if their ratings will go up or down.
In order to trend analyze we need to fit a line on rating vs date 2d chart in our previous data(there is no previous data so i used data in api)
and try to guess what will rating be in next day.To problem is a basic regression problem.I can build regression model in many
frameworks like Scikit-learn,Tensorflow,Keras etc.. but because our context is iOS and Swift i used CreateML framework in MacOS.
<br/>
<br/>
In order to create an .mlmodel, i simply create a playground in macOS platform and use CreateML framework.You can also create your mlmodel by downloading UsabillaCoreML.playground and usabillaCache.json and put your files in desktop directory
<br/>
<br/>
Here is the core code of the playground
```swift
var dataTable = try MLDataTable(contentsOf: URL(fileURLWithPath: jsonDirectory))
let (trainingData, testingData) = dataTable.randomSplit(by: 0.8)
let ratingPredictorRegressor = try MLRegressor(trainingData: trainingData, targetColumn: "rating")
let evaluationMetricsRegressor = ratingPredictorRegressor.evaluation(on: testingData)

let params = MLBoostedTreeRegressor.ModelParameters(maxIterations: 1000)
let ratingPredictorBoosted = try MLBoostedTreeRegressor(trainingData: trainingData, targetColumn: "rating", parameters: params)
let evaluationMetricsBoosted = ratingPredictorBoosted.evaluation(on: testingData)

let regressorError = evaluationMetricsRegressor.rootMeanSquaredError
let boostedError = evaluationMetricsBoosted.rootMeanSquaredError
```

and based on error, we choose best fit is Regressor or BoostedTreeRegressor then we create our .mlmodel and write to a file for importing to our project

## Core Data - Offline Sync
What if we want Offline support for our dashboard ? For a simple project we can use URLSessions 's url caching support but for complex projects we use CoreData a lightweight SQL database implementation(SQLİte) for iOS 
<br/>
Here is my schema :<br/>
![logo](https://i.ibb.co/hmyS4nC/Screen-Shot-2019-04-23-at-01-37-51.png)
<br/>
<br/>
After building my schema i generated entity properties and write core data classes for reading and writing data
<br/>
<br/>
For offline sync, i customize my feedback service class so that when it reads from api it syncs data to local data and reads data from local database
so that if there is no network it only reads from local database which simulates the offline support
<br/>

Note: If you want to see SQLite database entries you can use DB Browser for SQLite from [HERE](https://sqlitebrowser.org/dl/)

```swift
class FeedbackService : NSObject {

static let shared = FeedbackService()
let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

func fetchAndSyncFeedbacks(completion : @escaping ([FeedbackItem]?,Error?) -> ()){
let targetUrlString = "http://cache.usabilla.com/example/apidemo.json"
guard let url = URL(string: targetUrlString) else { return }

//Normally URLSession caches the data locally(url cacheing key-value) so it simulates offline data but i am using Core Data to support it so i wrote a config for session in order to disable url cache
let config = URLSessionConfiguration.default
config.requestCachePolicy = .reloadIgnoringLocalCacheData
config.urlCache = nil
let session = URLSession.init(configuration: config)

session.dataTask(with: url) { (data, response, error) in
if let err = error {
let result = self.getDataFromLocalDatabase()
completion(result,err)
return
}

do{
let feedbacks = try JSONDecoder().decode(Feedback.self, from: data!)
DispatchQueue.main.async {
self.updateLocalDatabase(items: feedbacks.items)
print("Syncing Local Database Finished")
let result = self.getDataFromLocalDatabase()
completion(result,nil)
}
}catch let parseError {
let result = self.getDataFromLocalDatabase()
completion(result,parseError)
}
}.resume()
}

func updateLocalDatabase(items: [FeedbackItem]){
print("Updating Local Database")
managedObjectContext.performAndWait {
for item in items {
_ = FeedbackItemEntity.getOrCreate(item: item, context: self.managedObjectContext)
do {
try self.managedObjectContext.save()
}catch let error {
print("Core Data Error : ",error)
}
}
print("Local Database Updated")
}
}

func getDataFromLocalDatabase() -> [FeedbackItem]{
print("Local Data Fetching Started")
let request: NSFetchRequest<FeedbackItemEntity> = NSFetchRequest<FeedbackItemEntity>(entityName:"FeedbackItemEntity")
request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending:false)]

do {
let fetchedObjects = try self.managedObjectContext.fetch(request)
print("Local Data Fetched With Count -> " , fetchedObjects.count)
return fetchedObjects.map({ return $0.getObjectFromEntity() })
} catch let error{
print("Core Data fetch error : ", error)
return [FeedbackItem]()
}
}

}
```


