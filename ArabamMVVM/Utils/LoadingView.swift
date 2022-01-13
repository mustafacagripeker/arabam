//
//  LoadingView.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 13.01.2022.
//

import Foundation
import Lottie
import UIKit



let KAppDelegate = UIApplication.shared.delegate as! AppDelegate


class LoadingView : NSObject {

    static var shared : LoadingView {
        return LoadingView()
    }
    private override init() {}
    
    

    func showActivityIndicator() {
        DispatchQueue.main.async {
            let mainVw = UIView()
            let lottieView = AnimationView(name: "sell")
            lottieView.play()
            let imageView = UIImageView()
            mainVw.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1074486301)
            mainVw.tag = 100
            //imageView.image = UIImage.gifImageWithName("spinnerr")
            if #available(iOS 13.0, *) {
                let window = (UIApplication.shared.windows.first { w in
                    w.isKeyWindow
                }) ?? UIApplication.shared.windows.first
                
                mainVw.frame = CGRect(x: 0, y: 0, width: ((window?.rootViewController?.view.frame.width)!), height: (window?.rootViewController?.view.frame.height)!)
                lottieView.frame = CGRect(x: (mainVw.frame.width)/2-50 , y: (mainVw.frame.height)/2-50, width: 100, height: 100)
                mainVw.addSubview(lottieView)
                window?.rootViewController!.view.addSubview(mainVw)
            }else {
                mainVw.frame = CGRect(x: 0, y: 0, width: (KAppDelegate.window?.rootViewController?.view.frame.width)!, height: (KAppDelegate.window?.rootViewController?.view.frame.height)!)
                lottieView.frame = CGRect(x: (mainVw.frame.width)/2-50 , y: (mainVw.frame.height)/2-50, width: 100, height: 100)
                mainVw.addSubview(lottieView)
                KAppDelegate.window?.rootViewController!.view.addSubview(mainVw)
            }
        }
    }

    func hideActivityIndicator()  {
        var theSubviews = [UIView]()
        if #available(iOS 13.0, *) {
            let window = (UIApplication.shared.windows.first { w in
                w.isKeyWindow
            }) ?? UIApplication.shared.windows.first
            theSubviews = (window?.rootViewController?.view.subviews)!
        } else {
            theSubviews = (KAppDelegate.window?.rootViewController?.view.subviews)!
        }
        for subview in theSubviews {
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
    
}


}
