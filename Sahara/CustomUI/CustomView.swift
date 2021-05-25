//
//  CustomView.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/25/21.
//

import Foundation
import UIKit

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        layer.cornerRadius = 15.0
        layer.masksToBounds = true
    }
}
