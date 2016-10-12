//
//  DashBoardTableViewController.swift
//  TestTwo
//
//  Created by Emmanuel Casañas Cruz on 10/11/16.
//  Copyright © 2016 Emmanuel Casañas Cruz. All rights reserved.
//

import UIKit

class DashBoardTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
	
	func sendRequest() {
		/* Configure session, choose between:
		* defaultSessionConfiguration
		* ephemeralSessionConfiguration
		* backgroundSessionConfigurationWithIdentifier:
		And set session-wide properties, such as: HTTPAdditionalHeaders,
		HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
		*/
		let sessionConfig = URLSessionConfiguration.default
		
		/* Create session, and optionally set a NSURLSessionDelegate. */
		let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
		
		/* Create the Request:
		Request (2) (GET https://api.edmunds.com/api/vehicle/v2/makes)
		*/
		
		guard var URL = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/makes") else {return}
		let URLParams = [
			"state": "new",
			"year": "2017",
			"view": "basic",
			"fmt": "json",
			"api_key": "x2u5zzgcrg8qhrn8xtz4tqga",
			]
		URL = URL.URLByAppendingQueryParameters(URLParams)
		let request = NSMutableURLRequest(url: URL as URL)
		request.httpMethod = "GET"
		
		/* Start a new Task */
		let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
			if (error == nil) {
				// Success
				let statusCode = (response as! HTTPURLResponse).statusCode
				print("URL Session Task Succeeded: HTTP \(statusCode)")
			}
			else {
				// Failure
				print("URL Session Task Failed: %@", error!.localizedDescription);
			}
		} as! (Data?, URLResponse?, Error?) -> Void)
		task.resume()
		session.finishTasksAndInvalidate()
	}
	

	/**
	Add, update, or remove a query string item from the URL
 
	:param: url   the URL
	:param: key   the key of the query string item
	:param: value the value to replace the query string item, nil will remove item
 
	:returns: the URL with the mutated query string
	*/
	public func addOrUpdateQueryStringParameter(url: String, key: String, value: String?) -> String {
		if let components = URLComponents(string: url),
			var queryItems = (components.queryItems) {
			for (index, item) in queryItems.enumerated() {
				// Match query string key and update
				if item.name == key {
					if let v = value {
						queryItems[index] = URLQueryItem(name: key, value: v) as URLQueryItem
					} else {
						queryItems.remove(at: index)
					}
					components.queryItems?.append(contentsOf: queryItems.count > 0)
	
					return components.string!
				}
			}
			
			// Key doesn't exist if reaches here
			if let v = value {
				// Add key to URL query string
				queryItems.append(NSURLQueryItem(name: key, value: v) as URLQueryItem)
				components.queryItems = queryItems
				return components.string!
			}
		}
		
		return url
	}
	
	/**
	Add, update, or remove a query string parameters from the URL
	
	:param: url   the URL
	:param: values the dictionary of query string parameters to replace
	
	:returns: the URL with the mutated query string
	*/
	public func addOrUpdateQueryStringParameter(url: String, values: [String: String]) -> String {
		var newUrl = url
		
		for item in values {
			newUrl = addOrUpdateQueryStringParameter(url: newUrl, key: item.0, value: item.1)
		}
		
		return newUrl
	}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
		

}
