//
//  ViewController.swift
//  ParseCustomLogin
//
//  Created by Christopher Page on 5/3/15.
//  Copyright (c) 2015 Christopher Page. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseTwitterUtils

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //        let testObject = PFObject(className: "TestObject")
    //        testObject["foo"] = "bar"
    //        testObject["foo2"] = "bar2"
    //        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
    //            println("Object has been saved.")
    //        }

  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    //self.view.backgroundColor = UIColor.blueColor()
    //self.view.backgroundColor = UIColor.darkGrayColor()
    if (PFUser.currentUser() == nil) {
      let logInViewController = LoginViewController()
      logInViewController.delegate = self
      let signUpViewController = SignupViewController()
      signUpViewController.delegate = self
      
      logInViewController.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.PasswordForgotten, PFLogInFields.SignUpButton, PFLogInFields.Twitter, PFLogInFields.Facebook]
      //logInViewController.emailAsUsername = true
      
      logInViewController.signUpController = signUpViewController

      self.presentViewController(logInViewController, animated: true, completion: nil)
    } else {
      self.performSegueWithIdentifier("tabBar", sender: self)
    }
  }
  
//  override func viewDidLayoutSubviews() {
//    println("didLaoutSubView")
//    self.logInView.logInButton.setTitle("Test", forState: UIControlState.Normal)
//    self.logInView.logInButton.setTitle("Test", forState: UIControlState.Highlighted)
//  }
  
  func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
    if (!username.isEmpty && !password.isEmpty) {
      return true
    }else {
      return false
    }    
  }
  
  func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
    print("User logged in!", PFUser.currentUser())
    
    if (PFTwitterUtils.isLinkedWithUser(user)) {
      let twitterUsername = PFTwitterUtils.twitter()?.screenName
      PFUser.currentUser()?.username = twitterUsername
      PFUser.currentUser()?.saveEventually(nil)
    }

    self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
//  func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
//    if (error != nil) {
//      print("Something broke", error)
//    }
//  }
  
  func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
    
    if (PFTwitterUtils.isLinkedWithUser(user)) {
      let twitterUsername = PFTwitterUtils.twitter()?.screenName
      PFUser.currentUser()?.username = twitterUsername
      PFUser.currentUser()?.saveEventually(nil)
    }
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
    if (error != nil) {
      print("Failed to sign up!", error)
    }
  }
  
  func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
    print("User dismissed sign-up")
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func logoutAction(sender: AnyObject) {
    //PFUser.logOut()
    print("hello?")
    print(PFUser.currentUser())
    //self.presentViewController(self.logInViewController, animated: true, completion: nil)
  }
  
}

