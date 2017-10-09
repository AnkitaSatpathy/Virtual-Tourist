//
//  CollectionViewCell.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 09/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        if imageView.image == nil {
            activityIndicator.startAnimating()
        }
    }
}
