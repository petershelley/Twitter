//
//  TweetViewController.swift
//  Twitter
//
//  Created by Peter Shelley on 11/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tweetTextView: UITextView!
    @IBOutlet var charCounter: UILabel!
    var charsRemaining: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        charCounter.text = "\(charsRemaining ?? 280) characters remaining"
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func updateCharCounter() {
        charsRemaining = 280 - tweetTextView.text.count
        if (charsRemaining <= 20) {
            charCounter.textColor = UIColor.red
        } else {
            charCounter.textColor = UIColor.black
        }
        charCounter.text = "\(charsRemaining ?? 280) characters remaining"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCharCounter()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 281
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count < characterLimit
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
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
