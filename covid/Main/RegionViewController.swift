//
//  RegionViewController.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation
import UIKit
import Alamofire

open class RegionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    let regionPicker = UIPickerView()
    let regionPickerTextField = UITextField()
    let topLabel = UILabel()
    let performedTestsYesterday = CorePanelView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let offset = 10

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        prepareView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareView() {
        prepareTopLabel()
        preparePicker()
        prepareTextField()
        prepareToolBar()
        preparePanelView()
        prepareDefaultPickerValue()
        prepareActivityIndicator()
        self.view.backgroundColor = .white
        self.title = "Provedené testy dle krajů"
    }

    open func prepareDefaultPickerValue() {
        let savedRegionObject = RealmService.shared.realm.objects(RegionObject.self).first
        let regionType = RegionType(rawValue: savedRegionObject?.region ?? "")
        for (index, element) in RegionType.allCases.enumerated() {
            if element == regionType {
                regionPicker.selectRow(index, inComponent: 0, animated: false)
                regionPickerTextField.text = element.title
                getApi(region: element)
            }
        }
    }

    open func prepareTopLabel() {
        topLabel.text = "Zvolený kraj:"
        topLabel.font = .systemFont(ofSize: 19, weight: .regular)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(offset)
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
    }

    open func preparePicker() {
        regionPicker.delegate = self
    }

    open func prepareTextField() {
        view.addSubview(regionPickerTextField)
        regionPickerTextField.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-offset)
            make.leading.equalToSuperview().offset(offset)
            make.height.equalTo(40)
        }

        regionPickerTextField.inputView = regionPicker
        regionPickerTextField.delegate = self
        regionPickerTextField.text = "Zvolte kraj"
        regionPickerTextField.layer.borderWidth = 1
        regionPickerTextField.borderStyle = .roundedRect
        regionPickerTextField.layer.borderColor = UIColor.systemGray.cgColor
        regionPickerTextField.layer.cornerRadius = 5
        regionPickerTextField.textColor = UIColor.black.withAlphaComponent(0.96)
    }

    open func prepareToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Hotovo", style: .plain, target: self, action: #selector(closePickerView))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        regionPickerTextField.inputAccessoryView = toolBar
    }

    open func preparePanelView() {
        view.addSubview(performedTestsYesterday)
        performedTestsYesterday.snp.makeConstraints { (make) in
            make.top.equalTo(regionPickerTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        performedTestsYesterday.topLabel.text = "Počet provedených testů včera"
        performedTestsYesterday.wrapperView.backgroundColor = .systemIndigo
        performedTestsYesterday.topLabel.textColor = .white
        performedTestsYesterday.middleLabel.textColor = .white
    }

    open func prepareActivityIndicator() {
        performedTestsYesterday.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        activityIndicator.color = .white
    }

    @objc func closePickerView()
    {
        view.endEditing(true)
        getApi(region: RegionType.allCases[regionPicker.selectedRow(inComponent: 0)])
        RealmService.shared.delete(type: RegionObject.self)
        let regionObject = RegionObject()
        regionObject.region = RegionType.allCases[regionPicker.selectedRow(inComponent: 0)].rawValue
        RealmService.shared.create(regionObject)
    }

    open func getApi(region: RegionType) {
        activityIndicator.startAnimating()
        performedTestsYesterday.middleLabel.text = ""
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()

        AF.request(RequestType.regionsOverview.url)
            .responseJSON { response in
                if let dict = response.value as? [String: AnyObject] {
                    if let objects = dict["data"] as? [[String: AnyObject]] {
                        for data in objects {
                            if let regionObject = RegionOverviewDataObject(JSON: data), regionObject.date == yesterdayDate.getFormattedDate(format: "yyyy-MM-dd"),
                               regionObject.regionCode == region.code {
                                self.performedTestsYesterday.middleLabel.text = "\(regionObject.testsPerformed)"
                                self.activityIndicator.stopAnimating()
                                break
                            }
                        }
                    }
                }
            }
    }


    // MARK: - UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RegionType.allCases.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return RegionType.allCases[row].title
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        regionPickerTextField.text = RegionType.allCases[row].title
    }

    // MARK: - UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
