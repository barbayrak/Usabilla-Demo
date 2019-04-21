//
//  ChartCollectionViewCell.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 16.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit
import Charts

class ChartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chartStyleControl: UISegmentedControl!
    
    var chartViewModel : ChartViewModel! {
        didSet{
            self.title.text = chartViewModel.titleString
            self.chartStyle = chartViewModel.chartType
        }
    }
    
    var chartStyle : ChartType! {
        didSet{
            switch chartStyle! {
            case .Pie:
                chartStyleControl.selectedSegmentIndex = 0
                initPieChart(data: chartViewModel.groupedData)
            case .Bar:
                chartStyleControl.selectedSegmentIndex = 1
                initBarChart(data: chartViewModel.groupedData)
            case .HorizontalBar:
                chartStyleControl.selectedSegmentIndex = 2
                initHorizontalBarChart(data: chartViewModel.groupedData)
            }
        }
        willSet{
            resetChartView()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = ""
        resetChartView()
    }
    
    func resetChartView(){
        for subviews in chartView.subviews {
            subviews.removeFromSuperview()
        }
    }
    
    func setupViews(){
        title.adjustsFontSizeToFitWidth = true
        cardBackgroundView.layer.cornerRadius = 6
    }
    
    func initPieChart(data : [String : [Any]]){
        let dataKeyArray = Array(data.keys)
        let dataValuesArray = Array(data.values)
        
        let chart = PieChartView()
        chart.frame = CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.height)
        chart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        var data = [PieChartDataEntry]()
        for i in 0..<dataKeyArray.count {
            data.append(PieChartDataEntry(value: Double(dataValuesArray[i].count), label: dataKeyArray[i].description ))
        }
        
        let chartDataset = PieChartDataSet(values: data, label: "")
        chartDataset.colors = colors
        let chartData = PieChartData(dataSet: chartDataset)
        
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        percentageFormatter.maximumFractionDigits = 1
        percentageFormatter.percentSymbol = "%"
        percentageFormatter.multiplier = 1
        chartData.setValueFormatter(DefaultValueFormatter(formatter: percentageFormatter))
        
        chart.data = chartData
        chart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        chartView.addSubview(chart)
    }
    
    func initBarChart(data : [String : [Any]]){
        let dataKeyArray = Array(data.keys)
        let dataValuesArray = Array(data.values)
        
        let chart = BarChartView()
        chart.frame = CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.height)
        chart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        var data = [BarChartDataSet]()
        for i in 0..<dataKeyArray.count {
            let value = [BarChartDataEntry(x: Double(i), y: Double(dataValuesArray[i].count))]
            let dataSet = BarChartDataSet(values: value, label: dataKeyArray[i].description)
            dataSet.colors = [colors[i % colors.count]]
            data.append(dataSet)
        }
        
        let chartData = BarChartData(dataSets: data)
        
        let valueFormatter = NumberFormatter()
        valueFormatter.numberStyle = .none
        valueFormatter.multiplier = 1
        chartData.setValueFormatter(DefaultValueFormatter(formatter: valueFormatter))
        
        chart.data = chartData
        
        chart.xAxis.drawLabelsEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        
        chart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        chartView.addSubview(chart)
    }
    
    func initHorizontalBarChart(data : [String : [Any]]){
        let dataKeyArray = Array(data.keys)
        let dataValuesArray = Array(data.values)
        
        let chart = HorizontalBarChartView()
        chart.frame = CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.height)
        chart.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        

        var data = [BarChartDataSet]()
        for i in 0..<dataKeyArray.count {
            let value = [BarChartDataEntry(x: Double(i), y: Double(dataValuesArray[i].count))]
            let dataSet = BarChartDataSet(values: value, label: dataKeyArray[i].description)
            dataSet.colors = [colors[i % colors.count]]
            data.append(dataSet)
        }
        
        let chartData = BarChartData(dataSets: data)
        
        let valueFormatter = NumberFormatter()
        valueFormatter.numberStyle = .none
        valueFormatter.multiplier = 1
        chartData.setValueFormatter(DefaultValueFormatter(formatter: valueFormatter))
        
        chart.data = chartData
        
        chart.xAxis.drawLabelsEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        
        chart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        chartView.addSubview(chart)
    }
    
    @IBAction func chartStyleChanged(_ sender: Any) {
        switch chartStyleControl.selectedSegmentIndex {
        case 0:
            chartViewModel.chartType = ChartType.Pie
            self.chartStyle = ChartType.Pie
        case 1:
            chartViewModel.chartType = ChartType.Bar
            self.chartStyle = ChartType.Bar
        case 2:
            chartViewModel.chartType = ChartType.HorizontalBar
            self.chartStyle = ChartType.HorizontalBar
        default:
            break
        }
    }
    
    
}
