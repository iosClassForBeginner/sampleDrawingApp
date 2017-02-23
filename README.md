# 第16回: １時間でiPhoneアプリを作ろう
## お絵描きアプリ

  <div style="text-align:center"><img src ="https://github.com/iosClassForBeginner/sampleDrawingApp/blob/master/Assets/sample.jpg" /></div>
  
  当アカウントへ訪れていただき、誠にありがとうございます。第16回アプリ教室では、お絵描きアプリを作ります。自分のペースで勉強したい、勉強前に予習したい、内容を復習したい場合、ご利用ください。
  
## アプリ教室に興味ある方、歓迎します。  
  Meetup  
  http://www.meetup.com/ios-dev-in-namba/
  
## 別途アプリ教室(有料)も開いております  
  http://learning-ios-dev.esy.es/  

## 問い合わせ
  株式会社ジーライブ
  http://geelive-inc.com  

## アプリ作成手順

#### 0, 開発準備
> 0-1. xcodeで新規プロジェクトを立ち上げる
![image](https://github.com/iosClassForBeginner/sampleDrawingApp/blob/master/Assets/create_new_project.gif)

#### 1, Storyboardで、アプリのデザイン
> 1-1. main.storyboardを選択し、UI部品からUIImageViewを配置します。(ドラッグ&ドロップ)
![image](https://github.com/iosClassForBeginner/sampleDrawingApp/blob/master/Assets/set_imageview.gif)

> 1-2. StoryboardのUIImageViewを、ViewController.swiftに紐づけます（control押しながらドラッグ）
![image](https://github.com/iosClassForBeginner/sampleDrawingApp/blob/master/Assets/tying_imageview.gif)

#### 2, ViewController.swiftにコード記述
- 以下コードブロックを記入
  
```Swift
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
```
