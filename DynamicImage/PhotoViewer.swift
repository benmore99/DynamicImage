//
//  Photo.swift
//  DynamicImage
//
//  Created by BURIN TECHAMA on 6/22/2560 BE.
//  Copyright © 2560 Zeal Tech International. All rights reserved.
//

import Foundation
import NYTPhotoViewer

class PhotoViewer: NSObject, NYTPhoto {
    
    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString?
    let attributedCaptionSummary: NSAttributedString? = NSAttributedString(string: "summary string", attributes: [NSForegroundColorAttributeName: UIColor.gray])
    let attributedCaptionCredit: NSAttributedString? = NSAttributedString(string: "credit", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
    
    init(image: UIImage? = nil, imageData: Data? = nil, attributedCaptionTitle: NSAttributedString) {
        self.image = image
        self.imageData = imageData
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }
    
}
