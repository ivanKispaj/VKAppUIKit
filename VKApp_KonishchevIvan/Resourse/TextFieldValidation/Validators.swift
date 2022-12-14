//
//  Validators.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.02.2022.
//

import UIKit

class Validators {

    static func isEmailValidate( email: String?) -> Bool{
        guard let email = email,
                  email != "" else {
                  return false
              }
        return true
    }
    
    static func isPasswordValidate( password: String?) -> Bool{
        guard let password = password,
                  password != "",
                  password.count > 8 else {
                  return false
              }
        return true
    }
    static func isConfirmPassValidate( confirmPassword: String?, password: String?) -> Bool{
        guard let confirmPassword = confirmPassword,
              let password = password,
              confirmPassword == password,
                  confirmPassword != "" else {
                  return false
              }
        return true
    }
   
    static func isSimpleEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
      let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
    static func issimplePass(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return checkPass(text: password, regEx: passRegEx)
    }
    private static func checkPass(text: String, regEx: String) -> Bool {
      let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}

