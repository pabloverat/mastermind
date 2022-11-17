//
//  ScoresViewController.swift
//  theApp
//
//  Created by user220765 on 11/14/22.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    var listaJugadores = [Player]()
    //var counterFinal = 0.0 //tiempo - counter
    //var inicialesFinal = "" // iniciales - iniciales

    @IBOutlet var scorestableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let app = UIApplication.shared
        //NotificationCenter.default.addObserver(self, selector: #selector(guardarScores), name: UIApplication.didEnterBackgroundNotification, object: app)
        if FileManager.default.fileExists(atPath: dataFileURL().path()){
            obtenerScores()
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(listaJugadores.count,5)
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCells")!
        cell.textLabel?.text = listaJugadores[indexPath.row].nombre
        cell.detailTextLabel?.text = String(format: "%.1f", listaJugadores[indexPath.row].tiempo) + " s"
        
        return cell
        }
    
    func updateInTable(pos: Int,timer: Double, iniciales: String){
        listaJugadores[pos].tiempo = timer
        listaJugadores[pos].nombre = iniciales
        scorestableView.reloadData()
    }
    
    
    // MARK: - Guardar y obtener
    func dataFileURL() -> URL{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("scores").appendingPathExtension("plist")
        print(pathArchivo.path)
        return pathArchivo
    }
        
    /*
    @objc func guardarScores(){
        do {
            let data = try PropertyListEncoder().encode(listaJugadores)
            try data.write(to: dataFileURL())
        }
        catch {
            print("error al guardar los datos")
        }
    }
    */
        
    func obtenerScores(){
        listaJugadores.removeAll()
            
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            listaJugadores = try PropertyListDecoder().decode([Player].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
            
        scorestableView.reloadData()
            
    }



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
    

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        
        
        
    }*/
    
    
