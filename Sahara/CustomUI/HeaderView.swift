//
//  HeaderView.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/25/21.
//

import Foundation
import UIKit

class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHeader()
    }
    
    func setupHeader() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = self.bounds
        
        // Set an array of CGColors to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).cgColor, UIColor(red: 150/255, green: 180/255, blue: 180/255, alpha: 0.80).cgColor]
        
        // Rasterize this layer to improve perfromance
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the background
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        // Diagonal: top left to bottom corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // top left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // bottom right
    }
}
