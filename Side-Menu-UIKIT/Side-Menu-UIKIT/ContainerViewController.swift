//
//  ViewController.swift
//  Side-Menu-UIKIT
//
//  Created by Ahmed Salem on 25/12/2022.
//

import UIKit

class ContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVc = MenuViewController()
    let homeVc = HomeViewController()
    var navVc: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVcs()
    }
    
    private func addChildVcs()
    {
        //Menu
        addChild(menuVc)
        view.addSubview(menuVc.view)
        menuVc.didMove(toParent: self)
        
        //Home
        homeVc.delegate = self
        let navVc = UINavigationController(rootViewController: homeVc)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
    }
}
extension ContainerViewController : HomeViewControllerDelegate
{
    func didTapMenuButton() {
        // animate the menu Please
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut)
            {
                self.navVc?.view.frame.origin.x = self.homeVc.view.frame.size.width - 100
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
        case .opened:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut)
            {
                self.navVc?.view.frame.origin.x = 0
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                }
            }
        }
    }
}

