//
//  ViewController.swift
//  APISampleApp
//
//  Created by Ryo Motoki on 2018/03/07.
//  Copyright © 2018年 RyoMotoki. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var titileTableView: UITableView!
    var articles = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titileTableView.delegate = self
        titileTableView.dataSource = self
        
        getArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = articles[indexPath.row][0]
        return cell
    }
    
    func getArticles() {
        Alamofire.request("https://qiita.com/api/v2/items", method: .get).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach({ (_, json) in
                print(json["title"].string)
                let article = [json["title"].string, json["user"]["id"].string]
                self.articles.append(article as! [String])
            })
            print(self.articles)
            self.titileTableView.reloadData()
        }
    }

}

