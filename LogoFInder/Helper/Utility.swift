//
//  Utility.swift
//  tableViewDemo
//
//  Created by Elluminati on 12/01/17.
//  Copyright © 2017 tag. All rights reserved.
//

import UIKit
import Foundation
//import SDWebImage
class Utility: NSObject
{
    class func convertImageToBase64(image: UIImage) -> String
    {
        let imageData = image.pngData()!
        
        return imageData.base64EncodedString()
    }
    static func deg2rad(deg:Double) -> Double {
        return deg * Double.pi / 180
    }
    static func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / Double.pi
    }
    static var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    static var overlayView = UIView();
    static var mainView = UIView();
    
    
    
    static var messageActivityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    static var messageOverlayView = UIView();
    static var messageLoaingView = UIView();
    
    override init(){
        
    }

    
    static func showLoading(color: UIColor = UIColor.white){
        DispatchQueue.main.async {
            if(!activityIndicator.isAnimating)
            {
                self.mainView = UIView()
                self.mainView.frame = UIScreen.main.bounds
                self.mainView.backgroundColor = UIColor.clear
                self.overlayView = UIView()
                self.activityIndicator = UIActivityIndicatorView()
                
                overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
                overlayView.clipsToBounds = true
                overlayView.layer.cornerRadius = 10
                overlayView.layer.zPosition = 1
                
                activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
                activityIndicator.style = .whiteLarge
                overlayView.addSubview(activityIndicator)
                self.mainView.addSubview(overlayView)
                
                if APPDELEGATE.window?.viewWithTag(701) != nil
                {
                    UIApplication.shared.keyWindow?.bringSubviewToFront(mainView)
                }
                else
                {
                    overlayView.center = (UIApplication.shared.keyWindow?.center)!
                    mainView.tag = 701
                    UIApplication.shared.keyWindow?.addSubview(mainView)
                    activityIndicator.startAnimating()
                }
            }
            
        }
        
    }
    
    
    static func showMessageLoading(color: UIColor = UIColor.white,message:String)
    {
        DispatchQueue.main.async {
            
            Utility.hideLoading()
            print("utility message show")
            
            if(!messageActivityIndicator.isAnimating)
            {
                self.messageLoaingView = UIView()
                self.messageLoaingView.frame = UIScreen.main.bounds
                self.messageLoaingView.backgroundColor = UIColor.clear
                self.messageOverlayView = UIView()
                self.messageActivityIndicator = UIActivityIndicatorView()
                messageLoaingView.tag = 702
                let messageLabel:UILabel = UILabel.init()
                messageLabel.text = message
                messageLabel.frame = CGRect(x: 80, y: messageOverlayView.bounds.height / 2, width: UIScreen.main.bounds.width * 0.4, height: 80)
                messageLabel.textAlignment = .center
                messageLabel.textColor = UIColor.black
                //   messageLabel.font = FontHelper.font(size: FontSize.regular, type: FontType.Regular)
                messageLabel.numberOfLines = 2
                messageOverlayView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.8, height: 80)
                
                
                messageOverlayView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                messageOverlayView.clipsToBounds = true
                messageOverlayView.layer.cornerRadius = 10
                messageOverlayView.layer.zPosition = 1
                
                messageActivityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                messageActivityIndicator.center = CGPoint(x: 30, y: messageOverlayView.bounds.height / 2)
                
                messageLabel.center = messageOverlayView.center
                
                messageOverlayView.setShadow()
                
                messageActivityIndicator.style = UIActivityIndicatorView.Style.gray
                messageOverlayView.addSubview(messageLabel)
                messageOverlayView.addSubview(messageActivityIndicator)
                self.messageLoaingView.addSubview(messageOverlayView)
                
                if APPDELEGATE.window?.viewWithTag(702) != nil
                {
                    messageOverlayView.center = (UIApplication.shared.keyWindow?.center)!
                    
                    
                    UIApplication.shared.keyWindow?.bringSubviewToFront(messageLoaingView)
                    messageActivityIndicator.startAnimating()
                }
                else
                {
                    messageOverlayView.center = (UIApplication.shared.keyWindow?.center)!
                    UIApplication.shared.keyWindow?.addSubview(messageLoaingView)
                    messageActivityIndicator.startAnimating()
                }
            }
            else
            {
                
            }
            
        }
        
    }
    static func hideMessageLoading()
    {
        DispatchQueue.main.async {
            messageActivityIndicator.stopAnimating();
            UIApplication.shared.keyWindow?.viewWithTag(702)?.removeFromSuperview()
            messageLoaingView.removeFromSuperview()
            print("utility message hide")
            
        }
    }
    
    static func hideLoading(){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating();
            UIApplication.shared.keyWindow?.viewWithTag(701)?.removeFromSuperview()
        }
    }
    static func showToast( message:String, backgroundColor:UIColor = UIColor.white, textColor:UIColor = UIColor.white){
        
        if !message.isEmpty
        {
            DispatchQueue.main.async {
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
                let label = UILabel(frame: CGRect.zero);
                label.textAlignment = NSTextAlignment.center;
                label.text = message;
                label.adjustsFontSizeToFitWidth = true;
                
                label.backgroundColor =  backgroundColor; //UIColor.whiteColor()
                label.textColor = textColor; //TEXT COLOR
                label.sizeToFit()
                label.numberOfLines = 4
                label.layer.shadowColor = UIColor.gray.cgColor;
                label.layer.shadowOffset = CGSize.init(width: 4, height: 3)
                label.layer.shadowOpacity = 0.3;
                label.frame = CGRect.init(x: 0, y: (appDelegate.window?.frame.maxY)!, width:  appDelegate.window!.frame.size.width, height: 44);
                
                label.alpha = 1
                
                //UIApplication.shared.keyWindow?.addSubview(label)
                UIApplication.shared.windows.last?.addSubview(label)
                
                
                var basketTopFrame: CGRect = label.frame;
                basketTopFrame.origin.x = 0;
                basketTopFrame.origin.y = (appDelegate.window?.frame.maxY)! - label.frame.height;
                
                UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
                    label.frame = basketTopFrame
                },  completion: {
                    (value: Bool) in
                    UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                        label.alpha = 0
                    },  completion: {
                        (value: Bool) in
                        label.removeFromSuperview()
                    })
                })
            }
        }
    }
    static func conteverDictToJson(dict:Dictionary<String, Any>) -> Void{
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
    }
    
    //MARK:
    //MARK: - Date Handler
    
  
   
    
    static func addGestureForRemoveViewOnTouch(view:UIView)
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideView))
        view.addGestureRecognizer(tap)
    }
    @objc static func hideView(sender:UITapGestureRecognizer)
    {
        let view:UIView = sender.view!
        view.removeFromSuperview()
        view.endEditing(true)
    }
    
   
    static func randomNumberGenerate()->String{
        let randoms = Int.random(in: 0 ..< 1000)
        return String(randoms)
    }
    
    static func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }

    public enum ImageFormat {
        case png
        //case jpeg(CGFloat)
    }
    
    static func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = image.pngData()
            //  case .jpeg(let compression): imageData = //UIImageJPEGRepresentation(image, compression)
        }
        return imageData?.base64EncodedString()
    }
    
  
}



