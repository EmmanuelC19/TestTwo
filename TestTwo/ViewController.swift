//
//  ViewController.swift
//  TestTwo
//
//  Created by Emmanuel Casañas Cruz on 10/3/16.
//  Copyright © 2016 Emmanuel Casañas Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var passwordStrongLevel: UILabel!
	
	let numberCharacters = NSCharacterSet.decimalDigits
	let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
	let upperCharacters = NSCharacterSet.uppercaseLetters
	let lowerCharacters = NSCharacterSet.lowercaseLetters
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func clickSignUp(_ sender: UIButton) {
		
		let email = emailTextField.text ?? ""
		let password = passwordTextField.text ?? ""
		
		if EmailValidationHelper.isValidEmail(email: email) && isValidPassword(password: password)  {
			print("Email Valido")
			performSegue(withIdentifier: "goToDashboard", sender: nil)
		} else {
			showAlertOneButtonWithStatus(title: "Error", message: "Please write a valid email", buttonTitle: "OK")
		}
	}
	
	func isValidPassword (password : String) -> Bool {
		
		if password.characters.count >= 8 {
			if password.rangeOfCharacter(from: numberCharacters) != nil{
				if password.rangeOfCharacter(from: characterset.inverted) != nil {
					return true
				} else {
					showAlertOneButtonWithStatus(title: "Error", message: "The password must contain a special character", buttonTitle: "OK")
					return false
				}
			} else {
				showAlertOneButtonWithStatus(title: "Error", message: "The password must contain at least 1 numeric character", buttonTitle: "OK")
				return false
			}
		} else {
			showAlertOneButtonWithStatus(title: "Error", message: "The password must contains at least 8 characters", buttonTitle: "OK")
			return false
		}
	}
	
	func calculateScore( password : String ) -> Int {
		var score = 0
	
	// NUMBER_CLASS is a constant char array { '0', '1', '2', ... }
		if password.rangeOfCharacter(from: numberCharacters) != nil{
			score += 2
		}
		if password.rangeOfCharacter(from: characterset.inverted) != nil {
			score += 2
		}
		if password.rangeOfCharacter(from: upperCharacters) != nil{
			score += 2
		}
		
		if password.rangeOfCharacter(from: lowerCharacters) != nil{
			score += 2
		}
		
		if password.characters.count > 5 {
			score += 2
		}
		
	return score
	
	}
	
	func showPasswordStrength () {
		let password = passwordTextField.text ?? ""
		
		passwordStrongLevel.isHidden = false
		
		if password.characters.count == 0 {
				passwordStrongLevel.isHidden = true
		
		} else if calculateScore(password: password) <= 4 {
			passwordStrongLevel.textColor = UIColor.red
			passwordStrongLevel.text = "Weak Password Security"
		} else if calculateScore(password: password) > 4 && calculateScore(password: password) < 8 {
			passwordStrongLevel.textColor = UIColor.yellow
			passwordStrongLevel.text = "Medium Password Security"
		} else if calculateScore(password: password) > 7{
			passwordStrongLevel.textColor = UIColor.green
			passwordStrongLevel.text = "Strong Password Security"
		}
	}
	
	func saveToCoreData () {
		
		let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
		
		let userData = UserInfo(context: context)
		
		
		// Save the date to core Data
		(UIApplication.shared.delegate as!AppDelegate).saveContext()
		
	}
	
	
	func showAlertOneButtonWithStatus(title: String, message: String, buttonTitle: String ) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		if textField == passwordTextField{
			showPasswordStrength()
		}
		
		return true
	}
	
	
	
}

