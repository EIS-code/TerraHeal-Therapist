//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class PreferenceHelper: NSObject {
 
   
    // MARK: User Preference Keys
    private let KEY_USER_ID = "user_id"
    private let KEY_SESSION_TOKEN = "session_token"
    private let KEY_DEVICE_TOKEN = "device_token";
    private let KEY_IS_SHOW_TUTORIAL = "is_show_tutorial";
    
    let ph = UserDefaults.standard;
    static let shared = PreferenceHelper()
    private override init(){
    }
    
    deinit {
       //print("\(self) \(#function)")
    }

    // MARK: Preference User Getter Setters
    func setDeviceToken(_ token:String) {
        ph.set(token, forKey: KEY_DEVICE_TOKEN);
        ph.synchronize();
    }
    func getDeviceToken() -> String {
        return (ph.value(forKey: KEY_DEVICE_TOKEN) as? String) ?? ""
    }
    func setUserId(_ userId:String) {
        ph.set(userId, forKey: KEY_USER_ID);
        ph.synchronize();
    }
    func getUserId() -> String {
        return (ph.value(forKey: KEY_USER_ID) as? String) ?? ""
    }


    func setSessionToken(_ sessionToken:String) {
        ph.set(sessionToken, forKey: KEY_SESSION_TOKEN);
        ph.synchronize();
    }
    func getSessionToken() -> String {
        return (ph.value(forKey: KEY_SESSION_TOKEN) as? String) ?? ""
    }

    func setIsShowTutorial(_ show:Bool) {
        ph.set(show, forKey: KEY_IS_SHOW_TUTORIAL);
        ph.synchronize();
    }
    func getIsShowTutorial() -> Bool {
        return (ph.value(forKey: KEY_IS_SHOW_TUTORIAL) as? Bool) ?? true
    }
    
    func clearAll() {
        let deviceToken: String = PreferenceHelper().getDeviceToken()
        ph.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        ph.synchronize();
        PreferenceHelper().setDeviceToken(deviceToken)
    }
}
