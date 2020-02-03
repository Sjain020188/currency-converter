//
//  CurrencyData.swift
//  currency-conveter
//
//  Created by Shruti Jain on 2020/01/28.
//  Copyright © 2020 Shruti Jain. All rights reserved.
//

import Foundation

struct CurrencyData: Decodable {
    let date: String;
    let rates: [String: Float];
    let base: String;

}
