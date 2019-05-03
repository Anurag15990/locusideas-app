//
//  LoaderView.swift
//  client
//
//  Created by Anurag Agnihotri on 7/6/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LoaderView: UIView {
    
    var loadingView: NVActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        self.loadingView = NVActivityIndicatorView(frame: CGRectMake(self.frame.size.width / 2 - 25, self.frame.size.height / 2 - 80, 50, 50))
        loadingView.color = UIColor(red: 72.0/255.0, green: 172.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        loadingView.type = .BallClipRotate
        loadingView.startAnimation()
        self.addSubview(loadingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        self.loadingView = NVActivityIndicatorView(frame: CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, 50, 50))
        loadingView.color = UIColor(red: 72.0/255.0, green: 172.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        loadingView.type = .BallClipRotate
        loadingView.startAnimation()
        self.addSubview(loadingView)
    }
}