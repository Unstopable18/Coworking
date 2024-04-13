//
//  ToastView.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation
import UIKit

class ToastView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var closeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    let nibName = "ToastView"
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    private func commonInit() {

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        
        self.addSubview(view)
        contentView = view
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    // Close button action
    @objc private func closeButtonTapped() {
        removeFromSuperview()
    }
    
    // Configure toast content
    func configure(image: UIImage?, title: String, description: String,bgColor:UIColor? = nil) {
        if let color = bgColor{
            mainView.backgroundColor = color
        }
      
        mainView.layer.cornerRadius = 8
        mainView.clipsToBounds = true
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

extension UIViewController {
    func showToast(image: UIImage?, title: String, description: String,bgColor:UIColor? = nil) {
        let toastView = ToastView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width - 40, height: 61))
       
        
        toastView.configure(image: image, title: title, description: description,bgColor: bgColor)
        toastView.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 100)
        view.addSubview(toastView)
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            
            toastView.removeFromSuperview()
        }
    }

}
