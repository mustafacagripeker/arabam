//
//  CartListViewController.swift
//  ArabamMVVM
//
//  Created by Mustafa Çağrı Peker on 11.01.2022.
//

import UIKit

class CarListViewController: UIViewController {
    
    @IBOutlet var carListTableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    
    
    
    var carListVM = CarListViewModel()
    var carArray = [CarListModel]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavBarSettings()
        initTableViewSettings()
        
        
        loadData()
        
    }
    
    func loadData(){
        LoadingView.shared.showActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.carListVM.isLoading = true
            self.carListVM.getCars { cars in
                self.carArray.append(contentsOf: cars ?? [])
                self.carListTableView.reloadData()
                self.carListVM.isLoading = false
                LoadingView.shared.hideActivityIndicator()
                
                if self.carArray.isEmpty == true{
                    self.carListTableView.isHidden = true
                    self.noDataLabel.isHidden = false
                }else{
                    self.carListTableView.isHidden = false
                    self.noDataLabel.isHidden = true
                }
            }
        }
        
    }
    
    
    func initNavBarSettings(){
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonClicked(_:)))
        let sortButton = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(sortButtonClicked(_:)))
        filterButton.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0)
        sortButton.imageInsets = UIEdgeInsets(top: 0.0, left: 25, bottom: 0, right: 0)
        self.navigationItem.rightBarButtonItems = [filterButton,sortButton]
        title = "Araba Listesi"
    }
    
    
    func initTableViewSettings(){
        carListTableView.register(UINib(nibName: "CarListTableViewCell", bundle: nil), forCellReuseIdentifier: "CarListTableViewCell")
        carListTableView.delegate = self
        carListTableView.dataSource = self
    }
    
    
    @objc func sortButtonClicked(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "CarListStoryboard", bundle: nil).instantiateViewController(withIdentifier: "pickerView") as? PickerViewController
        guard let vc = vc else{
            return
        }
        vc.sortDelegate = self
        self.present(vc, animated: false)
    }
    
    @objc func filterButtonClicked(_ sender : UIBarButtonItem){
        let vc = UIStoryboard(name: "CarListStoryboard", bundle: nil).instantiateViewController(withIdentifier: "filterVC") as? FilterViewController
        guard let vc = vc else{
            return
        }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "CarDetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CarDetailViewController") as! CarDetailViewController
        vc.carId = carArray[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.carArray.count - 1 && !(self.carListVM.isLoading) && !(self.carListVM.finishPagination){
            self.carListVM.skip = self.carListVM.skip + self.carListVM.take
            self.loadData()
        }
    }
    
    
}

extension CarListViewController : FilterDelegate{
    func filterApplyed(filterOptions: FilterOptions) {
        self.carListTableView.scroll(to: .top, animated: false)
        self.carListTableView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.carArray.removeAll()
            self.carListTableView.isHidden = false
        }
        self.carListVM.filterOptions = filterOptions
        self.carListVM.skip = 0
        self.loadData()
    }
}

extension CarListViewController : SortDelegate{
    func sortApplyed(type: Int?, direction: Int?) {
        self.carListTableView.scroll(to: .top, animated: false)
        self.carListTableView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.carArray.removeAll()
            self.carListTableView.isHidden = false
        }
        self.carListVM.sortDirection = direction
        self.carListVM.sortType = type
        self.carListVM.skip = 0
        self.loadData()
    }
}


struct FilterOptions{
    var minDate : String?
    var maxDate : String?
    var minYear : Int?
    var maxYear : Int?
}


protocol FilterDelegate{
    func filterApplyed(filterOptions : FilterOptions)
}

protocol SortDelegate{
    func sortApplyed(type : Int?,direction : Int?)
}
