//
//  TodayViewController.swift
//  Letest News
//
//  Created by Vikash on 05/07/17.
//  Copyright © 2017 Vikash. All rights reserved.
//

import UIKit
import NotificationCenter
import Kingfisher
class TodayViewController: UIViewController, NCWidgetProviding,UITableViewDelegate,UITableViewDataSource {
        var newsDict = NSDictionary()
    var newArray = NSArray()
    @IBOutlet var newsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        callNewsWebservice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    func callNewsWebservice()
    {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        
        let url = URL(string:"https://newsapi.org/v1/articles?source=the-times-of-india&sortBy=latest&apiKey=f03fd49a33004f9881cfd77c842d834a")!
        let request = NSMutableURLRequest(url: url)
        request.timeoutInterval = 60
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            //        (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
                    print("json data:", json)
                    self.newsDict = json as! NSDictionary
                    self.newArray =  self.newsDict["articles"] as! NSArray
                    print(self.newsDict)
                    print("jksjfh: \(self.newArray)")

                    DispatchQueue.main.async {
                        
                    self.newsTableView.reloadData()
                    }
                }catch {
                    print("error in JSONSerialization")
                }
            }
        }
        task.resume()
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        //Show more/less button event
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = CGSize(width: 0, height: 110)
        }else {
            self.preferredContentSize = CGSize(width: 0, height: 444)
        }
    }
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.newArray.count
    
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! newsCell
        cell.selectionStyle=UITableViewCellSelectionStyle.none
        cell.source.text = self.newsDict .object(forKey: "source") as? String
        cell.title.text =  ((self.newArray.object(at: indexPath.row))as! NSDictionary).object(forKey: "title")as? String
        let imageUrl =  (self.newArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "urlToImage") as! String
        let url = URL(string: imageUrl)
        //cell.newsImage.kf.setImage(with: url , placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        cell.newsImage.kf.setImage(with: url )

//       let publishedAtString = (self.newArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "publishedAt") as? String
        if(((self.newArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "publishedAt") as? String) != nil)
        {
         cell.publishedAt.text = dateTimeComparision(dateTimeString: (self.newArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "publishedAt") as! String)
        }else{
            cell.publishedAt.text=""
        }
        
        //cell.newsImage.sd_setImage(with: url)
        return cell
        
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let urlString = (self.newArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "url") as! String
      let url = URL(string: urlString)
        self.extensionContext?.open(url!, completionHandler: nil)
    }
    
    func dateTimeComparision(dateTimeString: String) -> String
    {
        print("publish at\(dateTimeString)")
        let localTime = DateFormatter()
        localTime.calendar = Calendar(identifier: .iso8601)
        localTime.locale = Locale(identifier: "en_US_POSIX")
        localTime.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        localTime.timeZone = TimeZone(secondsFromGMT: 0)
        let timeStamp = localTime.date(from: dateTimeString)
        //cuurent date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateInFormat = dateFormatter.string(from: Date())
        let dateFromString = dateFormatter.date(from: dateInFormat)
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let components = (calendar as NSCalendar?)?.components([.year,.month,.weekOfMonth,.day, .hour, .minute, .second], from: timeStamp!, to: dateFromString!, options: NSCalendar.Options.init(rawValue: 0))
        //var components = calendar?.components([.Hour, .Minute, .Second], fromDate: NSDate())
        if((components?.hour)! > 0)
        {
            let hour : Int = (components?.hour)!
            let hourString = String(describing: hour) + "h"
            return hourString
        }else if((components?.minute)! > 0){
            let  min : Int = (components?.minute)!
            let minString = String(describing: min) + "m"
            return minString
        }
        else if((components?.day)! > 0){
            let  day : Int = (components?.day)!
            let dayStr = String(describing: day) + "d"
            return dayStr
        }
        return ""
        
    }
}
