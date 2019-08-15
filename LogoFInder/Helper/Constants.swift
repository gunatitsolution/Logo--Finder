//
//  Constants.swift
//  LogoFInder
//
//  Created by Janki on 04/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import Foundation
import UIKit

let  APPDELEGATE =  UIApplication.shared.delegate as! AppDelegate
struct DialogTags {
    static let networkDialog:Int = 400
}
struct  Webservice {
    static let baseUrl = "https://autocomplete.clearbit.com/v1/companies/suggest"
}
struct PARAMS {
    static let query = "query"
}
