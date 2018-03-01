//
//  Roundbutton.swift
//  PsykAkuten
//
//  Created by Fanny Danielsson on 2017-12-12.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import UIKit
@IBDesignable

class Roundbutton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWith
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
