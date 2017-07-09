//
//  ViewController.swift
//  TestFieldMove
//
//  Created by yuki.pro on 2017. 7. 9..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    /** 키보드 높이를 구해서 옮기는 방법 **/
    // 오토레이아웃 조건
    @IBOutlet weak var loginViewCenterYLayoutConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 키보드 옵저버 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillShowOrHide(notification:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        
        // 키보드 옵저버 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillShowOrHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 키보드 옵저버 해제
        NotificationCenter.default.removeObserver(
            self,
            name: .UIKeyboardWillShow,
            object: nil
        )
        
        // 키보드 옵저버 해제
        NotificationCenter.default.removeObserver(
            self,
            name: .UIKeyboardWillHide,
            object: nil
        )
    }
    

    
    func keyboardWillShowOrHide(notification: Notification) {
        // 아래쪽 텍스트필드를 편집하는 경우만 스크롤
        if TextField.isEditing {
            
            guard let userInfo = notification.userInfo else {
                return
            }
            // 키보드 높이 = 키보드 없는 전체 뷰의 높이 - 키보드 있는 경우의 뷰의 높이
            let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            // 키보드 높이 만큼 제약 조건 값 수정
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.loginViewCenterYLayoutConstraint.constant = (self.view.bounds.maxY - self.view.window!.convert(frameEnd, to: self.view).minY)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
    }

    
    
    /** 키보드 높이 관계없이 무조건 250픽셀 올리기
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
     
**/
    
    
    /** 키보드 높이만 구하기
     
     @IBOutlet weak var loginViewCenterYLayoutConstraint: NSLayoutConstraint!
     
     override func viewWillAppear(_ animated: Bool) {
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
     }
     
     func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        let keyboardHeight = keyboardSize.height
        print(keyboardHeight)
        }
     }
 **/
 
    // 리턴키로 키보드 숨김
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

