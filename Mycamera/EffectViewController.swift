//
//  EffectViewController.swift
//  Mycamera
//
//  Created by 米田 央 on 2017/06/10.
//  Copyright © 2017年 Swift-Yoneda. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      effectImage.image = originalImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  @IBOutlet weak var effectImage: UIImageView!
  
  var originalImage : UIImage?
  
  @IBAction func effectButtonAction(_ sender: Any) {
    
    let filterName = "CIPhotoEffectMono"
    
    // オプショナルチェイニング
    let rotate = originalImage!.imageOrientation
    
    let inputImage = CIImage(image: originalImage!)
    
    
    // -------------------ここを繰り返せば、たくさんフィルター設定できる
    
    let effectFilter = CIFilter(name: filterName)!
    
    // デフォルトのパラメータ設定　重要
    effectFilter.setDefaults()
    
    effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
    
    let outputImage = effectFilter.outputImage
    
    // -------------------ここまで
    
    
    let ciContext = CIContext(options: nil)
    
    let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
    
    effectImage.image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: rotate)
    
    
    
    
    
  }
  
  @IBAction func shareButtonAction(_ sender: Any) {
    
    let controller = UIActivityViewController(activityItems: [effectImage.image!], applicationActivities: nil)
    
    controller.popoverPresentationController?.sourceView = view
    
    present(controller, animated: true, completion: nil)
  }
  
  @IBAction func closeButtonAction(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
  

}
