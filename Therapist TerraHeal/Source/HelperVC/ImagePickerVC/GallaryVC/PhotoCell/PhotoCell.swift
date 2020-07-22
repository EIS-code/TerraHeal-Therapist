//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Photos
import PhotosUI

struct PhotoDetail {
    var photoId:String = ""
    var asset: PHAsset? = nil
    var note:String = ""
    
}

class PhotoCell: CollectionCell
{
    @IBOutlet var ivPhoto: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        ivPhoto.image = nil
    }
    func setData(photoDetail:PhotoDetail) {
        if let asset = photoDetail.asset {
            ivPhoto.fetchImage(asset: asset, contentMode: .aspectFill, targetSize: ivPhoto!.bounds.size)
        }
    }
}


extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            switch contentMode {
            case .aspectFill:
                self.contentMode = .scaleAspectFill
            case .aspectFit:
                self.contentMode = .scaleAspectFit
            @unknown default:
                print("")
            }
            self.image = image
        }
    }
}

