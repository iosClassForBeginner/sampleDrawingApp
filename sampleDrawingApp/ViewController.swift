//
//  ViewController.swift
//  sampleDrawingApp
//
//  Created by Muneharu Onoue on 2017/02/23.
//  Copyright © 2017年 Muneharu Onoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var saveImage:UIImage!
    var bzPath: UIBezierPath!
    @IBOutlet weak var canvas: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // タッチ開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: canvas)
        bzPath = UIBezierPath()
        bzPath.lineWidth = 2
        bzPath.move(to: touchPoint)
    }
    
    // ドラッグ中
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bzPath == nil {
            return
        }
        let touch = touches.first!
        let touchPoint = touch.location(in: canvas)
        bzPath.addLine(to: touchPoint)
        drawLine(path: bzPath)
    }
    
    // タッチ終了
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bzPath == nil {
            return
        }
        let touch = touches.first!
        let touchPoint = touch.location(in: canvas)
        bzPath.addLine(to: touchPoint)
        drawLine(path: bzPath)
        saveImage = canvas.image
    }
    
    func drawLine(path:UIBezierPath){
        UIGraphicsBeginImageContext(canvas.frame.size)
        if saveImage != nil {
            saveImage.draw(at: CGPoint.zero)
        }
        
        // 色の設定
        let lineColor = UIColor.black
        lineColor.setStroke()
        
        // 描写
        path.stroke()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }


}

