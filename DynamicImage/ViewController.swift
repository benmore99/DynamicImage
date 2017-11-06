//
//  ViewController.swift
//  DynamicImage
//
//  Created by BURIN TECHAMA on 6/21/2560 BE.
//  Copyright © 2560 Zeal Tech International. All rights reserved.
//

import UIKit
import SDWebImage
import NYTPhotoViewer

class ViewController: UIViewController {
    
    let imageURL = [
        "https://demo.joomlashine.com/joomla-templates/jsn_artista/pro/images/sampledata/content/detail-image.jpg",
        "http://techsilky.com/wp-content/uploads/2016/07/Game-of-Thrones.jpg",
        "https://cdn.vox-cdn.com/uploads/chorus_image/image/49958705/game-of-thrones-poster_85627-1920x1200.0.jpg",
        "https://www.vpnanswers.com/wp-content/uploads/2015/04/thrones-cast.jpg",
        "http://nerdist.com/wp-content/uploads/2016/05/dany-game-of-thrones-s6e4-dosh-khaleen.jpg"
    ]
    
    var scale:[Float] = []
    
    let width = UIScreen.main.bounds.size.width
    
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in imageURL {
            scale.append(0)
        }
    }
    
    func reload(index:Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }

    func showFullScreenImage(image:UIImage) {
        let title = NSAttributedString(string: "Title", attributes: [NSForegroundColorAttributeName: UIColor.gray])
        let photo = PhotoViewer(image: image, imageData: nil, attributedCaptionTitle: title)
        let vc = NYTPhotosViewController(photos: [photo])
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell {
            let url = URL(string: imageURL[indexPath.row])
            let placeholder = UIImage(named: "default_thumbnail")
            cell.imageView.sd_setImage(with: url, placeholderImage: placeholder, options: .retryFailed, completed: {
                (image, error, type, url) in
                if let image = image {
                    let scale = image.size.height / image.size.width
                    self.scale[indexPath.row] = Float(scale)
                    self.reload(index: indexPath.row)
                }
            })
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if scale[indexPath.row] == 0{
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: width, height: width*CGFloat(scale[indexPath.row]))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            if let image = cell.imageView.image {
                showFullScreenImage(image: image)
            }
        }
    }
    
}

extension ViewController : NYTPhotosViewControllerDelegate {
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        let image = photo.image
        for cell in collectionView.visibleCells {
            if let cell = cell as? ImageCollectionViewCell {
                if cell.imageView.image == image {
                    return cell.imageView
                }
            }
        }
        return self.view
    }
    
}
