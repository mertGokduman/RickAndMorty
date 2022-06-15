//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import UIKit

class BaseViewController<VM>: UIViewController where VM: BaseViewModel {
    
    lazy var viewModel: VM = VM()
    
    private var gradientView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientBackground()
        setNavigationController()
    }
    
    //Background Gradient Color Method of All UIViewControllers
    private func gradientBackground() {
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.gradientView.frame.size
        gradientLayer.colors = [
            UIColor.customBackgroundColor1.cgColor,
            UIColor.customBackgroundColor2.cgColor
        ]
        gradientView.layer.addSublayer(gradientLayer)
        self.view.addSubview(gradientView)
    }
    
    //NavigationController Settings
    private func setNavigationController() {
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
