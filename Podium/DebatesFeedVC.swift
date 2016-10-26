//
//  MenuVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/10/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    //cuentas columnas?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Cuantas lineas vamos a tener
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    //Cree igual a X columna y no haga muchas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebCell", for: indexPath)
        
        return cell
        
    }
  
    @IBAction func BackPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
