//
//  HamburgerViewController.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/3/14.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var hamburgerLabel: UILabel!
    @IBOutlet weak var hamburgerBtn: UIButton!
    
    var delegate: HamburgerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        print("Hamburger parent: ", parent as Any)
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        delegate?.btnClick()
    }
    
    func setView() {
        view.backgroundColor = .darkGray
        hamburgerLabel.text = "Hamburger"
        hamburgerBtn.setTitle("", for: .normal)
    }

}

protocol HamburgerViewControllerDelegate {
    func btnClick()
}
