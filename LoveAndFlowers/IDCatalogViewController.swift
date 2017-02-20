//
//  ViewController.swift
//  LoveAndFlowers
//
//  Created by Vitalis on 26.12.16.
//  Copyright © 2016 IceDigital. All rights reserved.
//

import UIKit

class IDCatalogViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var svList: UIScrollView!
    @IBOutlet weak var svFillList: UIScrollView!
    @IBOutlet weak var svImagesList: UIScrollView!
    var ItemsCount:Int=5
    
    var selectedItem:Int=0
    var feedbackGenerator:UISelectionFeedbackGenerator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        svList.contentInset = UIEdgeInsetsMake(0,0,0,0);
        
        let h=CGFloat(44.0);
        let imgh=CGFloat(303);
        
        var categories:[NSDictionary]=[]
        var catalogBundle:Bundle=Bundle.main
        
        if let bundlePath = Bundle.main.path(forResource: "catalog", ofType: "bundle"),
            let bundle = Bundle(path: bundlePath),
            let path = bundle.path(forResource: "data", ofType: "json") {
            catalogBundle=bundle
            
            if let jsonData = NSData(contentsOfFile: path)
            {
                do
                {
                    if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {
                        categories=jsonResult["categories"] as! [NSDictionary]
                        ItemsCount=categories.count
                    }
                }
                catch
                {
                    
                }
            }
            
            
        } else {
            print("not found")
        }
        
        
        for i in 0...ItemsCount-1
        {
            let cellVC=self.storyboard!.instantiateViewController(withIdentifier: "CatalogCell");
            var newItem=cellVC.view as! CatalogCell;
            newItem.lblTitle.text=categories[i]["title"] as? String
            var subtitle=categories[i]["subtitle"] as? String;
            if((subtitle) != nil)
            {
                newItem.lblSubtitle.text=subtitle
                newItem.cnstrTop.constant=4;
            }
            else{
                newItem.lblSubtitle.text=""
                newItem.cnstrTop.constant=11;
            }
            newItem.frame=CGRect(x: 0, y: h*CGFloat(i), width: (newItem.frame.width), height:h);
            self.svList.addSubview(cellVC.view);
            
            let fillCellVC=self.storyboard!.instantiateViewController(withIdentifier: "CatalogCellFill");
            newItem=fillCellVC.view as! CatalogCell;
            newItem.lblTitle.text=categories[i]["title"] as? String
            subtitle=categories[i]["subtitle"] as? String;
            if((subtitle) != nil)
            {
                newItem.lblSubtitle.text=subtitle
                newItem.cnstrTop.constant=4;
            }
            else{
                newItem.lblSubtitle.text=""
                newItem.cnstrTop.constant=11;
            }
            newItem.frame=CGRect(x: 0, y: h*CGFloat(i), width: (newItem.frame.width), height:h);
            self.svFillList.addSubview(fillCellVC.view);
            
            
            let img=UIImageView()
            img.image=UIImage(named: "photos/"+(categories[i]["photo"] as? String)!, in: catalogBundle, compatibleWith: nil)
            img.contentMode=UIViewContentMode.scaleAspectFill
            img.clipsToBounds=true
            img.frame=CGRect(x: 0, y: CGFloat(i)*imgh, width: (svImagesList?.frame.width)!, height: imgh)
            self.svImagesList.addSubview(img)
        }
        
        svList.decelerationRate=UIScrollViewDecelerationRateNormal;
        
        svList.contentSize=CGSize(width: 100, height: h*CGFloat(ItemsCount));
        svFillList.contentSize=CGSize(width: 100, height: h*CGFloat(ItemsCount));
        svImagesList.contentSize=CGSize(width: 100, height: imgh*CGFloat(ItemsCount));
        
        svList.delegate=self;
        
        let ListTapGesture=UITapGestureRecognizer(target: self, action:#selector(self.handleListTap));
        svList.addGestureRecognizer(ListTapGesture);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newSelected=svList.currentPage
        if((selectedItem) != newSelected)
        {
            feedbackGenerator.selectionChanged()
            selectedItem=newSelected
        }
        
        self.svImagesList.setContentOffset(CGPoint(x: 0, y:svList.contentOffset.y/svList.contentSize.height*svImagesList.contentSize.height), animated: false);
        self.svFillList.setContentOffset(self.svList.contentOffset, animated: false);
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        feedbackGenerator=UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate)
        {
            svList.goToPage(page: svList.currentPage, animated: true);
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        svList.goToPage(page: svList.currentPage, animated: true);
    }
    

    override func viewDidAppear(_ animated: Bool) {
        //svList.goToPage(page: 0, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    func handleListTap(gestureRecognizer:UITapGestureRecognizer){
        
        let loc = gestureRecognizer.location(in: svList)
        let page:Int=svList.getPageFromY(y: loc.y)
        if(page<=ItemsCount-1)
        {
            if(page==selectedItem)
            {
                self.performSegue(withIdentifier: "open_catalog", sender: nil)
            }
            else{
                feedbackGenerator=UISelectionFeedbackGenerator()
                feedbackGenerator.prepare()
                svList.goToPage(page: page, animated: true);
            }
        }
        
    }
    
    

}

