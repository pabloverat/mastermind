//
//  ViewControllerPausa.swift
//  theApp
//
//  Created by user224727 on 11/2/22.
//

import UIKit

class ViewControllerPausa: UIViewController, UIPopoverPresentationControllerDelegate{

    
    var counter : Double!
    var source : UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSize(width: 250, height: 250)
        
    }
    @IBAction func BtnRegesar(_ sender: UIButton) {
        
       
        var vistaTablero = source as! TableroViewController
        vistaTablero.startTimer()
        vistaTablero.BtnPausa.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    

    
    
    

    //  MARK: - Navigation
   

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
}
