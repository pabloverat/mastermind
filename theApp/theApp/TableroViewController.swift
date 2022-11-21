//
//  TableroViewController.swift
//  theApp
//
//  Created by user223248 on 10/15/22.
//

import UIKit

class 	TableroViewController: UIViewController {

    // MARK: - Outlets
    
    // elements in view
    @IBOutlet weak var jugadas: UIStackView!
    @IBOutlet weak var pistas: UIStackView!
    @IBOutlet weak var colores: UIStackView!
    @IBOutlet weak var LbTiempo: UILabel!
    
    // ***** START: tablero *****
    
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
    
    // ***** END: tablero *****

    // ***** START: pistas *****

    // row 1
    @IBOutlet weak var pr1c1: UIButton!
    @IBOutlet weak var pr1c2: UIButton!
    @IBOutlet weak var pr1c3: UIButton!
    @IBOutlet weak var pr1c4: UIButton!
    
    // row 2
    @IBOutlet weak var pr2c1: UIButton!
    @IBOutlet weak var pr2c2: UIButton!
    @IBOutlet weak var pr2c3: UIButton!
    @IBOutlet weak var pr2c4: UIButton!
    
    // row 3
    @IBOutlet weak var pr3c1: UIButton!
    @IBOutlet weak var pr3c2: UIButton!
    @IBOutlet weak var pr3c3: UIButton!
    @IBOutlet weak var pr3c4: UIButton!

    // row 4
    @IBOutlet weak var pr4c1: UIButton!
    @IBOutlet weak var pr4c2: UIButton!
    @IBOutlet weak var pr4c3: UIButton!
    @IBOutlet weak var pr4c4: UIButton!

    // row 5
    @IBOutlet weak var pr5c1: UIButton!
    @IBOutlet weak var pr5c2: UIButton!
    @IBOutlet weak var pr5c3: UIButton!
    @IBOutlet weak var pr5c4: UIButton!
    
    // row 6
    @IBOutlet weak var pr6c1: UIButton!
    @IBOutlet weak var pr6c2: UIButton!
    @IBOutlet weak var pr6c3: UIButton!
    @IBOutlet weak var pr6c4: UIButton!
    
    // row 7
    @IBOutlet weak var pr7c1: UIButton!
    @IBOutlet weak var pr7c2: UIButton!
    @IBOutlet weak var pr7c3: UIButton!
    @IBOutlet weak var pr7c4: UIButton!
    
    // row 8
    @IBOutlet weak var pr8c1: UIButton!
    @IBOutlet weak var pr8c2: UIButton!
    @IBOutlet weak var pr8c3: UIButton!
    @IBOutlet weak var pr8c4: UIButton!
    
    
    // ***** END: pistas *****

    
    
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
    
    var tablaPistas = [[UIButton]]()
    
    var guessingRow = Array(repeating: 0, count: 4)
    
    var code : [Int]?

    var activeRow : Int?
    
    var activeColor : Int?
    
    var listaJugadores = [Player]()

    
    // MARK: - Generate secret code
    
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
            if let col = tablero[activeRow! - 1].firstIndex(of: sender),
               let color = activeColor,
               let img = getActiveImage() {
                if !guessingRow.contains(color){
                    guessingRow[col] = color
                    sender.setBackgroundImage(img, for: .normal)
                }
            }
        }
    }
    
    // MARK: - Checking guess
    
    @IBAction func checkBttn(_ sender: UIButton) {
        
        if !guessingRow.contains(0){
            let eval = evaluateGuess(guess: guessingRow, code: code!)
            
            print(code as Any)
            print(guessingRow)
            print(eval)
            guessingRow = [0,0,0,0]
            
            updatePistas(eval: eval)
            
            
            
            if activeRow! < 8{// no ha excedido el num de intentos
                if eval[0]==1 && eval[1]==1 && eval[2]==1 && eval [3]==1{//todas las canicas entan correctas
                   alertWin()
                }
                
            }
            else if activeRow! == 8	{// se excedio el numero de intentos
                if eval[0]==1 && eval[1]==1 && eval[2]==1 && eval [3]==1{//todas las canicas entan correctas
                    alertWin()
                }else {alertLose()}
            }
            
            activeRow! += 1
            updateActiveRow()
        }
    }
    
    func updateActiveRow() {
        let eval = evaluateGuess(guess: guessingRow, code: code!)
        
        for row in tablero {
            for marbleBttn in row {
                marbleBttn.isEnabled = false
            }
        }
        if activeRow! < 9
        {
            for marbleBttn in tablero[activeRow! - 1] {
                marbleBttn.isEnabled = true
            }
        }
          
    }
   // func segueGanador(){}
    //MARK: - FUNC WIN & LOSE
    // variable que guarda las iniciales del jugador ganador
    //let userText : String
    var iniciales : String = "anonimo"
    
    
    func regresarInicio(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func alertLose(){
        timer.invalidate()
        let alertaLose = UIAlertController (title: "YOU LOSE", message: "", preferredStyle: .alert)
        let accionRegresar = UIAlertAction (title: "Salir", style: .cancel){
            act in
            self.regresarInicio()
        }
 
        alertaLose.addAction(accionRegresar)
        present(alertaLose, animated: true)
       
        
    }
   
    
    
    func alertWin(){
        
        timer.invalidate()
        
        
        let alertaWin = UIAlertController (title: "YOU WIN!", message: "Tu tiempo fue de: "+String(format: "%.1f", counter)+" s"+"\n Ingresa tus iniciales", preferredStyle: .alert)
        
        
        let accionRegistrar = UIAlertAction(title: "Registrar", style: .default, handler: { [weak alertaWin] (_)
            in  guard let textField = alertaWin?.textFields?[0],   let usertext = textField.text
            else { return }
            if usertext != ""{
                self.iniciales = usertext }
            
            self.regresarInicio()
            print(self.iniciales as Any)
            
            self.uploadIniciales(iniciales: self.iniciales, counter: self.counter)
        })
        
        alertaWin.addTextField { (textField) in
            textField.placeholder = "Iniciales"
            
        }
       
        
        alertaWin.addAction(accionRegistrar)
        present(alertaWin, animated: true)
        
    
    }
    
    
    // MARK: - Guardar y obtener
    
    func dataFileURL() -> URL{
        let documentsDirectory = FileManager.default
            .urls(for: .documentDirectory, in:.userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("scores").appendingPathExtension("plist")
        print(pathArchivo.path)
        return pathArchivo
    }
    
    func uploadIniciales(iniciales : String, counter : Double){
        
        //let app = UIApplication.shared
        //NotificationCenter.default.addObserver(self, selector: #selector(guardarScores), name: UIApplication.didEnterBackgroundNotification, object: app)
        if FileManager.default.fileExists(atPath: dataFileURL().path())
        {
             obtenerScores()
        }
        
        listaJugadores.append(Player(nombre: iniciales, tiempo: counter))

        guardarScores()
        
    }
    
    func obtenerScores(){
        listaJugadores.removeAll()

        do {
            let data = try Data.init(contentsOf: dataFileURL())
            listaJugadores = try PropertyListDecoder().decode([Player].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
    }
    
    @objc func guardarScores(){
        do {
            let data = try PropertyListEncoder().encode(listaJugadores)
            try data.write(to: dataFileURL())
            print("ya guardé datos")
        }
        catch {
            print("error al guardar los datos")
        }
    }
    


    
    // MARK: - Printing clues

    func getIndicatorImage(forCode : Int) -> UIImage? {
        if forCode == 0 {
            return UIImage(named: "whiteIndicator")
        }
        if forCode == 1 {
            return UIImage(named: "blackIndicator")
        }
        return UIImage(named: "grayIndicator")
    }
    
    func updatePistas(eval : [Int]){
        for idx in 0...3 {
            print(idx)
            let img = getIndicatorImage(forCode: eval[idx])
            tablaPistas[activeRow! - 1][idx].setBackgroundImage(img, for: .normal)
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
    // MARK: - Modificacion hecha para lo de files
        /*let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(guardarScores), name: UIApplication.didEnterBackgroundNotification, object: app)
        if FileManager.default.fileExists(atPath: dataFileURL().path())
        {
            obtenerScores()
        }*/
        jugadas.layer.cornerRadius = 10
        pistas.layer.cornerRadius = 10
        colores.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        code = generateCode()

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
        
        tablaPistas = [[pr1c1, pr1c2, pr1c3, pr1c4],
                       [pr2c1, pr2c2, pr2c3, pr2c4],
                       [pr3c1, pr3c2, pr3c3, pr3c4],
                       [pr4c1, pr4c2, pr4c3, pr4c4],
                       [pr5c1, pr5c2, pr5c3, pr5c4],
                       [pr6c1, pr6c2, pr6c3, pr6c4],
                       [pr7c1, pr7c2, pr7c3, pr7c4],
                       [pr8c1, pr8c2, pr8c3, pr8c4]
                      ]
        
        activeRow = 1
        updateActiveRow()
        
        
    }

    override open var shouldAutorotate: Bool {
           return false
       }
}
    


    


