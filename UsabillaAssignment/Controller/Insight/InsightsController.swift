//
//  InsightsController.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 18.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit
import CoreML

class InsightsController: UIViewController {
    
    @IBOutlet weak var insightCollectionView: UICollectionView!
    
    var feedbacks = [Item]()
    var insighst = [InsightViewModel]()
    
    let cellId = "insightCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInsights()
    }
    
    func setupInsights(){
        insighst = [
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.RatingPrediction),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.BrowserHighRatingAnalysis),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.BrowserLowRatingAnalysis),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.LocationHighRatingAnalysis),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.LocationLowRatingAnalysis),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.PlatformHighRatingAnalysis),
            InsightViewModel(items: self.feedbacks, targetAnalysis: TargetAnalysis.PlatformLowRatingAnalysis)
        ]
    
        insightCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        insightCollectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension InsightsController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.insighst.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InsightCollectionViewCell
        cell.insightViewModel = self.insighst[indexPath.row]
        cell.setupViews()
        return cell
    }
    
}

extension InsightsController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        switch device {
        case .pad:
            //Ipad
            if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
                return CGSize(width: collectionView.frame.width / 2, height: 80)
            }else{
                return CGSize(width: collectionView.frame.width / 3, height: 80)
            }
        default:
            //Iphone
            if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
                return CGSize(width: collectionView.frame.width, height: 80)
            }else{
                return CGSize(width: collectionView.frame.width / 2, height: 80)
            }
        }
        
    }
    
}

