//
//  SlotDateVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class SlotDateVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slotCollectionView: UICollectionView!
    var selectedDate = Date()
    let startDate = Date()
    let numberOfDaysAroundCurrentDate = 365
    let daysPerPage = 7
    var currentPage = 0
    var interactor: DashboardInteractor!
    static func instance(_ interactor: DashboardInteractor) -> SlotDateVC {
        let SlotDateVC = SlotDateVC.instantiate(from: .dashBoard)
        SlotDateVC.interactor = interactor
        return SlotDateVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCells()
        let dateStr = dateString(from: startDate)
        getSlots(date: dateStr)
        self.collectionView.clipsToBounds = true
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = ColorConstant.appGrayColor.cgColor
        collectionView.reloadData()
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        if self.interactor.selectedSlot != nil{
            let vc = AvailableDeskVC.instance(DashboardInteractor())
            vc.interactor=self.interactor
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getSlots(date:String){
        interactor.getSlots(date: date) { isSuccess in
            if isSuccess{
                DispatchQueue.main.async {
                    self.interactor.selectedDate = date
                    self.slotCollectionView.reloadData()
                }
            }
        }
    }
    func registerCells(){
        collectionView.register(UINib(nibName: CalenderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalenderCollectionViewCell.identifier)
        slotCollectionView.register(UINib(nibName: SlotCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlotCollectionViewCell.identifier)
    }
    func dateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SlotDateVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slotCollectionView{
            
            return self.interactor.slotModel?.slots?.count ?? 0
        }
        return numberOfDaysAroundCurrentDate
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slotCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlotCollectionViewCell.identifier, for: indexPath) as? SlotCollectionViewCell else {
                fatalError("Unable to dequeue ")
            }
            guard let data = self.interactor.slotModel?.slots?[indexPath.row] else{
                return cell
            }
            cell.titleLbl.text = data.slotName
            if data.slotActive == true{
                cell.setupUI(isActive: true)
            }
            else{
                cell.setupUI(isActive: false)
            }
            
            return cell
            
            
            
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalenderCollectionViewCell.identifier, for: indexPath) as? CalenderCollectionViewCell else {
            fatalError("Unable to dequeue")
        }
        
        // Calculate date for the cell
        let currentDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: startDate)!
        
        
        // Configure cell
        if selectedDate == currentDate{
            cell.changeUIBySelected(isSelected: true)
        }
        else{
            cell.changeUIBySelected(isSelected: false)
        }
        cell.configure(with: currentDate)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            
            
            for visibleIndexPath in collectionView.indexPathsForVisibleItems {
                guard let cell = collectionView.cellForItem(at: visibleIndexPath) as? CalenderCollectionViewCell else {
                    continue
                }
                
                // Check if the current cell is the selected cell
                if visibleIndexPath == indexPath {
                    cell.changeUIBySelected(isSelected: true)
                } else {
                    
                    cell.changeUIBySelected(isSelected: false)
                }
            }
            selectedDate = Calendar.current.date(byAdding: .day, value: indexPath.item, to: startDate)!
            let str = dateString(from: selectedDate)
            self.getSlots(date: str)
        }
        
        else if collectionView == slotCollectionView{
            guard self.interactor.slotModel?.slots?[indexPath.row].slotActive == true else{
                return
            }
            for visibleIndexPath in collectionView.indexPathsForVisibleItems {
                guard let cell = collectionView.cellForItem(at: visibleIndexPath) as? SlotCollectionViewCell else {
                    continue
                }
                if visibleIndexPath == indexPath{
                    self.interactor.selectedSlot = self.interactor.slotModel?.slots?[indexPath.row]
                    cell.mainView.backgroundColor = ColorConstant.selectedCardBgColor
                    cell.titleLbl.textColor =  .white
                    
                    
                }
                else{
                    if self.interactor.slotModel?.slots?[visibleIndexPath.row].slotActive == true{
                        cell.setupUI(isActive: true)
                    }
                    else{
                        cell.setupUI(isActive: false)
                    }
                }
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate cell size
        if collectionView == self.collectionView{
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = collectionViewWidth / CGFloat(daysPerPage)
            return CGSize(width: cellWidth, height: collectionView.bounds.height)
        }
        else{
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = collectionViewWidth / 2 - 8
            return CGSize(width: cellWidth, height: 42)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            // Check if scrolled to the end of the page
            let visibleIndexPaths = collectionView.indexPathsForVisibleItems
            if let lastVisibleIndex = visibleIndexPaths.last, lastVisibleIndex.row == indexPath.row {
                currentPage += 1
                collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath(item: currentPage * daysPerPage, section: 0), at: .left, animated: false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == slotCollectionView{
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == slotCollectionView{
            return 10
        }
        return 0
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
