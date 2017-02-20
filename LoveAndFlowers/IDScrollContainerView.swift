//
//  IDScrollContainerView.swift
//  LoveAndFlowers
//
//  Created by Vitalis on 26.12.16.
//  Copyright © 2016 IceDigital. All rights reserved.
//

import UIKit

class IDScrollContainerView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let child = super.hitTest(point, with: event)
        if (child == self && self.subviews.count > 0)
        {
            return self.subviews[0];
        }
        return child;
    }
    
}
