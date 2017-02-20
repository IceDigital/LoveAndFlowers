//
//  MenuView.swift
//  LoveAndFlowers
//
//  Created by Vitalis on 31.12.16.
//  Copyright © 2016 IceDigital. All rights reserved.
//

import UIKit

class MenuView: UIView, UIScrollViewDelegate, UINavigationControllerDelegate {
    
    var navigationController:MainNavigationController!

    @IBOutlet weak var svMenu: UIScrollView!
    @IBOutlet weak var ivLogo: UIImageView!
    
    @IBOutlet weak var cnstrLogoHeight: NSLayoutConstraint!
    @IBOutlet weak var cnstrLogoVertical: NSLayoutConstraint!
    
    
    @IBOutlet weak var imgArrowDown: UIImageView!
    
    @IBOutlet weak var btnCatalog: UIButton!
    @IBOutlet weak var btnEvents: UIButton!
    @IBOutlet weak var btnMeetings: UIButton!
    @IBOutlet weak var btnAboutUs: UIButton!
    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vBack: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        svMenu.contentSize=CGSize(width: svMenu.frame.size.width, height: svMenu.frame.size.height*2)
    }

    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if(point.y<=80+svMenu.frame.size.height-svMenu.contentOffset.y)
        {
            let newPoint=CGPoint(x: point.x, y: point.y+svMenu.contentOffset.y)
            let child=vContainer.hitTest(newPoint, with: event);
            if(child==nil)
            {
                return svMenu
            }
            return child
        }
        else
        {
           return self.superview?.subviews[0].hitTest(point, with: event)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent=svMenu.contentOffset.y/svMenu.frame.size.height
        cnstrLogoVertical.constant=svMenu.contentOffset.y/2
        cnstrLogoHeight.constant=167-120*percent
        
        imgArrowDown.alpha = percent
        vBack.alpha = percent
        
        
        
        
    }
    
    
    @IBAction func btnMenu_TouchUpInside(_ sender: UIButton) {
        var RestorationId="";
        switch(sender)
        {
            case btnCatalog:
                RestorationId="CatalogViewController"
                break;
            case btnEvents:
                RestorationId="AboutUsViewController"
                break;
            case btnMeetings:
                RestorationId="AboutUsViewController"
                break;
            case btnAboutUs:
                RestorationId="AboutUsViewController"
                break;
        default:
            RestorationId="CatalogViewController"
            break
        }
        
        let controller=navigationController.storyboard?.instantiateViewController(withIdentifier: RestorationId);
        navigationController.viewControllers=[controller!,]
        
        hideMenu();
        
    }
    
    func hideMenu()
    {
        svMenu.goToPage(page: 1, animated: true);
    }
    

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let navController=navigationController as! MainNavigationController
        if(!navController.isGesture)
        {
            if(viewController == navigationController.viewControllers[0])
            {
                let _ = [UIView .animate(withDuration: CATransaction.animationDuration(), animations: {
                    self.btnBack.alpha=0
                })]
            }
            else{
                let _ = [UIView .animate(withDuration: CATransaction.animationDuration(), animations: {
                    self.btnBack.alpha=1
                })]
            }
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if(viewController == navigationController.viewControllers[0])
        {
            let _ = [UIView .animate(withDuration: CATransaction.animationDuration(), animations: {
                self.btnBack.alpha=0
            })]
        }
        else{
            let _ = [UIView .animate(withDuration: CATransaction.animationDuration(), animations: {
                self.btnBack.alpha=1
            })]
        }

    }
    
    
    
    @IBAction func btnBack_TouchUpInside(_ sender: UIButton) {
        self.navigationController.popViewController(animated: true)
    }
    
    
}
