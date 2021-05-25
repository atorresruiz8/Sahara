//
//  CustomButton.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/25/21.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor = UIColor.systemGray6
        layer.borderWidth = 2
        layer.cornerRadius = 15.0
        layer.cornerCurve = .continuous
    }
}
