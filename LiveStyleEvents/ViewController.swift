//
//  ViewController.swift
//  LiveStyleEvents
//
//  Created by Venkat Madira on 05/10/2019.
//  Copyright © 2019 Venkat Madira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    final let url = URL(string: "https://my-json-server.typicode.com/livestyled/mock-api/events")
    private var events = [Event]()
    var favoriteEvents: [Event] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJson()
        tableView.tableFooterView = UIView()
    }
    // MARK: -downloadJson Start
    func downloadJson() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                
                self.displayAlert(title: "Error in Events loading...", message: (error?.localizedDescription)!)
                return
            }
            do{
                
                let decoder = JSONDecoder()
                let downloadedEvents = try decoder.decode([Event].self, from: data)
                self.events = downloadedEvents
                for eventDownloaded in downloadedEvents{
                    self.events.append(Event(id: eventDownloaded.id, title: eventDownloaded.title, image: eventDownloaded.image, startDate: eventDownloaded.startDate))
                }
                
                self.events.sort{$0.startDate < $1.startDate}
                
                for evnt in self.events{
                    UserDefaults.standard.set(true, forKey: evnt.id)
                    
                }
                
                
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.tableView.reloadData()
                }
                
                
            }catch{
                self.displayAlert(title: "OOPS", message: "Please try Again!")
            }
            
            }.resume()
    }
    // MARK: - downloadJson End
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as? EventTableViewCell else{
            return UITableViewCell()
        }
        // creating link between cell and view controller.. Pass data
        cell.link = self
        if(UserDefaults.standard.bool(forKey:self.events[indexPath.row].id)){
            cell.favouriteBtnPressed.setTitle("Favourite", for: .normal)
        }else{
            cell.favouriteBtnPressed.setTitle("UnFavourite", for: .normal)
        }
        
        //Eevent name preparetion
        cell.eventNameLbl.text = events[indexPath.row].title
        //Image prepararion
        if let imageURL = URL(string: events[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.eventImageView.image = image
                    }
                }
            }
        }
        
        //date cell preparation
        if let timeIntervel = self.events[indexPath.row].startDate as? Int64{
            cell.eventDateLbl.text = getDateString(time: Double(timeIntervel))
        }
        
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* func tableView(_ tableView: UITableView,
     willDisplay cell: UITableViewCell,
     forRowAt indexPath: IndexPath){
     let lastEvent = self.events.count - 1
     
     if(indexPath.row == lastEvent){
     downloadJson()
     }
     
     }*/
    //MARK: Image download from URL
    
    func imageDownload(imageURL: URL){
        
    }
    
    
    // MARK: -getCellInformation
    func getCellInformation(cell:UITableViewCell) -> String{
        var idStr = ""
        if let indexPath = tableView.indexPath(for: cell){
            if let id = self.events[indexPath.row].id as? String{
                idStr = id
            }
        }
        return idStr
        
    }
    // MARK: -displayAlert
    // Global Alert display
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: -getDateString
    // getting time interval and convert to data string format
    func getDateString(time:Double)->String{
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yy HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        //  print(formatter.string(from: date as Date))
        return formatter.string(from: date as Date)
    }
    
}

