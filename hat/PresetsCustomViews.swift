//
//  PreCustomViews.swift
//  tabAppProject
//
//  Created by Alisa Potapova on 29.03.2021.
//  Copyright © 2021 Alisa Potapova. All rights reserved.
//

import UIKit


class CustomButton : UIButton {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        self.setTitleColor(UIColor.red, for: .normal)
        self.backgroundColor = UIColor.green
    }

    func setConstraints() {
    }

}

class CustomPicker: UIPickerView {
     override init(frame: CGRect) {
        super.init(frame: frame)
           setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
    }
       
    func setAttributes() {
        backgroundColor = .clear
        //layer.borderColor = UIColor.blue.cgColor
        //layer.borderWidth = 1.0
        //layer.cornerRadius = 7.0
        layer.masksToBounds = true
        setValue(UIColor.red, forKeyPath: "textColor")
    }
}


class ButtonWithTapAround : UIButton {
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // bound around plus 50 pt:
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            return bounds.insetBy(dx: -50, dy: -50).contains(point)
        }
}



/*
class CustomSwitch1 : UISwitch {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        tintColor = deleteColor
        layer.cornerRadius = self.frame.height / 2
        backgroundColor = deleteColor
        self.onTintColor = UIColor.yellow
    }

    func setConstraints() {
    }

}
class CustomStepper1 : UIStepper {

    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        self.tintColor = deleteColor
        //self.setDecrementImage(allImages["prevButton"], for: .normal)
        //self.setIncrementImage(allImages["nextButton"], for: .normal)
        self.backgroundColor = UIColor.yellow
    }

    func setConstraints() {
    }

}
*/


class ButtonWithRoundedCorners: UIButton {
   init() {
       super.init(frame: CGRect.zero)
       setAttributes()
   }
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
   }
   func setAttributes() {
        layer.borderWidth = 0
        layer.cornerRadius = 7
        clipsToBounds = true
   }
}

class ViewWithCornerRadius: UIView{
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
          
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setAttributes() {
        layer.cornerRadius = 25
        clipsToBounds = true
    }
}

class ViewWithRect: UIView{
    
    var color: UIColor = .red
    var cornerRadius: CGFloat = 0.0
    
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
    }
    
    init(frame: CGRect, color: UIColor, cornerRadius: CGFloat) {
        super.init(frame: frame)
        self.color = color
        self.cornerRadius = cornerRadius
        setAttributes()
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setAttributes() {
        backgroundColor = color
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    
}

class ViewWithGradient: UIView{
    
    var gradient = CAGradientLayer()

    init() {
        super.init(frame: CGRect.zero)
    }
          
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        gradient.frame = self.bounds
        layer.cornerRadius = 15
    }

    func setupGradient(withColors: [CGColor]) {
        gradient.colors = withColors
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)

    }
    
    
}

class TextViewNoBorders: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
          
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setAttributes() {
        layer.borderColor = backgroundColor?.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}

class TextFieldNoBorders: UITextField {
    
    var tintedClearImage: UIImage?


    override func layoutSubviews() {
            super.layoutSubviews()
            self.tintClearImage()
    }

    private func tintClearImage() {
            for view in subviews {
                if view is UIButton {
                    let button = view as! UIButton
                    if let image = button.image(for: .highlighted) {
                        if self.tintedClearImage == nil {
                            tintedClearImage = self.tintImage(image: image, color: self.tintColor)
                        }
                        button.setImage(self.tintedClearImage, for: .normal)
                        button.setImage(self.tintedClearImage, for: .highlighted)
                    }
                }
            }
        }

    private func tintImage(image: UIImage, color: UIColor) -> UIImage {
            let size = image.size

            UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
            let context = UIGraphicsGetCurrentContext()
            image.draw(at: .zero, blendMode: CGBlendMode.normal, alpha: 1.0)

            context?.setFillColor(color.cgColor)
            context?.setBlendMode(CGBlendMode.sourceIn)
            context?.setAlpha(1.0)

            let rect = CGRect(x: CGPoint.zero.x, y: CGPoint.zero.y, width: image.size.width, height: image.size.height)
            UIGraphicsGetCurrentContext()?.fill(rect)
            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return tintedImage ?? UIImage()
        }
    
    
    init() {
        super.init(frame: CGRect.zero)
        setAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setAttributes() {
        layer.borderColor = backgroundColor?.cgColor
        //layer.borderWidth = 2.0
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}


extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, above: self.layer)
    }
}
