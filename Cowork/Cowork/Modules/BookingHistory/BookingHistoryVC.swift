//
//  BookingHistoryVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class BookingHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var interactor: DashboardInteractor!
    static func instance(_ interactor: DashboardInteractor) -> BookingHistoryVC {
        let BookingHistoryVC = BookingHistoryVC.instantiate(from: .dashBoard)
        BookingHistoryVC.interactor = interactor
        return BookingHistoryVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCells()
        fetchHistory()
        tableView.separatorStyle = .none
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCells(){
        
        self.tableView.register(UINib(nibName: BookingHistoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BookingHistoryTableViewCell.identifier)
    }
    
    func fetchHistory(){
        self.interactor.getBookingHistory(completion: { isSuccess in
            if isSuccess{
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.bookingModel?.bookings?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookingHistoryTableViewCell.identifier) as? BookingHistoryTableViewCell else{
            return UITableViewCell()
        }
        let data = interactor.bookingModel?.bookings?[indexPath.row]
        cell.bookOnLbl.text = data?.bookingDate
        cell.deskIdNoLbl.text = "\(data?.workspaceID ?? 0)"
        cell.nameLbl.text = data?.workspaceName
        cell.selectionStyle = .none
        return cell
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
