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
    @IBOutlet weak var LbTiempo: UILabel!
    
    var marble : [Int:String] = [1:"green", 2:"aqua", 3:"orange", 4:"red", 5:"purple", 6:"yellow"]
    
    var guessEval : [Int:String] = [-1:"badGuess", 0:"mediumGuess", 1:"goodGuess"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jugadas.layer.cornerRadius = 10
        pistas.layer.cornerRadius = 10
        colores.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        let code = generateCode()
        print(code)
        let guess = generateCode()
        print(guess)

        let evaluation = evaluateGuess(guess: guess, code: code)
        print(evaluation)
        
        //TIEMPO
        LbTiempo.text = "Tiempo "+String(counter)
        startTimer()

        
    }
    
    func generateCode() -> [Int] {
        var code = [Int]()
        while(code.count < 4) {
            let num : Int = Int.random(in: 1...6)
            if (!code.contains(num)) {
                code.append(num)
            }
        }
        return code
    }
    
    func evaluateGuess(guess : [Int], code : [Int]) -> [Int] {
        var evaluation = [Int](repeating: -1, count: 4)
        for i in 0...guess.count-1 {
            if guess[i] == code[i]{
                evaluation[i] = 1
            } else if (code.contains(guess[i])) {
                evaluation[i] = 0
            }
        }
        return evaluation.sorted(by: >)
    }
    
    //MARK: - PAUSA Y CRONOMETRO
    var counter = 0.0
    var timer = Timer()
    
    @IBOutlet weak var BtnPausa: UIButton!
    
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        LbTiempo.text = "Tiempo "+String(format: "%.1f", counter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Pausa(_ sender: UIButton) {
        timer.invalidate()

   
        
        let alertaP = UIAlertController (title: "PAUSA", message: "PAUSA", preferredStyle: .alert)
        let accionRegresar = UIAlertAction (title: "Regresar", style: .cancel){
            act in
            self.startTimer()
        }
 
        alertaP.addAction(accionRegresar)
        present(alertaP, animated: true)
        
    }
    
  //  @IBAction func Pausar(_ sender: UIButton) {}
    
    
    
    // MARK: - Navigation

 
    

}
