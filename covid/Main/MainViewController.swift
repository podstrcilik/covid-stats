//
//  MainViewController.swift
//  covid
//
//  Created by Pavel Odstrčilík on 30.12.2020.
//

import Foundation
import Alamofire
import RealmSwift

open class MainViewController: UIViewController {
    let confirmedCasesTodayPanel = ConfirmedCasesTodayPanel()
    let confirmedCasesYesterdayPanel = ConfirmedCasesYesterdayPanel()
    let testsPerformedYesterdayPanel = TestsPerformedYesterdayPanel()
    let deathsTotalPanel = DeathsTotalPanel()
    let testsPerformedByRegionPanel = TestsPerformedByRegionPanel()
    let toDateLabel = UILabel()
    let stackView = UIStackView()
    var isFirstTime = true

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstTime ? isFirstTime = false : callApi()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        prepareView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareView() {
        prepareStackView()
        prepareGestureRecognizer()
        prepareToDateLabel()
        updateToDateLabel()
        testsPerformedByRegionPanel.isUserInteractionEnabled = true
        self.view.backgroundColor = .white
    }

    open func callApi() {
        AF.request(RequestType.basicOverview.url)
            .responseJSON { response in
                if let dict = response.value as? [String: AnyObject] {
                    if let datas = dict["data"] as? [[String: AnyObject]] {
                        guard let object = BasicOverviewDataObject(JSON: datas.first ?? [:]),
                              let overviewObject = BasicOverviewObject(JSON: dict) else {
                            return
                        }
                        RealmService.shared.delete(type: BasicOverviewDataObject.self)
                        RealmService.shared.delete(type: BasicOverviewObject.self)
                        RealmService.shared.create(overviewObject)
                        RealmService.shared.create(object)
                        self.updatePanels()
                        self.updateToDateLabel()
                    }
                }
            }
    }

    open func updatePanels() {
        self.confirmedCasesTodayPanel.updateView()
        self.confirmedCasesYesterdayPanel.updateView()
        self.testsPerformedYesterdayPanel.updateView()
        self.deathsTotalPanel.updateView()
    }

    open func prepareStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(confirmedCasesTodayPanel)
        stackView.addArrangedSubview(confirmedCasesYesterdayPanel)
        stackView.addArrangedSubview(testsPerformedYesterdayPanel)
        stackView.addArrangedSubview(deathsTotalPanel)
        stackView.addArrangedSubview(testsPerformedByRegionPanel)
        stackView.backgroundColor = .white
        stackView.isUserInteractionEnabled = true
    }

    open func prepareGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(confirmedCasesByRegionTouched))
        testsPerformedByRegionPanel.isUserInteractionEnabled = true
        testsPerformedByRegionPanel.addGestureRecognizer(tap)
    }

    @objc func confirmedCasesByRegionTouched() {
        self.navigationController?.pushViewController(RegionViewController(), animated: true)
    }

    open func prepareToDateLabel() {
        view.addSubview(toDateLabel)
        toDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
        }
        toDateLabel.font = .systemFont(ofSize: 17, weight: .light)
    }

    open func updateToDateLabel() {
        guard let overviewObject = RealmService.shared.realm.objects(BasicOverviewObject.self).first else {
            self.toDateLabel.text = "N/A"
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        if let date = dateFormatter.date(from: overviewObject.modified) {
            self.toDateLabel.text = "K datu \(date.getFormattedDate(format: "dd.MM.yyyy HH:mm"))"
        }
    }

    @objc func applicationDidBecomeActive(notification: NSNotification) {
        callApi()
    }
}
