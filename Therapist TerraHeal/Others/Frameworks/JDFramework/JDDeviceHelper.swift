//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

public class JDDeviceHelper {
    public enum Direction {
        case horizontal, vertical
    }
    public struct DeviceList {
        public struct iPhone5 {
            public static let screenWidth: CGFloat = 320
            public static let screenHeight: CGFloat = 568
        }
        
        public struct iPhoneSE {
            public static let screenWidth: CGFloat = 320
            public static let screenHeight: CGFloat = 568
        }
        
        public struct iPhone5c {
            public static let screenWidth: CGFloat = 320
            public static let screenHeight: CGFloat = 568
        }
        
        public struct iPhone6 {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 667
        }
        
        public struct iPhone6Plus {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 736
        }
        
        public struct iPhone6s {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 667
        }
        
        public struct iPhone6sPlus {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 736
        }
        
        public struct iPhone7 {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 667
        }
        
        public struct iPhone7Plus {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 736
        }
        
        public struct iPhone8 {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 667
        }
        
        public struct iPhone8Plus {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 736
        }
        
        public struct iPhoneX {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 812
        }
        
        public struct iPhoneXS {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 812
        }
        
        public struct iPhoneXSMax {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 896
        }
        
        public struct iPhoneXR {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 896
        }
        
        public struct iPhone11 {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 896
        }
        
        public struct iPhone11Pro {
            public static let screenWidth: CGFloat = 375
            public static let screenHeight: CGFloat = 812
        }
        
        public struct iPhone11ProMax {
            public static let screenWidth: CGFloat = 414
            public static let screenHeight: CGFloat = 896
        }
    }

    
    public init() {}
    
    public func offseter(scaleFactor: CGFloat = 1.0, offset: CGFloat, direction: Direction = .horizontal, currentDeviceBound: CGFloat = 375) -> CGFloat {
        switch direction {
        case .horizontal:
            return (offset * UIScreen.main.bounds.width * scaleFactor) / currentDeviceBound
        case .vertical:
            return (offset * UIScreen.main.bounds.height * scaleFactor) / currentDeviceBound
        }
    }

    public func fontCalculator(size:CGFloat,referenceSize:CGFloat = 375,minimumSize:CGFloat = 0.0,maximumSize:CGFloat = 0.0, isAutoCalculate:Bool = true, direction: Direction = Direction.horizontal) -> CGFloat {
        var finalFontSize = size
        if isAutoCalculate {
            var multiplier: CGFloat  = 1.0

            switch direction {
            case .horizontal:
                multiplier = CGFloat(UIScreen.main.bounds.width/referenceSize)
            case .vertical:
                multiplier = CGFloat(UIScreen.main.bounds.height/referenceSize)
            }
            finalFontSize = size * multiplier;
            if finalFontSize < minimumSize && minimumSize != 0.0{
                finalFontSize = minimumSize
            }
            if finalFontSize > maximumSize && maximumSize != 0.0{
                finalFontSize = maximumSize
            }

        }

        return finalFontSize
    }
    
    public func getDevice() {
        
    }
}
