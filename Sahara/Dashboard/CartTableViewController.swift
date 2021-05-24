//
//  CartTableViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class CartTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        bodyViewGradient()
        headerViewGradient()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func headerViewGradient() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = headerView.bounds
        
        // Set an array of CGColors to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).cgColor, UIColor(red: 150/255, green: 180/255, blue: 180/255, alpha: 0.80).cgColor]
        
        // Rasterize this layer to improve perfromance
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the background
        headerView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Diagonal: top left to bottom corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // top left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // bottom right
    }

    func bodyViewGradient() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = bodyView.bounds
        
        // Set an array of CGColors to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1).cgColor, UIColor(red: 150/255, green: 180/255, blue: 180/255, alpha: 0.80).cgColor]
        
        // Rasterize this layer to improve perfromance
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the background
        bodyView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Diagonal: top left to bottom corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // top left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // bottom right
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Cart is empty."
        return cell
    }
    
    @IBAction func textToSpeechSearch(_ sender: Any) {
    }
    
    @IBAction func purchase(_ sender: Any) {
        
    }
    
    @IBAction func deliveryAddress(_ sender: Any) {
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
