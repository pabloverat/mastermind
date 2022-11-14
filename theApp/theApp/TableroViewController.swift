//
//  TableroViewController.swift
//  theApp
//
//  Created by user223248 on 10/15/22.
//

import UIKit

class TableroViewController: UIViewController {

    // MARK: - Outlets
    
    // elements in view
    @IBOutlet weak var jugadas: UIStackView!
    @IBOutlet weak var pistas: UIStackView!
    @IBOutlet weak var colores: UIStackView!
    @IBOutlet weak var LbTiempo: UILabel!
    
    // row 1
    @IBOutlet weak var br1c1: UIButton!
    @IBOutlet weak var br1c2: UIButton!
    @IBOutlet weak var br1c3: UIButton!
    @IBOutlet weak var br1c4: UIButton!
    
    // row 2
    @IBOutlet weak var br2c1: UIButton!
    @IBOutlet weak var br2c2: UIButton!
    @IBOutlet weak var br2c3: UIButton!
    @IBOutlet weak var br2c4: UIButton!
    
    // row 3
    @IBOutlet weak var br3c1: UIButton!
    @IBOutlet weak var br3c2: UIButton!
    @IBOutlet weak var br3c3: UIButton!
    @IBOutlet weak var br3c4: UIButton!
    
    // row 4
    @IBOutlet weak var br4c1: UIButton!
    @IBOutlet weak var br4c2: UIButton!
    @IBOutlet weak var br4c3: UIButton!
    @IBOutlet weak var br4c4: UIButton!
    
    // row 5
    @IBOutlet weak var br5c1: UIButton!
    @IBOutlet weak var br5c2: UIButton!
    @IBOutlet weak var br5c3: UIButton!
    @IBOutlet weak var br5c4: UIButton!
    
    // row 6
    @IBOutlet weak var br6c1: UIButton!
    @IBOutlet weak var br6c2: UIButton!
    @IBOutlet weak var br6c3: UIButton!
    @IBOutlet weak var br6c4: UIButton!
    
    // row 7
    @IBOutlet weak var br7c1: UIButton!
    @IBOutlet weak var br7c2: UIButton!
    @IBOutlet weak var br7c3: UIButton!
    @IBOutlet weak var br7c4: UIButton!
    
    // row 8
    @IBOutlet weak var br8c1: UIButton!
    @IBOutlet weak var br8c2: UIButton!
    @IBOutlet weak var br8c3: UIButton!
    @IBOutlet weak var br8c4: UIButton!
    
    // colores
    
    @IBOutlet weak var greenMarble: UIButton!
    @IBOutlet weak var aquaMarble: UIButton!
    @IBOutlet weak var orangeMarble: UIButton!
    @IBOutlet weak var redMarble: UIButton!
    @IBOutlet weak var purpleMarble: UIButton!
    @IBOutlet weak var yellowMarble: UIButton!
    
    // MARK: - CONTROL DE JUEGO
    
    var marble : [Int:String] = [1:"green", 2:"aqua", 3:"orange", 4:"red", 5:"purple", 6:"yellow"]
    var guessEval : [Int:String] = [-1:"badGuess", 0:"mediumGuess", 1:"goodGuess"]
    
    var tablero = [[UIButton]]()
    var guessingRow = Array(repeating: 0, count: 4)
    
    var code : [Int]?

    var activeRow : Int?
    
    var activeColor : Int?
    
    // MARK: - Generate code
    
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
    
    // MARK: - Building guess
    
    
    func getActiveImage() -> UIImage? {
        if let color = activeColor{
            return  UIImage(named: marble[color]! + "Marble")
        }
        return nil
    }
    
    @IBAction func setColor(_ sender: UIButton) {
        if sender.isEnabled {
            if let img = getActiveImage() {
                sender.setBackgroundImage(img, for: .normal)
            }
        }
        
        if let col = tablero[activeRow! - 1].firstIndex(of: sender),
           let color = activeColor {
            guessingRow[col] = color
        }
        
    }
    
    // MARK: - Checking guess
    
    @IBAction func checkBttn(_ sender: UIButton) {
        
        let eval = evaluateGuess(guess: guessingRow, code: code!)
        
        print(code)
        print(guessingRow)
        print(eval)
        
        activeRow! += 1
        updateActiveRow()
        
    }
    
    func updateActiveRow() {
        
        for row in tablero {
            for marbleBttn in row {
                marbleBttn.isEnabled = false
            }
        }
        
        for marbleBttn in tablero[activeRow! - 1] {
            marbleBttn.isEnabled = true
        }
    }
    

    
    // MARK: - Selecting active color
    
    func highlightOnlyMe(sender: UIButton){
        greenMarble.isSelected = false
        aquaMarble.isSelected = false
        orangeMarble.isSelected = false
        redMarble.isSelected = false
        purpleMarble.isSelected = false
        yellowMarble.isSelected = false
        
        
        sender.isSelected = true
        print(activeColor!)
    }
    
    @IBAction func selectGreenActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "green"})!.key
        highlightOnlyMe(sender: sender)
        
    }
    
    @IBAction func selectAquaActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "aqua"})!.key
        highlightOnlyMe(sender: sender)
    }
    
    @IBAction func selectOrangeActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "orange"})!.key
        highlightOnlyMe(sender: sender)
    }
    
    @IBAction func selectRedActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "red"})!.key
        highlightOnlyMe(sender: sender)
    }
    
    @IBAction func selectPurpleActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "purple"})!.key
        highlightOnlyMe(sender: sender)
    }
    
    @IBAction func selectYellowActive(_ sender: UIButton) {
        activeColor = marble.first(where: {$1 == "yellow"})!.key
        highlightOnlyMe(sender: sender)
    }
    
    // MARK: - Evaluating guess
    
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
    
    
    //MARK: - PAUSA Y CRONÓMETRO
    
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

   
        
        let alertaP = UIAlertController (title: "PAUSA", message: "", preferredStyle: .alert)
        let accionRegresar = UIAlertAction (title: "Continuar", style: .cancel){
            act in
            self.startTimer()
        }
 
        alertaP.addAction(accionRegresar)
        present(alertaP, animated: true)
        
    }
    
  //  @IBAction func Pausar(_ sender: UIButton) {}
    
    
    
    /// MARK: - Navigation

    
    // MARK: - VIEWDIDLOAD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jugadas.layer.cornerRadius = 10
        pistas.layer.cornerRadius = 10
        colores.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        code = generateCode()
        print(code)

        //TIEMPO
        LbTiempo.text = "Tiempo "+String(counter)
        startTimer()

        tablero = [[br1c1, br1c2, br1c3, br1c4],
                   [br2c1, br2c2, br2c3, br2c4],
                   [br3c1, br3c2, br3c3, br3c4],
                   [br4c1, br4c2, br4c3, br4c4],
                   [br5c1, br5c2, br5c3, br5c4],
                   [br6c1, br6c2, br6c3, br6c4],
                   [br7c1, br7c2, br7c3, br7c4],
                   [br8c1, br8c2, br8c3, br8c4]
                  ]
        
        activeRow = 1
        updateActiveRow()
        
        
    }
    

}
