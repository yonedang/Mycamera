//
//  ViewController.swift
//  Mycamera
//
//  Created by 米田 央 on 2017/06/10.
//  Copyright © 2017年 Swift-Yoneda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBOutlet weak var pictureImage: UIImageView!
  
  @IBAction func cameraButtonAction(_ sender: Any) {
    
    // 「.actionSheet」は下から表示するダイアログ
    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action:UIAlertAction) in
        let ipc: UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .camera
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(cameraAction)
    }
    
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {(action:UIAlertAction) in
        let ipc: UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(photoLibraryAction)
    }
    

    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    alertController.popoverPresentationController?.sourceView = view
    
    present(alertController, animated: true, completion: nil)
    
    
  }
  
  @IBAction func SNSButtonAction(_ sender: Any) {
    
    // アンラップ
    if let shareImage = pictureImage.image{
      
      let shareItems = [shareImage]
      
      let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
      
      
      // iPad用の処理
      controller.popoverPresentationController?.sourceView = view
      
      present(controller, animated: true, completion: nil)
      // 「UIActivityViewController」はdismissなし
    }
  }
  
  
  // 撮影終了後に呼び出されるdelegateメソッド
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    // 撮影した画像をpictureImageに設定
    // as? UIImageのところは、anyになっているところをUIImageにキャストしている
    captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    
    dismiss(animated: true, completion: {
      
      self.performSegue(withIdentifier: "showEffectView", sender: nil)
      
    })
  }
  
  var captureImage : UIImage?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // 設計的にEffectViewControllerは絶対あるので「as!」　強制アンラップ
    let nextViewController = segue.destination as! EffectViewController
    
    nextViewController.originalImage = captureImage
    
  }
  
  


}

