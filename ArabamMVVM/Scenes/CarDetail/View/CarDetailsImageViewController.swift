//
//  CarDetailsImageViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 13.01.2022.
//

import UIKit

class CarDetailsImageViewController: UIViewController {

    @IBOutlet var sliderCollectionView: UICollectionView!
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sliderCollectionView.register(UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        sliderCollectionView.reloadData()
        
    }
    



}


extension CarDetailsImageViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
        let imageUrl = self.images[indexPath.row].replacingOccurrences(of: "{0}", with: PhotoSize.defaultSize.description) 
        cell.carImageView.sd_setImage(with: URL(string: imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}
