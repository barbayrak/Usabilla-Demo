//
//  ChartViewModel.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 16.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation
import Charts

class ChartViewModel : NSObject {

    var titleString : String
    var chartType : ChartType = ChartType.Pie
    var groupedData : [String : [Any]]
    
    init(items : [Item] , kpi : KPI, defaultChartType : ChartType){
        self.chartType = defaultChartType
        
        switch kpi {
        case KPI.Browser:
            titleString = "Browsers"
            let browserData = items.map({ return $0.browser })
            groupedData = Dictionary(grouping: browserData, by: { $0.name })
        case KPI.Platform:
            titleString = "Platforms"
            let platformData = items.map({ return $0.browser })
            groupedData = Dictionary(grouping: platformData, by: { $0.platform })
        case KPI.GeoLocation:
            titleString = "GeoLocations"
            let geoData = items.map({ return $0.geo })
            groupedData = Dictionary(grouping: geoData, by: { $0.countryCode })
        case KPI.Rating:
            titleString = "Ratings"
            let ratingData = items.map({ return $0.rating })
            groupedData = Dictionary(grouping: ratingData, by: { $0.description })
        case KPI.Label:
            titleString = "Labels"
            var labelData = [String]()
            for item in items{
                labelData = labelData + item.labels
            }
            groupedData = Dictionary(grouping: labelData, by: { $0 })
        }
        
    }
    
}
