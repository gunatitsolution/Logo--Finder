//
//  UIView+Utils.swift
//  BigRed
//
//  Created by Sapana Ranipa on 17/09/16.
//  Copyright © 2016 Elluminati. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

//MARK:- UIVIEW Extension
extension UIView
{
    
    func setupButton(borderColor:UIColor = UIColor.clear, backgroundColor:UIColor = UIColor.black)
    {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0, height:1)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = (self.frame.height/2)
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true;
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor
    }
    
     func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        
        gradientLayer.frame = bounds
    
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    //// for apply two corner Radius
    func navigationShadow()
    {
        
        if self.layer.name != "abc"
        {
            self.layer.name = "abc"
            
            let path = UIBezierPath(roundedRect:self.bounds,
                                    byRoundingCorners:[.bottomLeft,.bottomRight],
                                    cornerRadii: CGSize(width: 10, height:  10))
            
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = path.cgPath
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowOpacity = 0.27
            shadowLayer.shadowRadius = 1.8
            shadowLayer.shadowOffset = CGSize.init(width: 0, height: 2.8)
            shadowLayer.name = "navigationShadow"
            self.layer.addSublayer(shadowLayer)
            
            let maskPath1 = UIBezierPath(roundedRect: bounds,
                                         byRoundingCorners: [.bottomLeft , .bottomRight],
                                         cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer1 = CAShapeLayer()
            maskLayer1.frame = bounds
            maskLayer1.name = "cornerRadious"
            maskLayer1.fillColor = UIColor.black.cgColor
            maskLayer1.path = maskPath1.cgPath
            self.layer.addSublayer(maskLayer1)
        }
        for view in self.subviews
        {
            self.bringSubviewToFront(view)
        }
    }
    
    func  setRound(withBorderColor:UIColor=UIColor.clear, andCornerRadious:CGFloat = 0.0, borderWidth:CGFloat = 1.0)
    {
        if andCornerRadious==0.0
        {
            var frame:CGRect = self.frame;
            frame.size.height=min(self.frame.size.width, self.frame.size.height) ;
            frame.size.width=frame.size.height;
            self.frame=frame;
            self.layer.cornerRadius=self.layer.frame.size.width/2;
        }
        else
        {
            self.layer.cornerRadius=andCornerRadious;
        }
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true;
        self.layer.borderColor = withBorderColor.cgColor
        
    }
    
    func setShadow(shadowColor: CGColor = UIColor.gray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                   shadowOpacity: Float = 0.7,
                   shadowRadius: CGFloat = 5.0){
        
        self.layer.shadowColor = shadowColor;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowOpacity = shadowOpacity;
        self.layer.shadowRadius = shadowRadius;
        self.layer.masksToBounds = false;
        
    }
    
    
    
}

//MARK:- Label Extension
extension UILabel
{
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}


//MARK:- Application Extension
extension UIApplication
{
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}




//MARK:- Scrollview Extension
extension UIScrollView
{
    var currentPage: Int
    {
        let currentOffset = self.contentOffset.x
        let width = self.frame.size.width
        let currentPosition = Int((currentOffset + (0.5 * width)) / width)
        return currentPosition
    }
    
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}

extension UITabBar
{
    func addTabBarItem(title: String, imageName: String, selectedImageName: String, tagIndex: Int) -> UITabBarItem {
        let item = UITabBarItem(title: title,
                                image: UIImage(named: imageName),
                                selectedImage: UIImage(named: selectedImageName))
        item.titlePositionAdjustment = UIOffset(horizontal:0, vertical:-10)
        item.tag = tagIndex
        return item
    }
    // Workaround for iOS 11's new UITabBar behavior where on iPad, the UITabBar inside
    // the Master view controller shows the UITabBarItem icon next to the text
    override open var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        
        return super.traitCollection
    }
}
