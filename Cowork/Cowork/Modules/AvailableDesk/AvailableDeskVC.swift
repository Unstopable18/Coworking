//
//  AvailableDeskVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class AvailableDeskVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titlLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var interactor: DashboardInteractor!
    static func instance(_ interactor: DashboardInteractor) -> AvailableDeskVC {
        let AvailableDeskVC = AvailableDeskVC.instantiate(from: .dashBoard)
        AvailableDeskVC.interactor = interactor
        return AvailableDeskVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dateTimeLbl.text = "\(self.interactor.dateSelected ?? "" ) \(self.interactor.selectedSlot?.slotName ?? "")"
        self.titlLbl.text = "Available \(self.interactor.dashBoardOption.title )s"
        registerCells()
        fetchSeats()
    }
    
    @IBAction func didTapBookDesk(_ sender: UIButton) {
        let vc = PopupVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.completion = {[weak self] in
            self?.showToast(image: UIImage(named: "ep_success_filled"), title: "Success", description: "You have successfully booked your Desk")
            DispatchQueue.main.asyncAfter(deadline: .now()+3){ [weak self] in
                
                self?.navigationController?.popToRootViewController(animated: false)
            }
        }
        vc.interactor=self.interactor
        self.present(vc, animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchSeats(){
        self.interactor.getAvailibilty { isSuccess in
            if isSuccess{
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: SlotCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlotCollectionViewCell.identifier)
        
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.availableSlotModel?.availability?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlotCollectionViewCell.identifier, for: indexPath) as? SlotCollectionViewCell else {
            fatalError("Unable to dequeue ")
        }
        let data = self.interactor.availableSlotModel?.availability?[indexPath.row]
        cell.titleLbl.text = data?.workspaceName
        if data?.workspaceActive == true{
            cell.setupUI(isActive: true)
        }
        else{
            cell.setupUI(isActive: false)
        }
        //        cell.titleLbl.text = "\(indexPath.row + 1)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.interactor.availableSlotModel?.availability?[indexPath.row].workspaceActive == true else{
            return
        }
        for visibleIndexPath in collectionView.indexPathsForVisibleItems {
            guard let cell = collectionView.cellForItem(at: visibleIndexPath) as? SlotCollectionViewCell else {
                return
            }
            if visibleIndexPath == indexPath{
                self.interactor.selectedSeat = self.interactor.availableSlotModel?.availability?[indexPath.row]
                cell.mainView.backgroundColor = ColorConstant.selectedCardBgColor
                cell.titleLbl.textColor =  .white
                
                
            }
            else{
                if self.interactor.availableSlotModel?.availability?[visibleIndexPath.row].workspaceActive == true{
                    cell.setupUI(isActive: true)
                }
                else{
                    cell.setupUI(isActive: false)
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = collectionViewWidth / 6 - 12
        return CGSize(width: cellWidth, height: 42)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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

