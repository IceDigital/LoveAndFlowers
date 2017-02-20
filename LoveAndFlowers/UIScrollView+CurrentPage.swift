//
//  UIScrollView+CurrentPage.swift
//  LoveAndFlowers
//
//  Created by Vitalis on 30.12.16.
//  Copyright © 2016 IceDigital. All rights reserved.
//

import UIKit

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.y+(0.5*self.frame.size.height))/self.frame.height);
    }
    
    func goToPage(page:Int, animated:Bool)
    {
        self.setContentOffset(CGPoint(x: 0, y: CGFloat(page)*self.frame.size.height), animated: animated);
    }
    
    func getPageFromY(y:CGFloat)->Int
    {
        return Int((y)/self.frame.height);
    }
    
}
