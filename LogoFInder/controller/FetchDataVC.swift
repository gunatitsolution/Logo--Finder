//
//  FetchDataVC.swift
//  LogoFInder
//
//  Created by Janki on 05/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import UIKit
import Photos
class FetchDataVC: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var domainName: UILabel!
    
    var strImg : String? = nil
    var strCompanyName : String? = ""
    var strDomainName : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpView()
    }
    func setUpView(){
        companyName.text = strCompanyName
        domainName.text = strDomainName
        let urlt = URL.init(string: strImg ?? "")
        downloadImage(url: urlt!)
    }
    func downloadImage(url: URL){
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgView.image = UIImage(data: data)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    @IBAction func onClickShareBtn(_ sender: Any) {
        let textToShare = "LogoFinder app : \(companyName.text) and logo is : \(strImg)"
        
        if let myWebsite = NSURL(string: "http://www.twitter.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func DownloadImg(_ sender: Any) {

        let videoImageUrl = "\(strImg)"
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoImageUrl),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)\(self.strCompanyName).mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Logo is saved!")
                            self.createnotification()
                        }
                    }
                }
            }
        }

    }
    func createnotification(){
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
        notification.alertBody = "Your Logo : " + "\(strCompanyName)" + "is saved!"
        notification.alertAction = "Ok" //  used in UIAlert button or 'slide to unlock...' slider in place of unlock
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["customParameterKey_from": "Sergey"] // Array of custom parameters
        notification.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
}
