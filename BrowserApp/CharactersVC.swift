//
//  CharactersVC.swift
//  BrowserApp
//
//  Created by Akniyet Just on 24.10.2021.
//

import UIKit
import WebKit
class CharactersVC: UITableViewController {
    
    var web_view: WKWebView?
    var str1: String?
    var str2: String?
    var text1: UITextField?
    var text2: UITextField?
    var isFavourite = false
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var characters: [Characters] =
    [
            Characters(name: "Wikipedia", webView: "https://www.wikipedia.org/"),
            Characters(name: "VK", webView: "https://www.vk.com"),
            Characters(name: "Google", webView: "https://www.google.com")
    ]
    
    private var favouriteCharacters: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Characters"
        
    }
    
    @IBAction func pressedSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isFavourite = false
        } else {
            isFavourite = true
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navCan = segue.destination as? UINavigationController {
                if let destination = navCan.visibleViewController as? InfoVC {
                    if let row = tableView.indexPathForSelectedRow?.row {
                        destination.navigationItem.title = characters[row].name
                        let myURL = URL(string: characters[row].webView!)
                        destination.url = myURL
                        destination.name = characters[row].name ?? ""
                        destination.myProtocol = self
                    }
                }
            }
        }
    }
    
    
    @IBAction func showAlert(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add website", message: "Fill all the fields", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter title"
            self.text1 = textField
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter url"
            self.text2 = textField
        })
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let n = Characters(name: self.text1?.text, webView: self.text2?.text)
            self.characters.append(n)
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFavourite ? favouriteCharacters.count : characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let character = isFavourite ? favouriteCharacters[indexPath.row] : characters[indexPath.row]
        cell.textLabel?.text = character.name

        return cell
    }
    
}
extension CharactersVC: CharactersProtocol {
    func addFavourite(name: String, webView: String) {
        let newcharacter = Characters(name: name, webView: webView)
        if let index = favouriteCharacters.firstIndex(where: {$0.name == newcharacter.name}) {
            favouriteCharacters.remove(at: index)
        } else {
            favouriteCharacters.append(newcharacter)
        }
        tableView.reloadData()
    }
}

