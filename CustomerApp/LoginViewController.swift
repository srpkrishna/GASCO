//
//  LoginViewController.swift
//  CustomerApp
//
//  Created by Ashok on 5/9/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginIdTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var loginSuperView: UIView!
    let loader = LoadingScreen.init();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginBackgroundColor = UIColor(red: 0.051, green: 0.392, blue: 0.694, alpha: 1.00)
        let textViewColor = UIColor(red: 0.157, green: 0.690, blue: 0.898, alpha: 1.00)
        
        //LoginSuperView
        loginSuperView.backgroundColor = loginBackgroundColor
        
        //TextView
        loginIdTextView.delegate = self
        loginIdTextView.attributedPlaceholder = NSAttributedString(string: "Login Id", attributes: [NSForegroundColorAttributeName : textViewColor])
        loginIdTextView.textColor = textViewColor
        loginIdTextView.tag = 11
        
        passwordTextView.delegate = self
        passwordTextView.attributedPlaceholder =  NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : textViewColor])
        passwordTextView.textColor = textViewColor
        passwordTextView.tag = 12
        
        //Login Button
        loginButton.layer.cornerRadius = 10
        
        let dismissKeyBoard = UITapGestureRecognizer(target: self, action: "dismissKeyBoardOnTapofView:")
        self.view.addGestureRecognizer(dismissKeyBoard)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
       animateViewMoving(true, moveValue: 125)
        if textField.tag == 11 {
            loginIdTextView.textColor = UIColor.whiteColor()
        }
        else {
            passwordTextView.textColor = UIColor.whiteColor()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 125)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    func dismissKeyBoardOnTapofView(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    @IBAction func validateLogin(sender: UIButton) {
        
        
        print("loginIdTextView = \(loginIdTextView.text!)")
        print("passwordTextView = \(passwordTextView.text!)")
        
        let reportURL = m2API.handShakeURL(loginIdTextView.text!);
        let request = NSMutableURLRequest(URL: reportURL)
        request.HTTPMethod = "GET";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let serverCall = HttpCall.init();
        loader.showLoading();
        serverCall.getData(request){(data,error) -> Void in
            
            
            if(error != "")
            {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loader.hideLoading()
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                })
                return
            }
            
            var jsonDict:NSMutableDictionary?
            
            do
            {
                jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? NSMutableDictionary
                
                if let isAuthenticated = jsonDict!["authenticated"] as? String
                {
                    if(isAuthenticated.caseInsensitiveCompare("yes") == NSComparisonResult.OrderedSame)
                    {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.loader.hideLoading()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let myController   = storyboard.instantiateViewControllerWithIdentifier("EntryNavigationBar")
                            self.presentViewController(myController, animated: true, completion: nil)
                         })
                        
                    }else
                    {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.loader.hideLoading()
                            let alert = UIAlertController(title: "Alert", message: "Authentication failed. Please check your credentials", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        })
                        
                    }
                
                }
                
                
            }
            catch let error as NSError {
                // error handling
                NSLog("error %@", error.description);
            }
            
            
        };
        

    
    }
}
