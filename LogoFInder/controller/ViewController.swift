//
//  ViewController.swift
//  LogoFInder
//
//  Created by Janki on 04/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var logoFetchArray : [Json4Swift_Base]!
    var logodata : Json4Swift_Base!
    
    @IBOutlet weak var tablevW: UITableView!
    @IBOutlet weak var txtLogoName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  self.view.setGradientBackground(colorTop: .clear, colorBottom: UIColor.blue)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.txtLogoName.becomeFirstResponder()
    }
    @IBAction func GoBtn(_ sender: Any) {
        self.txtLogoName.resignFirstResponder()
        if txtLogoName.text?.isEmpty == true{
            self.txtLogoName.becomeFirstResponder()
            Utility.showToast(message: "Enter Company name")
        }
        else{
            dataFecthonQuery(query: txtLogoName.text!)
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if logoFetchArray == nil {
            return 0
        }else{
            return logoFetchArray.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellLogo : logofindCell = tableView.dequeueReusableCell(withIdentifier: "logocell") as! logofindCell

        
        let datas : Json4Swift_Base = logoFetchArray[indexPath.row]
        //cellLogo.viewcell.setRound()
        cellLogo.viewcell.layer.cornerRadius = 10.0
//cellLogo.viewcell.setShadow()
        cellLogo.logoName.text = datas.name
        cellLogo.domainName.text = datas.domain
        if let url = URL(string: datas.logo!) {
            print("Download Started")
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    cellLogo.imgView.image = UIImage(data: data)
                                 }
            }
        }


        return cellLogo
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fetchdataobj : FetchDataVC = self.storyboard?.instantiateViewController(withIdentifier: "logofetch") as! FetchDataVC
        let datas : Json4Swift_Base = logoFetchArray[indexPath.row]
        fetchdataobj.strDomainName = datas.domain
        fetchdataobj.strCompanyName = datas.name
        fetchdataobj.strImg = datas.logo
        self.navigationController?.pushViewController(fetchdataobj, animated: true)
        
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func dataFecthonQuery(query:String){
        
        Utility.showLoading()
        
        let urlString : String = Webservice.baseUrl + "?\(PARAMS.query)=\(query)"
        
        var url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print(url!)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON
            { (response:DataResponse<Any>) in
                let jsonDecoder = JSONDecoder()
                
                self.logoFetchArray = try? jsonDecoder.decode([Json4Swift_Base].self , from: response.data!)
            
                Utility.hideLoading()
                self.tablevW.reloadData()
            
        }
        
    }

}
