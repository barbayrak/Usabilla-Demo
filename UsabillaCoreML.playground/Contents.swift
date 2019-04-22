import Cocoa
import CreateML
import CreateMLUI
let desktopDir = NSSearchPathForDirectoriesInDomains(.desktopDirectory,
                                                     .userDomainMask, true)
let jsonDirectory = desktopDir.first!.description + "/usabillaCache.json"

var dataTable = try MLDataTable(contentsOf: URL(fileURLWithPath: jsonDirectory))
dataTable.removeColumn(named: "country")
dataTable.removeColumn(named: "version")
dataTable.removeColumn(named: "platform")

let (trainingData, testingData) = dataTable.randomSplit(by: 0.8)
let ratingPredictorRegressor = try MLRegressor(trainingData: trainingData, targetColumn: "rating")
let evaluationMetricsRegressor = ratingPredictorRegressor.evaluation(on: testingData)

let params = MLBoostedTreeRegressor.ModelParameters(maxIterations: 1000)
let ratingPredictorBoosted = try MLBoostedTreeRegressor(trainingData: trainingData, targetColumn: "rating", parameters: params)
let evaluationMetricsBoosted = ratingPredictorBoosted.evaluation(on: testingData)

let regressorError = evaluationMetricsRegressor.rootMeanSquaredError
let boostedError = evaluationMetricsBoosted.rootMeanSquaredError

if(regressorError < boostedError){
    //Train all data instead of splitting 80:20
    //Better performance on linear regression
    let ratingPredictorRegressor = try MLRegressor(trainingData: dataTable, targetColumn: "rating")
    let metadata = MLModelMetadata(author: "Kaan Baris Bayrak", shortDescription: "Regression rating prediction over time", version: "1.0")
    do {
        try ratingPredictorRegressor.write(to: URL(fileURLWithPath: desktopDir.first!.description + "/ratingPredictor.mlmodel"), metadata: metadata)
    }catch let err {
        print(err)
    }
}else{
    //Train all data instead of splitting 80:20
    //Better performance on boosted trees
    let params = MLBoostedTreeRegressor.ModelParameters(maxIterations: 1000)
    let ratingPredictorBoosted = try MLBoostedTreeRegressor(trainingData: dataTable, targetColumn: "rating", parameters: params)
    let metadata = MLModelMetadata(author: "Kaan Baris Bayrak", shortDescription: "Boosted tree rating prediction over time", version: "1.0")
    do {
        try ratingPredictorBoosted.write(to: URL(fileURLWithPath: desktopDir.first!.description + "/ratingPredictor.mlmodel"), metadata: metadata)
    }catch let err {
        print(err)
    }
}


