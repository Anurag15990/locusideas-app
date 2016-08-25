//
//  EditProfileViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 25/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

var userUpdatedNotification = "UserUpdated"

class EditProfileViewController: UIViewController, ImageUploadDelegate {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var profilePicOverlayView: UIView!
    
    var viewModel: EditProfileViewModel!
    
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        self.viewModel = EditProfileViewModel()
        self.initialSetup()
        self.setupGestureRecognizers()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        
        self.picker.delegate = self
        self.profilePicOverlayView.hidden = true
        self.activityIndicatorView.hidden = true
        
        firstNameTextField.text = viewModel.fetchFirstName()
        lastNameTextField.text = viewModel.fetchLastName()
        mobileNumberTextField.text = viewModel.fetchPhoneNumber()
        
        if let profilePictureUrl = viewModel.fetchProfilePictureUrl() {
            profilePictureImageView.kf_setImageWithURL(NSURL(string: profilePictureUrl), placeholderImage: UIImage(named: "UserAvatarImg"))
        }
    }
    
    func setupGestureRecognizers() {
        
        self.profilePictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.showImagePickerOptions)))
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(EditProfileViewController.backButtonPressed(_:)))
        self.title = "Edit Profile."
        
        let nextLabel = UIButton(frame: CGRectMake(0, 0, 50, 50))
        nextLabel.titleLabel!.font = UIFont(name: "MaterialDesignIcons", size: 25)
        nextLabel.setTitle("", forState: .Normal)
        nextLabel.addTarget(self, action: #selector(EditProfileViewController.updateUser), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextLabel)
    }
    
    
    @IBAction func editProfilePicture() {
        self.showImagePickerOptions()
    }
    
    func showImagePickerOptions() {
        let actionSheet =  UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                self.picker.sourceType = UIImagePickerControllerSourceType.Camera
                self.picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                self.picker.allowsEditing = true
                
                self.presentViewController(self.picker, animated: true, completion: nil)
            }else {
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Pick existing photo", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.picker.allowsEditing = true
            self.presentViewController(self.picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func updateUser() {
        
        if let firstName = firstNameTextField.text {
            self.viewModel.updateUserRequestBody.name?.firstName = firstName
        }
        
        if let lastName = lastNameTextField.text {
            self.viewModel.updateUserRequestBody.name?.lastName = lastName
        }
        
        if let mobileNumber = mobileNumberTextField.text {
            self.viewModel.updateUserRequestBody.phonePrimary?.subscriberNumber = mobileNumber
            self.viewModel.updateUserRequestBody.phonePrimary?.countryCode = "+91"
            self.viewModel.updateUserRequestBody.phonePrimary?.isVerified = false
         }
        
        self.viewModel.updateUser({ 
            
            NSNotificationCenter.defaultCenter().postNotificationName(userUpdatedNotification, object: nil)
            self.navigationController?.popViewControllerAnimated(true)
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.picker.dismissViewControllerAnimated(true, completion: nil)
        profilePictureImageView.image = image
        self.uploadUserProfilePicture(image)
    }
    
    func uploadUserProfilePicture(image: UIImage) {
        let imageUploadService = ImageUploadService()
        imageUploadService.delegate = self
        imageUploadService.uploadUserProfilePicture(image)
    }
    
    func onImageUploadStart() {
        self.profilePicOverlayView.hidden = false
        self.activityIndicatorView.hidden = false
        self.activityIndicatorView.startAnimating()
    }
    
    func onImageUploadEnd() {
        AsyncUtils.runOnMainThread { 
            self.profilePicOverlayView.hidden = true
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden = true
        }
    }
        
}
