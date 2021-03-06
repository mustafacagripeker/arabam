//
//  CarDetailViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import UIKit
import SDWebImage
import WebKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet var imageSliderCollectionView: UICollectionView!
    @IBOutlet var carTitleLabel: UILabel!
    @IBOutlet var carDetailButton: UILabel!
    @IBOutlet var carExplanationButton: UILabel!
    @IBOutlet var informationTableViewCell: UITableView!
    @IBOutlet var imageSliderPageController: UIPageControl!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    var detailVM = CarDetailViewModel()
    
    
    var selectedIndexForTableView = 0
    var carId = Int()
    var carDetail : CarDetailModel?
    var detailTypeArray = [DetailType]()
    var detailValueArray = [String]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detailTypeArray = [.Price,
                           .City,
                           .County,
                           .Date,
                           .Model,
                           .Year,
                           .Km,
                           .Color,
                           .Gear,
                           .fuel,
                           .SellerName,
                           .SellerPhone]
        
        detailVM.carId = carId
        selectedIndexForTableView = 0
        setButtonsProperty()
        setCollectionViewSettings()
        setTableViewSettings()
        
        fillTableViewWithData{
            self.informationTableViewCell.reloadData()
            self.imageSliderCollectionView.reloadData()
        }

    }
    
    func fillTableViewWithData(completion: @escaping () -> ()){
        detailVM.getDetails { [self] details in
            self.carDetail = details
            self.imageSliderPageController.numberOfPages = details?.photos.count ?? 0
            self.carTitleLabel.text = details?.title
            
            for item in self.detailTypeArray{
                switch item {
                case  .Price:
                    self.detailValueArray.append(details?.priceFormatted ?? "")
                case .Date:
                    self.detailValueArray.append(details?.dateFormatted ?? "")
                case .Model:
                    self.detailValueArray.append(details?.modelName ?? "")
                case .Year:
                    self.detailValueArray.append(findProperties(properties: details?.properties ?? [], key: "year"))
                case .Km:
                    self.detailValueArray.append(details?.properties[0].value ?? "")
                case .Color:
                    self.detailValueArray.append(details?.properties[1].value ?? "")
                case .Gear:
                    self.detailValueArray.append(details?.properties[3].value ?? "")
                case .fuel:
                    self.detailValueArray.append(details?.properties[4].value ?? "")
                case .SellerName:
                    self.detailValueArray.append(details?.userInfo.nameSurname ?? "")
                case .SellerPhone:
                    self.detailValueArray.append(details?.userInfo.phoneFormatted ?? "")
                case .City:
                    self.detailValueArray.append(details?.location.cityName ?? "")
                case .County:
                    self.detailValueArray.append(details?.location.townName ?? "")
                default:
                    print("default")
            }
            }
            completion()
        }
    }
    
    func findProperties(properties : [Properties] , key : String)-> String{
        let property = properties.first { p in p.name == key }
        return property?.value ?? ""
    }
    
    func setTableViewSettings(){
        tableViewHeightConstraint.constant = CGFloat(detailTypeArray.count * 50)
        informationTableViewCell.register(UINib(nibName: "CarDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CarDetailTableViewCell")
        informationTableViewCell.delegate = self
        informationTableViewCell.dataSource = self
        
        informationTableViewCell.register(UINib(nibName: "CarDetailDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CarDetailDescriptionTableViewCell")
    }
    
    func setCollectionViewSettings(){
        imageSliderCollectionView.register(UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
    }
    
    
    func setButtonsProperty(){
        carExplanationButton.addTapGesture {
            self.carExplanationButton.backgroundColor  = UIColor(hexString: "C7C7CC")
            self.carDetailButton.backgroundColor = .white
            self.selectedIndexForTableView = 1
            self.informationTableViewCell.reloadData()
        }
        carDetailButton.addTapGesture {
            self.carExplanationButton.backgroundColor = .white
            self.carDetailButton.backgroundColor = UIColor(hexString: "C7C7CC")
            self.selectedIndexForTableView = 0
            self.informationTableViewCell.reloadData()
        }
    }
}


extension CarDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carDetail?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as? ImageSliderCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageUrl = self.carDetail?.photos[indexPath.row].replacingOccurrences(of: "{0}", with: PhotoSize.defaultSize.description) ?? ""
        cell.carImageView.sd_setImage(with: URL(string: imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "CarDetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: "imageSliderVC") as! CarDetailsImageViewController
        vc.images = carDetail?.photos ?? []
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.imageSliderPageController.currentPage = indexPath.row
    }
}

extension CarDetailViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedIndexForTableView == 1 {
            return 1
        }else{
            return self.detailValueArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selectedIndexForTableView == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarDetailTableViewCell", for: indexPath) as? CarDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.bind(key: self.detailTypeArray[indexPath.row].description, value: self.detailValueArray[indexPath.row])
            if (indexPath.row) % 2 == 0{
                cell.CarDetailBackgroundView.backgroundColor = UIColor.init(hexString: "C7C7CC")
            }else{
                cell.CarDetailBackgroundView.backgroundColor = .white
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarDetailDescriptionTableViewCell") as! CarDetailDescriptionTableViewCell
            cell.bind(htmlString: self.carDetail?.text ?? "")
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndexForTableView == 0{
            return 50
        }else{
            return tableView.frame.height
        }
        
    }
    
    
    
}
