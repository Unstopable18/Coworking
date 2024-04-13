//
//  PopupVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class PopupVC: UIViewController {
    
    @IBOutlet weak var deskNolbl: UILabel!
    var completion:(()->())?
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var slotDateLbl: UILabel!
    @IBOutlet weak var deskLbl: UILabel!
    var interactor: DashboardInteractor!
    static func instance(_ interactor: DashboardInteractor) -> PopupVC {
        let PopupVC = PopupVC.instantiate(from: .dashBoard)
        PopupVC.interactor = interactor
        return PopupVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        
        self.idLbl.text = "\(self.interactor?.selectedSlot?.slotID ?? 0)"
        self.deskLbl.text = (self.interactor?.dashBoardOption.title ?? "") + " ID : "

        self.slotDateLbl.text = "\(self.interactor?.dateSelected ?? "") \(self.interactor?.selectedSlot?.slotName ?? "")"
        deskNolbl.text = "\(self.interactor?.dashBoardOption.title ?? "") \(self.interactor?.selectedSeat?.workspaceName ?? "")"
    }
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func didTapConfirm(_ sender: Any) {
        confirmBooking()
    }
    func confirmBooking(){
        interactor?.confirmBooking(completion: { isSuccess in
            DispatchQueue.main.async {
                self.dismiss(animated: true){
                    self.completion?()
                }
            }
        })
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
