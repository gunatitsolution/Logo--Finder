//
//  initialVC.swift
//  LogoFInder
//
//  Created by Janki on 06/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import UIKit

class initialVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startBtn.clipsToBounds = true
       // startBtn.layer.cornerRadius = self.startBtn.frame.width / 2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
