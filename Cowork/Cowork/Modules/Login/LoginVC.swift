//
//  LoginVC.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    var interactor: LoginInteractor = LoginInteractor()
    static func instance(_ interactor: LoginInteractor) -> LoginVC {
        let LoginVC = LoginVC.instantiate(from: .authorization)
        LoginVC.interactor = interactor
        return LoginVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signupButtonUI()
    }
    
    func signupButtonUI(){
        
        signupButton.setAttributedTextWithAttributes(text: "New user? Create an account", font: Globals.setFontTo(font: .poppinsRegular, size: 14) ?? .boldSystemFont(ofSize: 16), color: ColorConstant.primaryButtonColor, underlineText: "Create an account")
        
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
        let vc = SignupVC.instance(SignupInteractor())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        print("validateLogin---\(validateLogin())")
        if validateLogin(){
            interactor.login(email:usernameTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] isSuccess in
                DispatchQueue.main.async {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        fatalError()
                    }
                    appDelegate.dashboardUI()
                }
                
            }
        }
        
    }

    
//    func validateLogin()->Bool{
//        var isValidUser: Bool = false
//        var isValidPass: Bool = false
//        if usernameTextField.text == "" {
//            self.showToast(image: UIImage(named: ""), title: "Error", description: "Please enter Email Id or Mobile Number!!!", bgColor: .black)
//            return false
//        }else if usernameTextField.text?.isValidEmail() == false {
//            if usernameTextField.text?.isPhoneNumber() == false {
//                self.showToast(image: UIImage(named: ""), title: "Error", description: "Please enter valid Email Id or Mobile Number!!!", bgColor: .black)
//                return false
//            }
//        }else{
//            isValidUser = true
//        }
//        
//        if passwordTextField.text == ""{
//            self.showToast(image: UIImage(named: ""), title: "Error", description: "Please enter Password!!!", bgColor: .black)
//            return false
//        } else {
//            isValidPass = true
//        }
//        if isValidPass && isValidPass {
//            return true
//        }
//        return false
//        
//    }
    
    
    func validateLogin() -> Bool {
        guard let username = usernameTextField.text, !username.isEmpty else {
            showToast(image: UIImage(named: ""), title: "Error", description: "Please enter Email Id or Mobile Number!!!", bgColor: .black)
            return false
        }
        
        if !username.isValidEmail() && !username.isPhoneNumber() {
            showToast(image: UIImage(named: ""), title: "Error", description: "Please enter valid Email Id or Mobile Number!!!", bgColor: .black)
            return false
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showToast(image: UIImage(named: ""), title: "Error", description: "Please enter Password!!!", bgColor: .black)
            return false
        }
        
        return true
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

