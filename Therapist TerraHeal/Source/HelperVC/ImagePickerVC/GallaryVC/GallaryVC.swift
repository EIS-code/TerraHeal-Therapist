//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//


import UIKit
import Photos



class GallaryVC: MainVC {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            setupCollectionView()
        }
    }


    var arrForImages: [PhotoDetail] = []
    var allPhotos : PHFetchResult<PHAsset>? = nil

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {

    }
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.requestForPhotos()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.allPhotos?.count ?? 0) > 0 {
            self.wsGetImagesFromGallary()
        }
    }

    private func initialViewSetup() {
        self.vwBg.backgroundColor = UIColor.white
        self.lblTitle?.text = "Gallary"
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        
    }

    func setupLayout() {

    }

    

    func updateUI(isupdate:Bool = false) {

        DispatchQueue.main.async {

            self.collectionView.reloadData {
                self.collectionView.isHidden = !isupdate
                self.lblEmpty.isHidden = isupdate
            }
        }
    }
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        _ = _ = (self.navigationController as? NC)?.popVC()
    }
}



//MARK: Collection View Setup
extension GallaryVC : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{

    private func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isUserInteractionEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.reorderingCadence = .fast
        collectionView?.register(PhotoCell.nib()
            , forCellWithReuseIdentifier: PhotoCell.name)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.name, for: indexPath) as! PhotoCell

        cell.setData(photoDetail: self.arrForImages[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = collectionView.bounds.width  / 4
        return CGSize(width: size, height: size)
    }

}


//MARK:- FetchImagesFromGallary
extension GallaryVC {
    private func wsGetImagesFromGallary() {
        self.arrForImages.removeAll()
        for i in 0..<(self.allPhotos?.count ?? 0) {

            if let asset = self.allPhotos?[i] {
                    let photoItem: PhotoDetail = PhotoDetail(photoId: asset.localIdentifier,asset: self.allPhotos?[i],note: "\(i)")
                    self.arrForImages.append(photoItem)
            }
        }
        self.updateUI(isupdate: !self.arrForImages.isEmpty)
    }

    private func requestForPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                self.wsGetImagesFromGallary()
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            @unknown default:
                print("Not determined yet")
            }
        }
    }
}
