//
//  EditPage.swift
//  davaleba-13
//
//  Created by Ladolado3911 on 12/24/20.
//

import Foundation
import UIKit

protocol ChangeText1 {
    func changeText(_ new_txt: String, _ index1: Int)
}

protocol ChangeText2 {
    func changeText(_ new_txt: String, _ index1: Int, _ index2: Int)
    
}

class EditPage: UIViewController {
    
    var delegate1: ChangeText1?
    var delegate2: ChangeText2?
    var txt1: String?
    var index1: Int?
    var index2: Int?
    var isSearchActive: Bool?
    
    @IBOutlet weak var txt: UITextView!
    @IBOutlet weak var btt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt.text = txt1
        // Do any additional setup after loading the view.
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
    }
    @IBAction func btt(_ sender: Any) {
        guard let thing = txt.text else { return }
        
        if (isSearchActive == true) {
            delegate2?.changeText(thing, index1!, index2!)
        }
        else {
            delegate1?.changeText(thing, index1!)
        }
    }
}
