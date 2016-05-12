
import UIKit

class ImplementActionVC: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var actionApprovalBY: UITextField!
    @IBOutlet weak var actionOwner: UITextField!
    @IBOutlet weak var actionStartDate: UITextField!
    @IBOutlet weak var actionDueDate: UITextField!
    @IBOutlet weak var originalActionDueDate: UITextField!
    @IBOutlet weak var priority: UITextField!
    
    @IBOutlet weak var actionDescriptionTextView: UITextView!
    @IBOutlet weak var workDoneTextView: UITextView!
    @IBOutlet weak var results: UITextView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var sendForApproval: UILabel!
    @IBOutlet weak var sendForReview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        customizeTextField(actionApprovalBY, canEdit: false)
        customizeTextField(actionOwner, canEdit: false)
        customizeTextField(actionStartDate, canEdit: false)
        customizeTextField(actionDueDate, canEdit: false)
        customizeTextField(originalActionDueDate, canEdit: false)
        customizeTextField(priority, canEdit: false)

        //TextView Customization
        customizeTextView(actionDescriptionTextView, canEdit: true, tag: 1000)
        customizeTextView(workDoneTextView, canEdit: true, tag: 1001)
        customizeTextView(results, canEdit: true, tag: 1002)
        customizeTextView(commentsTextView, canEdit: true, tag: 1003)
        
       //TabBar Customization
        let sendForApprovalTapGesture = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        addTapGestureForTabBar(sendForApprovalTapGesture, label: sendForApproval, tag: 39)
        
        let sendForReviewTapGesture = UITapGestureRecognizer(target: self, action: "didSelectActionItem:")
        addTapGestureForTabBar(sendForReviewTapGesture, label: sendForReview, tag: 40)
        
        //ScrollView
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        
        let dismissKeyBoard = UITapGestureRecognizer(target: self, action: "dismissKeyBoardOnTapofView:")
        self.view.addGestureRecognizer(dismissKeyBoard)
    }
    
    //TextField Customization
    func customizeTextField(textField: UITextField, canEdit: Bool){
        textField.placeholder = ""
        textField.userInteractionEnabled = canEdit
    }
    
    //TextView Customization
    func customizeTextView(textView: UITextView, canEdit: Bool, tag: Int){
        textView.delegate = self
        textView.layer.borderWidth = CGFloat(1.0)
        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.cornerRadius = CGFloat(5.0)
        textView.editable = canEdit
        textView.tag = tag
    }
    
    //TabBar Customization
    func addTapGestureForTabBar(tap: UITapGestureRecognizer, label: UILabel, tag: Int) {
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        label.userInteractionEnabled = true
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.tag = tag
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyBoardOnTapofView(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //UITextViewDelegate
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.tag == 1003 {
            animateViewMoving(true, moveValue: 100)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.tag == 1003 {
            animateViewMoving(false, moveValue: 100)
        }
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
    
    func didSelectActionItem(sender: UIGestureRecognizer) {
        
        //Action Code goes here
        
    }
    
    
}
