//
//  ProjectDescription.swift
//  client
//
//  Created by Neha Yadav on 02/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ProjectDescription: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributeString = NSMutableAttributedString(string: "You might be asking why you need Alamofire in the first place. Apple provides the NSURLSession class and related classes for downloading content via HTTP, so why complicate things with another third party library? The short answer is that Alamofire is based on NSURLSession, but it frees you from writing boilerplate code and makes writing networking code much easier. You can access data on the Internet with very little effort, and your code will be much cleaner and easier to read.To use Alamofire, you first need to import it. To do this, open PhotoBrowserCollectionViewController.swift and add the following line to the top of the file: \n\n You might be asking why you need Alamofire in the first place. Apple provides the NSURLSession class and related classes for downloading content via HTTP, so why complicate things with another third party library? The short answer is that Alamofire is based on NSURLSession, but it frees you from writing boilerplate code and makes writing networking code much easier. You can access data on the Internet with very little effort, and your code will be much cleaner and easier to read.To use Alamofire, you first need to import it. To do this, open PhotoBrowserCollectionViewController.swift and add the following line to the top of the file:" as String, attributes: [NSFontAttributeName: UIFont(name: "Asap-regular", size: 12)!, NSParagraphStyleAttributeName: paragraphStyle])

        descriptionLabel.attributedText = attributeString
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
