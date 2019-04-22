//
//  DashboardController.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 16.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit
import CoreData

class DashboardController: UIViewController {

    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    
    var feedbacks = [FeedbackItem]()
    var feedbackViewModels = [ChartViewModel]()
    
    
    var longPressGesture: UILongPressGestureRecognizer!
    let cellId = "chartCellId"
    let filterSegueId = "filter"
    let insightSegueId = "insight"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()
        fetchData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dashboardCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupGestures(){
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        dashboardCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    func fetchData(){
        FeedbackService.shared.fetchAndSyncFeedbacks { (feedbacks, error) in
            if let err = error {
                print(err)
            }
            
            self.feedbacks = feedbacks ?? [FeedbackItem]()
            self.feedbackViewModels = [
                ChartViewModel(items: self.feedbacks, kpi: KPI.Browser , defaultChartType : ChartType.Pie),
                ChartViewModel(items: self.feedbacks, kpi: KPI.Rating , defaultChartType : ChartType.HorizontalBar),
                ChartViewModel(items: self.feedbacks, kpi: KPI.GeoLocation , defaultChartType : ChartType.Bar),
                ChartViewModel(items: self.feedbacks, kpi: KPI.Label , defaultChartType : ChartType.Bar),
                ChartViewModel(items: self.feedbacks, kpi: KPI.Platform , defaultChartType : ChartType.Pie)
            ]
            DispatchQueue.main.async {
                self.dashboardCollectionView.reloadData()
            }
        }
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = dashboardCollectionView.indexPathForItem(at: gesture.location(in: dashboardCollectionView)) else { break }
            dashboardCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            dashboardCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            dashboardCollectionView.endInteractiveMovement()
        default:
            dashboardCollectionView.cancelInteractiveMovement()
        }
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        self.performSegue(withIdentifier: filterSegueId, sender: nil)
    }
    
    @IBAction func insightTapped(_ sender: Any) {
        self.performSegue(withIdentifier: insightSegueId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == filterSegueId){
            let destination = segue.destination as! DashboardFilterController
            destination.delegate = self
            destination.maxDate = self.feedbacks.sorted(by: { $0.createdAt > $1.createdAt }).first?.createdAt
            destination.minDate = self.feedbacks.sorted(by: { $0.createdAt < $1.createdAt }).first?.createdAt
            destination.fromRating = 1
        }else if(segue.identifier == insightSegueId){
            let destination = segue.destination as! InsightsController
            destination.feedbacks = self.feedbacks
        }
    }
    
}

extension DashboardController : DashboardFilterDelegate {
    
    func filterApplied(fromDate: Int, toDate: Int, fromRating: Int) {
        
        let filteredFeedbacks = self.feedbacks.filter { (feedback) -> Bool in
            return ((feedback.createdAt >= fromDate) && (feedback.createdAt <= toDate) && (feedback.rating >= fromRating))
        }
        self.feedbackViewModels = [
            ChartViewModel(items: filteredFeedbacks, kpi: KPI.Browser , defaultChartType : ChartType.Pie),
            ChartViewModel(items: filteredFeedbacks, kpi: KPI.Rating , defaultChartType : ChartType.HorizontalBar),
            ChartViewModel(items: filteredFeedbacks, kpi: KPI.GeoLocation , defaultChartType : ChartType.Bar),
            ChartViewModel(items: filteredFeedbacks, kpi: KPI.Label , defaultChartType : ChartType.Bar),
            ChartViewModel(items: filteredFeedbacks, kpi: KPI.Platform , defaultChartType : ChartType.Pie)
        ]
        DispatchQueue.main.async {
            self.dashboardCollectionView.reloadData()
        }
    }
}

extension DashboardController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedbackViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChartCollectionViewCell
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        cell.chartViewModel = self.feedbackViewModels[indexPath.row]
        cell.setupViews()
        return cell
    }
    
}

extension DashboardController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempViewModel = self.feedbackViewModels[sourceIndexPath.row]
        self.feedbackViewModels.remove(at: sourceIndexPath.row)
        self.feedbackViewModels.insert(tempViewModel, at: destinationIndexPath.row)
        collectionView.reloadItems(at: [destinationIndexPath])
    }
}

extension DashboardController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        switch device {
        case .pad:
            //Ipad
            if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
                return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
            }else{
                return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height / 2)
            }
        default:
            //Iphone
            if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            }else{
                return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
            }
        }
    }
    
}
