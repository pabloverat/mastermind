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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
