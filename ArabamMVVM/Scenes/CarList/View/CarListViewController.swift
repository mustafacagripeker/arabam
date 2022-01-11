//
//  CartListViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import UIKit

class CarListViewController: UIViewController {
    
    @IBOutlet var carListTableView: UITableView!
    
    
    
    var carListVM = CarListViewModel()
    var carArray = [CarListModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carListTableView.register(UINib(nibName: "CarListTableViewCell", bundle: nil), forCellReuseIdentifier: "CarListTableViewCell")
        carListTableView.delegate = self
        carListTableView.dataSource = self
        
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonClicked(_:)))
        let sortButton = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: #selector(filterButtonClicked(_:)))
        self.navigationItem.rightBarButtonItems = [filterButton,sortButton]
        title = "Araba Listesi"
        
        carListVM.getCars { cars in
            self.carArray.append(contentsOf: cars ?? [])
            self.carListTableView.reloadData()
        }
    }
    
    @objc func filterButtonClicked(_ sender: UIBarButtonItem) {

        let vc = UIStoryboard(name: "CarListStoryboard", bundle: nil).instantiateViewController(withIdentifier: "filter") as? FilterViewController
        
        guard let vc = vc else{
            return
        }
        
        self.present(vc, animated: false)
    }

}


extension CarListViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarListTableViewCell", for: indexPath) as? CarListTableViewCell else{
            return UITableViewCell()
        }
        let car = self.carArray[indexPath.row]
        let imageUrl = car.photo.replacingOccurrences(of: "{0}", with: PhotoSize.defaultSize.description)
        cell.bind(imageView: imageUrl, title: car.title, location: "\(car.location.townName)/\(car.location.cityName)" , price: car.priceFormatted)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}

