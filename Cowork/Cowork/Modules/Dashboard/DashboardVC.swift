//
//  DashboardVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var meetingRoomView: CustomUIView!
    @IBOutlet weak var bookWorkStationView: CustomUIView!
    var interactor: DashboardInteractor!
    static func instance(_ interactor: DashboardInteractor) -> DashboardVC {
        let DashboardVC = DashboardVC.instantiate(from: .dashBoard)
        DashboardVC.interactor = interactor
        return DashboardVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bookWorkStationView.backgroundColor = ColorConstant.cardBgColor
        self.meetingRoomView.backgroundColor = ColorConstant.cardBgColor
    }
    @IBAction func didTapBookingHistory(_ sender: Any) {
        let vc = BookingHistoryVC.instance(DashboardInteractor())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapBookWorkStation(_ sender: UIButton) {
        
        self.bookWorkStationView.backgroundColor = ColorConstant.selectedCardBgColor
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            let vc = SlotDateVC.instance(DashboardInteractor())
            vc.interactor.dashBoardOption = .Desk
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func didTapMeetingRoom(_ sender: UIButton) {
        self.meetingRoomView.backgroundColor = ColorConstant.selectedCardBgColor
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            let vc = SlotDateVC.instance(DashboardInteractor())
            vc.interactor.dashBoardOption = .Room
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
