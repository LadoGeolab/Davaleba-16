//
//  SecondPage.swift
//  davaleba-13
//
//  Created by Ladolado3911 on 12/12/20.
//

import Foundation
import UIKit

protocol AddThing {
    func addthing(_ str: String)
}

class SecondPage: UIViewController {
    
    let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstPage") as? FirstPage
    
    var index: IndexPath?
    var delegate: AddThing?


    
    @IBOutlet weak var txt: UITextView!
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        
    }

 
    @IBAction func save(_ sender: Any) {
        
        guard let thing = self.txt.text else { return }
        
        delegate?.addthing(thing)
        //vc1.database.append(self.txt.text!)
        //self.dismiss(animated: true, completion: nil)
       // let raw_cell = vc1.table1.cellForRow(at: index!)
       // let cell = raw_cell as? Cell
        
       // cell?.Lbl.text = self.txt.text
        
        
    }
    
}




