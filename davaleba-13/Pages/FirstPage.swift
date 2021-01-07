//
//  ViewController.swift
//  davaleba-13
//
//  Created by Ladolado3911 on 12/12/20.
//

import UIKit

class FirstPage: UIViewController {
    
    var database = [String]()
    var temp_database = [String]()
    var isSearchBarActive: Bool = false
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var srch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table1.dataSource = self
        table1.delegate = self
        srch.delegate = self

        let right_button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(act))
        navigationItem.setRightBarButton(right_button, animated: true)
        
        for a in 0...100 {
            database.append(String(a))
        }

    }
    
    @objc func act(_ sender: UIBarButtonItem) {
        table1.isEditing = !table1.isEditing
        sender.title = table1.isEditing ? "Done" : "Edit"
    }

    @IBAction func btt(_ sender: Any) {
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondPage") as? SecondPage
        
        vc2?.delegate = self
        
        self.present(vc2!, animated: true, completion: nil)
    }
}

extension FirstPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearchBarActive == false) {
            return self.database.count
        } else {
            return self.temp_database.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (isSearchBarActive == false) {
            let cell = table1.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(database[indexPath.row])"
              
            return cell
            
        } else {
            let cell = table1.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(temp_database[indexPath.row])"
            
            return cell
        }
    }
}

extension FirstPage: UITableViewDelegate {
    //
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = database.remove(at: sourceIndexPath.row)
        database.insert(temp, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "remove") { (action, view, completion) in
            print("remove")
            view.backgroundColor = .red
            
            if (self.isSearchBarActive == true) {
                let element = self.temp_database[indexPath.row]
                let index2 = self.database.firstIndex(of: element)
                self.database.remove(at: index2!)
                self.temp_database.remove(at: indexPath.row)
                
                self.table1.deleteRows(at: [indexPath], with: .right)
            }
            else {
                self.database.remove(at: indexPath.row)
                self.table1.deleteRows(at: [indexPath], with: .right)
            }
        }
        
        let edit = UIContextualAction(style: .normal, title: "edit") {action, view, completion in
            print("edit")
            view.backgroundColor = .blue
            
            if (self.isSearchBarActive == true) {
                let element = self.temp_database[indexPath.row]
                let index2 = self.database.firstIndex(of: element)
                
                let text = self.database[index2!]
                
                let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditPage") as? EditPage
                vc2?.delegate2 = self
                vc2?.txt1 = text
                vc2?.index1 = indexPath.row
                vc2?.index2 = index2
                vc2?.isSearchActive = self.isSearchBarActive
                self.present(vc2!, animated: true, completion: nil)
            }
            else {
                let text = self.database[indexPath.row]
                
                let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditPage") as? EditPage
                vc2?.delegate1 = self
                vc2?.txt1 = text // found nil while unwrapping optional value
                vc2?.index1 = indexPath.row
                vc2?.isSearchActive = self.isSearchBarActive
                self.present(vc2!, animated: true, completion: nil)
            }
        }
        
        action.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [action, edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcNext = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditPage") as? EditPage
        
        
        if (isSearchBarActive == true) {
            let element = self.temp_database[indexPath.row]
            let index2 = self.database.firstIndex(of: element)
            
            let text = self.database[index2!]
            
            vcNext?.delegate2 = self
            vcNext?.txt1 = text
            vcNext?.index1 = indexPath.row
            vcNext?.index2 = index2
            vcNext?.isSearchActive = self.isSearchBarActive
            self.present(vcNext!, animated: true, completion: nil)
        }
        else {
            let text = self.database[indexPath.row]
            
            vcNext?.delegate1 = self
            vcNext?.txt1 = text
            vcNext?.index1 = indexPath.row
            vcNext?.isSearchActive = self.isSearchBarActive
            self.present(vcNext!, animated: true, completion: nil)
        }
    }
}

extension FirstPage: AddThing {
    func addthing(_ str: String) {
        self.dismiss(animated: true) {
            self.database.append(str)
            self.table1.reloadData()
        }
    }
}

extension FirstPage: ChangeText2 {
    func changeText(_ new_txt: String, _ index1: Int, _ index2: Int) {
        self.dismiss(animated: true) {
            self.database[index2] = new_txt
            self.temp_database[index1] = new_txt
            self.table1.reloadData()
        }
    }
}

extension FirstPage: ChangeText1 {
    func changeText(_ new_txt: String, _ index1: Int) {
        self.dismiss(animated: true) {
            self.database[index1] = new_txt
            self.table1.reloadData()
        }
    }
}

extension FirstPage: UISearchDisplayDelegate {
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        table1.reloadData()
    }
}

extension FirstPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchBarActive = true
        temp_database = database.filter {$0.contains(searchText)}
        if (searchText == "") {
            temp_database = database
        }
        table1.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        isSearchBarActive = false
        table1.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        isSearchBarActive = false
        table1.reloadData()
    }
}


