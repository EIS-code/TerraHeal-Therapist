//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import  ImageIO
import SDWebImage

extension UIImageView {
    
    func downloadedFrom(link: String,
                        placeHolder:String = "logo",
                        isFromCache:Bool = true,
                        isIndicator:Bool = false,
                        mode:UIView.ContentMode = .scaleToFill,
                        isAppendBaseUrl:Bool = false) {
        
        self.contentMode = mode
        self.clipsToBounds = true;
        let placeHolderImage = UIImage.init(named: placeHolder)
        
        self.image=placeHolderImage;
        if link.isEmpty() {
            print("link is empty")
            return
        }
        else {
            guard let url = URL(string: link) else {
                print("link is not url")
                return
            }
            if isIndicator {
                self.sd_imageIndicator!.startAnimatingIndicator()
            }
            if isFromCache {
                
                self.sd_setImage(with: url, placeholderImage:placeHolderImage, completed: { (image, error, cacheType, url) -> Void in
                    if ((error) != nil) {
                        if isIndicator {
                            self.sd_imageIndicator!.stopAnimatingIndicator()
                        }
                        
                    } else {
                            self.image = image
                        self.isHidden = false
                        if isIndicator {
                            self.sd_imageIndicator!.stopAnimatingIndicator()
                        }
                    }
                })
            }
            else {

                let url = URL(string: link)
                SDWebImageDownloader.shared.downloadImage(with: url, options: SDWebImageDownloaderOptions.ignoreCachedResponse, progress: nil, completed: { (image, data, error, result) in
                    print("link is proper")
                    if ((error) != nil) {
                        if isIndicator {
                            self.sd_imageIndicator!.stopAnimatingIndicator()
                        }
                    }
                    else {
                        
                        if isIndicator {
                            self.sd_imageIndicator!.stopAnimatingIndicator()
                        }
                        if let downloadImage = image {
                            self.image = downloadImage
                            self.isHidden = false
                            self.clipsToBounds = true;
                        }
                    }
                    
                })
            }
        }
    }
    
    func adjustHeight(){
        if let image = self.image {
            let ratio = image.size.width / image.size.height
            let newHeight = self.frame.width / ratio
            self.height(constant: newHeight)
            self.superview?.layoutIfNeeded()
        }
    }
}
class FixedWidthAspectFitImageView: UIImageView
{

    override var intrinsicContentSize: CGSize
    {
        // VALIDATE ELSE RETURN
        // frameSizeWidth
        let frameSizeWidth = self.frame.size.width

        // image
        // ⓘ In testing on iOS 12.1.4 heights of 1.0 and 0.5 were respected, but 0.1 and 0.0 led intrinsicContentSize to be ignored.
        guard let image = self.image else
        {
            return CGSize(width: frameSizeWidth, height: 1.0)
        }

        // MAIN
        let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
        return CGSize(width: frameSizeWidth, height: returnHeight)
    }

}
