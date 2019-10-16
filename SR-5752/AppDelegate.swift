//
//  AppDelegate.swift
//  SR-5752
//
//  Created by mrfour on 2019/10/16.
//  Copyright © 2019 mrfour. All rights reserved.
//

import UIKit

class C: NSObject {
    @objc dynamic var foo: String = "Foo"

    var observer: NSKeyValueObservation?

    override init() {
        super.init()

        self.observer = self.observe(\.foo) { s, _ in
            print("foo changed: \(s.foo)")
        }
    }

    deinit {
        print("deinit was called")
        if #available(iOS 11.0, *) {} else if let observer = observer {
            // This works.
            removeObserver(observer, forKeyPath: "foo")
        }

        // Both of them don't work.
        //
        // self.observer?.invalidate()
        // self.observer = nil
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let c = C()
        c.foo = "Bar"

        return true
    }

}
