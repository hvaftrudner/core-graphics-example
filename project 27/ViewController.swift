//
//  ViewController.swift
//  project 27
//
//  Created by Kristoffer Eriksson on 2020-11-22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 8 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawStarEmoji()
        case 7:
            drawEmojiFace()
        case 8:
            drawText()
        default:
            break
        }
    }
    
    func drawRectangle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            //linewidth is half inside and half outside
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    func drawCircle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            //.insetby helps with overlap
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            //linewidth is half inside and half outside
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    func drawCheckerBoard(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        imageView.image = image
    }
    func drawRotatedSquares(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            //sets originpoint to be middle of image
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations{
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
    func drawLines(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length : CGFloat = 256
            
            for _ in 0..<256 {
                ctx.cgContext.rotate(by: .pi / 2)
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
    func drawImagesAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs : [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle,
            ]
            
            let string = "the best-laid schemes o\n Mice an' Men aft agley"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
            
        }
        imageView.image = image
    }
    func drawStarEmoji(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            // let angle = 72
            // let drawLineAngle = 45
            //let top = 256
            //let bottom = 0
        
            var first = true
            for _ in 0...4{
                if first{
                    //x: 93 is a magic number
//
                    ctx.cgContext.move(to: CGPoint(x: 0, y: 256))
                    ctx.cgContext.addLine(to: CGPoint(x: -93, y: 128))
                    ctx.cgContext.move(to: CGPoint(x: 0, y: 256))
                    ctx.cgContext.addLine(to: CGPoint(x: 93, y: 128))
                   
                    first = false
                } else {
                    // set the angle
                    ctx.cgContext.rotate(by: .pi / 2.5)
                    
                    ctx.cgContext.move(to: CGPoint(x: 0, y: 256))
                    ctx.cgContext.addLine(to: CGPoint(x: -93, y: 128))
                    ctx.cgContext.move(to: CGPoint(x: 0, y: 256))
                    ctx.cgContext.addLine(to: CGPoint(x: 93, y: 128))
                    
                }
            }
            
            ctx.cgContext.closePath()
            
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            
            ctx.cgContext.setLineJoin(.round)
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    func drawEmojiFace(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            let width = 512
            let height = 512
            
            // make body
            let bodyRect = CGRect(x: 0, y: 0, width: width, height: height).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            
            // make eyes
            // do them in there own methods to accomplish better customization
            let eyeOneRect = CGRect(x: 128, y:  128, width: 50, height: 50).insetBy(dx: 5, dy: 5)
            
            let eyeTwoRect = CGRect(x: 256 + 66 , y: 128, width: 50, height: 50).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.addEllipse(in: bodyRect)
            ctx.cgContext.addEllipse(in: eyeOneRect)
            ctx.cgContext.addEllipse(in: eyeTwoRect)
            
            ctx.cgContext.setShadow(offset: CGSize(width: 5, height: 5), blur: 4)
            
            ctx.cgContext.move(to: CGPoint(x: 256 + 128, y: 256 ))
            //ctx.cgContext.addLine(to: CGPoint(x: 128, y: 256 + (128 / 2)))
            ctx.cgContext.addCurve(to: CGPoint(x: 128, y: 256 ), control1: CGPoint(x: 300, y: 350), control2: CGPoint(x: 200, y: 350))
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            //linewidth is half inside and half outside
            ctx.cgContext.setLineWidth(10)
        
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image
    }
    
    func drawText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            //graphics code
            ctx.cgContext.translateBy(x: 0, y: 100)
            
            //write T
            ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 0))
            ctx.cgContext.move(to: CGPoint(x: 50, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 100))
            
            //write W
            ctx.cgContext.move(to: CGPoint(x: 120, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 160, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 180, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 160, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 180, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 240, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 100))
            
            //write I
            ctx.cgContext.move(to: CGPoint(x: 280, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 280, y: 100))
            
            //write N
            ctx.cgContext.move(to: CGPoint(x: 320, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 320, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 320, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 360, y: 100))
            ctx.cgContext.move(to: CGPoint(x: 360, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 360, y: 100))
            
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            ctx.cgContext.setLineJoin(.round)
            ctx.cgContext.setLineCap(.round)
            
            //ctx.cgContext.drawPath(using: .fillStroke)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
}

