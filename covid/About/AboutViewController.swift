//
//  AboutViewController.swift
//  covid
//
//  Created by Pavel Odstrčilík on 30.12.2020.
//

import Foundation
import UIKit

open class AboutViewController: UIViewController {

    let aboutLabel = UILabel()
    let urlTextView = UITextView()
    let authorLabel = UILabel()
    let authorEmailTextView = UITextView()

    open override func viewDidLoad() {
        self.view.backgroundColor = .white
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        prepareAboutLabel()
        prepareUrlTextView()
        prepareAuthorLabel()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareAboutLabel() {
        view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        aboutLabel.text = "Aplikace zobrazuje nejaktuálnější data z otevřených datových sad nemoci COVID-19 v České republice. \n \n Zdroj dat: Národní zdravotnický informační systém, Krajské hygienické stanice, Ministerstvo zdravotnictví ČR"
        aboutLabel.numberOfLines = 0
    }

    open func prepareUrlTextView() {
        view.addSubview(urlTextView)
        urlTextView.snp.makeConstraints { (make) in
            make.top.equalTo(aboutLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
        }
        urlTextView.isEditable = false
        urlTextView.dataDetectorTypes = .link
        urlTextView.text = "https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19"
        urlTextView.font = .systemFont(ofSize: 16)
        urlTextView.textAlignment = .center
    }

    open func prepareAuthorLabel() {
        view.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        authorLabel.text = "Vytvořil Pavel Odstrčilík \n pavelodstrcilik@gmail.com"
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .center
        authorLabel.font = .systemFont(ofSize: 17, weight: .regular)
        authorLabel.textColor = .darkText
    }
}
