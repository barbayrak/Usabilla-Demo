//
//  DashboardController.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 16.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {

    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    
    var feedbacks = [Feedback]()
    var feedbackViewModels = [ChartViewModel]()
    let cellId = "chartCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData(){
        FeedbackService.shared.fetchFeedbacks { (result) in
            switch result {
            case .success(let feedback):
                self.feedbackViewModels = [
                    ChartViewModel(items: feedback.items, kpi: KPI.Browser),
                    ChartViewModel(items: feedback.items, kpi: KPI.Rating),
                    ChartViewModel(items: feedback.items, kpi: KPI.GeoLocation),
                    ChartViewModel(items: feedback.items, kpi: KPI.Label),
                    ChartViewModel(items: feedback.items, kpi: KPI.Platform)
                ]
                DispatchQueue.main.async {
                    self.dashboardCollectionView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dashboardCollectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension DashboardController : UICollectionViewDelegate {
    
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
