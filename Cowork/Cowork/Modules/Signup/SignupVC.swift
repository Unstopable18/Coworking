//
//  SignupVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class SignupVC: UIViewController {
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var mobileTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTf: UITextField!
    var interactor: SignupInteractor!
    static func instance(_ interactor: SignupInteractor) -> SignupVC {
        let SignupVC = SignupVC.instantiate(from: .authorization)
        SignupVC.interactor = interactor
        return SignupVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
        if validateRegistration(){
            self.interactor.registerUser(email: emailTF.text ?? "", name:fullNameTf.text ?? "") { isSuccess in
                if isSuccess{
                    DispatchQueue.main.async {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                            fatalError()
                        }
                        appDelegate.dashboardUI()
                    }
                
                }
            }
        }
       
    }
    
    func validateRegistration()->Bool{
        
        if fullNameTf.text == "" || fullNameTf.text?.isValidName() == false{
            self.showToast(image: UIImage(), title: "Error", description: "please enter name",bgColor: .black)
            return false
        }
        else if mobileTF.text == "" || mobileTF.text?.isPhoneNumber() == false{
            self.showToast(image: UIImage(), title: "Error", description: "please enter valid mobile number",bgColor: .black)
            return false
        }
        else if emailTF.text == "" || emailTF.text?.isValidEmail() == false{
            self.showToast(image: UIImage(), title: "Error", description: "please enter valid email Id",bgColor: .black)
            return false
        }
        
        return true
        
    }
    func setupUI(){
        signinBtn.setAttributedTextWithAttributes(text: "Existing user? Log In",
                                                  font: Globals.setFontTo(font: .poppinsRegular, size: 14) ?? UIFont.systemFont(ofSize: 16),
                                                  color: ColorConstant.primaryButtonColor,
                                                  underlineText: "Log In")
        
    }
    @IBAction func didTapLogin(_ sender: Any) {
        let vc = LoginVC.instance(LoginInteractor())
        self.navigationController?.pushViewController(vc, animated: true)
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
