//
//  EmailValidationHelper.swift
//  TestTwo
//
//  Created by Emmanuel Casañas Cruz on 10/3/16.
//  Copyright © 2016 Emmanuel Casañas Cruz. All rights reserved.
//

import Foundation

class EmailValidationHelper {
	
	class func isValidEmail(email: String) -> Bool{
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: email)
	}
}
