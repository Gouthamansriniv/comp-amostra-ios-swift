//
//  ColorPicker.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/9/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit

class ColorPicker: NSObject {

    static let sharedInstance = ColorPicker()
    var currentColor: Int = 0xDF343D;
    
    enum DeliveryColors: UInt32 {
        case RED
        case BLUE
        case ORANGE
        
        private static let _count: DeliveryColors.RawValue = {
            // find the maximum enum value
            var maxValue: UInt32 = 0
            while let _ = DeliveryColors(rawValue: maxValue) {
                maxValue += 1
            }
            return maxValue
        }()
        
        static func randomColor() -> DeliveryColors {
            // pick and return a new value
            let rand = arc4random_uniform(_count)
            return DeliveryColors(rawValue: rand)!
        }
    }
    
    override init() {
        super.init()
        
        let color = DeliveryColors.randomColor()
        
        switch (color) {
            
        case .ORANGE:
            currentColor = 0xF89645;
            
        case .BLUE:
            currentColor = 0x5DB0DB;
            
        default:
            currentColor = 0xDF343D;
        }
    }
    
    func getColor() -> Int {
        return currentColor;
    }
}
