//
//  DashboardFilterController.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 18.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit

protocol DashboardFilterDelegate {
    func filterApplied(fromDate: Int , toDate: Int , fromRating : Int)
}

class DashboardFilterController: UIViewController {

    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var ratingSegmented: UISegmentedControl!
    @IBOutlet weak var completeButton: UIButton!
    
    var maxDate : Int!
    var minDate : Int!
    var fromRating : Int!
    
    var delegate : DashboardFilterDelegate?
    var dateFormatter = DateFormatter()
    
    var filterMinDate : Int!
    var filterMaxDate : Int!
    var filteredRating : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDateFormatter()
        setupViews()
    }
    
    func setupViews(){
        completeButton.layer.cornerRadius = 3
        filterMinDate = minDate
        filterMaxDate = maxDate
        filteredRating = fromRating
        startDateTextField.text = dateFormatter.string(from:  Date(timeIntervalSince1970: Double(minDate)))
        endDateTextField.text = dateFormatter.string(from: Date(timeIntervalSince1970: Double(maxDate)))
        
        switch fromRating {
        case 1: ratingSegmented.selectedSegmentIndex = 0
        case 2: ratingSegmented.selectedSegmentIndex = 1
        case 3: ratingSegmented.selectedSegmentIndex = 2
        case 4: ratingSegmented.selectedSegmentIndex = 3
        case 5: ratingSegmented.selectedSegmentIndex = 4
        default: ratingSegmented.selectedSegmentIndex = 0
        }
    }
    
    func setupDateFormatter(){
        dateFormatter.dateFormat = "MMM d, yyyy"
    }
    
    @IBAction func ratingChanged(_ sender: Any) {
        self.filteredRating = self.ratingSegmented.selectedSegmentIndex + 1
    }

    @IBAction func startDateEditing(_ sender: Any) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date(timeIntervalSince1970: Double(filterMinDate))
        datePickerView.maximumDate = Date(timeIntervalSince1970: Double(filterMaxDate))
        datePickerView.setDate(Date(timeIntervalSince1970: Double(filterMinDate)), animated: false)
        startDateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
    }
    
    @IBAction func endDateEditing(_ sender: Any) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date(timeIntervalSince1970: Double(filterMinDate))
        datePickerView.maximumDate = Date(timeIntervalSince1970: Double(filterMaxDate))
        datePickerView.setDate(Date(timeIntervalSince1970: Double(filterMaxDate)), animated: false)
        endDateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        if(startDateTextField.isFirstResponder){
            filterMinDate = Int(sender.date.timeIntervalSince1970)
            startDateTextField.text = dateFormatter.string(from: sender.date)
        }else if(endDateTextField.isFirstResponder){
            filterMaxDate = Int(sender.date.timeIntervalSince1970)
            endDateTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    @IBAction func clearFilterTapped(_ sender: Any) {
        setupViews()
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.filterApplied(fromDate: self.filterMinDate!, toDate: self.filterMaxDate!, fromRating: self.filteredRating!)
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
