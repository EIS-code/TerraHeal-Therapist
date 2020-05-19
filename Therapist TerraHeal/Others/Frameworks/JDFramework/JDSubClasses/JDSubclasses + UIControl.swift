//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


public class NC: UINavigationController {

    override public var viewControllers: [UIViewController] {
        didSet {
            for vC in super.viewControllers {
                vC.clean()
            }

            for vC in oldValue {
                vC.clean()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = true
    }

    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        //self.clean()
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        let vC = super.popViewController(animated: animated)
        vC?.clean()
        return vC
    }

    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vCs = super.popToViewController(viewController, animated: animated)

        if vCs != nil {
            for vC in vCs! {
                vC.clean()
            }
        }

        return vCs
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vCs = super.popToRootViewController(animated: animated)

        if vCs != nil {
            for vC in vCs! {
                vC.clean()
            }
        }

        return vCs
    }

    deinit {
        //Log.i("\(self) \(#function)")
    }

}

public extension NC {

    func findVCs<T: UIViewController>(ofType vCType: T.Type) -> [T] {
        var vCs: [UIViewController] = []
        vCs = self.viewControllers.filter({ (vC: UIViewController) -> Bool in
            return vC.isKind(of: vCType)
        })

        return vCs as! [T]
    }

}

