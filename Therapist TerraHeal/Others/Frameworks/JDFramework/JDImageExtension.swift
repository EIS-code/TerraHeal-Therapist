//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import  ImageIO
import SDWebImage

extension UIImageView {
    
    func downloadedFrom(link: String,
                        placeHolder:UIImage? = UIImage(named:"asset-logo"),
                        isFromCache:Bool = true,
                        isIndicator:Bool = false,
                        mode:UIView.ContentMode = .scaleToFill,
                        isAppendBaseUrl:Bool = false) {
        
        self.contentMode = mode
        self.clipsToBounds = true;
        if placeHolder != nil {
                self.image=placeHolder;
        }
        
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
                
                self.sd_setImage(with: url, placeholderImage:placeHolder, completed: { (image, error, cacheType, url) -> Void in
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

extension UIImage {

    enum CompressImageErrors: Error {
        case invalidExSize
        case sizeImpossibleToReach
    }
    func compressImage(_ expectedSizeKb: Int, completion : (UIImage,CGFloat) -> Void ) throws {

        let minimalCompressRate :CGFloat = 0.4 // min compressRate to be checked later

        if expectedSizeKb == 0 {
            throw CompressImageErrors.invalidExSize // if the size is equal to zero throws
        }

        let expectedSizeBytes = expectedSizeKb * 1024
        let imageToBeHandled: UIImage = self
        var actualHeight : CGFloat = self.size.height
        var actualWidth : CGFloat = self.size.width
        var maxHeight : CGFloat = 841 //A4 default size I'm thinking about a document
        var maxWidth : CGFloat = 594
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality : CGFloat = 1
        var imageData:Data = imageToBeHandled.jpegData(compressionQuality: compressionQuality)!
        while imageData.count > expectedSizeBytes {

            if (actualHeight > maxHeight || actualWidth > maxWidth){
                if(imgRatio < maxRatio){
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                }
                else if(imgRatio > maxRatio){
                    imgRatio = maxWidth / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                }
                else{
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                    compressionQuality = 1;
                }
            }
            let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
            UIGraphicsBeginImageContext(rect.size);
            imageToBeHandled.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if let imgData = img!.jpegData(compressionQuality: compressionQuality) {
                if imgData.count > expectedSizeBytes {
                    if compressionQuality > minimalCompressRate {
                        compressionQuality -= 0.1
                    } else {
                        maxHeight = maxHeight * 0.9
                        maxWidth = maxWidth * 0.9
                    }
                }
                imageData = imgData
            }


        }

        completion(UIImage(data: imageData)!, compressionQuality)
    }


}
