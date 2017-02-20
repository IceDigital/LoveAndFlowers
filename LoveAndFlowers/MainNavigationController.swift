//
//  MainNavigationController.swift
//  LoveAndFlowers
//
//  Created by Vitalis on 31.12.16.
//  Copyright © 2016 IceDigital. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    var isGesture=false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarHidden(true, animated: false)
        self.interactivePopGestureRecognizer?.delegate = self
        
        
        let menuVC=self.storyboard!.instantiateViewController(withIdentifier: "MenuController");
        (menuVC.view as! MenuView).navigationController = self
        self.view.addSubview(menuVC.view);
        
        self.delegate=menuVC.view as! UINavigationControllerDelegate?
        
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(self.handlePopGesture))
    }
    
    
    func handlePopGesture(gesture:UIGestureRecognizer)
    {
        switch (gesture.state)
        {
        case UIGestureRecognizerState.began:
            isGesture=true
            break
        case UIGestureRecognizerState.ended:
            isGesture=false
            break
        case UIGestureRecognizerState.cancelled:
            isGesture=false
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
    
    // This is necessary because without it, subviews of your top controller can
    // cancel out your gesture recognizer on the edge.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
