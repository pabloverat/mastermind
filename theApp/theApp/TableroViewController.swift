//
//  TableroViewController.swift
//  theApp
//
//  Created by user223248 on 10/15/22.
//

import UIKit

class TableroViewController: UIViewController {

    @IBOutlet weak var jugadas: UIStackView!
    @IBOutlet weak var pistas: UIStackView!
    @IBOutlet weak var colores: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jugadas.layer.cornerRadius = 10
        pistas.layer.cornerRadius = 10
        colores.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
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
