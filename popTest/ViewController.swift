//
//  ViewController.swift
//  popTest
//
//  Created by heyunpeng on 16/3/30.
//  Copyright © 2016年 heyunpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sprintImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureSprint = UITapGestureRecognizer(target: self, action: #selector(ViewController.changeSize(_:)))
        sprintImage.addGestureRecognizer(gestureSprint)
        sprintImage.userInteractionEnabled = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveSpring() {
        
        let spring = POPDecayAnimation(propertyNamed: kPOPLayerPositionX)
        spring.velocity = CGFloat(100.0)
        spring.delegate = self
        
        self.sprintImage.pop_addAnimation(spring, forKey: "changeposition")
    }
    
    @IBAction func alphaSpring() {
        
        let spring = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        if (self.sprintImage.alpha > 0.0) {
            spring.fromValue = CGFloat(1.0)
            spring.toValue = CGFloat(0.0)
        } else {
            spring.fromValue = CGFloat(0.0)
            spring.toValue = CGFloat(1.0)
        }

        self.sprintImage.pop_addAnimation(spring, forKey: "changealpha")
    }
    
    @IBAction func colorSpring() {
        
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerBackgroundColor)
        spring.toValue = UIColor.redColor()
        
        spring.springBounciness = 10.0
        spring.springSpeed = 10.0
        
        self.sprintImage.layer.pop_addAnimation(spring, forKey: "changecolor")
    }
    
    @objc private func changeSize(tap: UIGestureRecognizer) -> Void {
        
        let spring = POPSpringAnimation(propertyNamed: kPOPLayerSize)
        
        if (self.sprintImage.frame.size.width == 300) {
            spring.toValue = NSValue(CGSize: CGSize(width: 100, height: 100))
        } else {
            spring.toValue = NSValue(CGSize: CGSize(width: 300, height: 300))
        }
        
        spring.springBounciness = 20.0
        spring.springSpeed = 20.0
        
        self.sprintImage.pop_addAnimation(spring, forKey: "changesize")
    }
    
    @IBAction func customSpring() {
        
        let spring = POPCustomAnimation { (target, animation) -> Bool in
            if let obj = target as? UIImageView {
                var frame = obj.frame
                if frame.origin.x < 100 {
                    frame.origin.x += 1
                    obj.frame = frame
                    return true
                }
            }
            
            return false
        }
        
        spring.delegate = self
        self.sprintImage.pop_addAnimation(spring, forKey: "customanimation")
    }
}

extension ViewController: POPAnimationDelegate{
    func pop_animationDidStart(anim: POPAnimation) -> Void {
        print("animation start")
    }
    
    func pop_animationDidStop(anim: POPAnimation, finished: Bool) -> Void {
        
        print("animation stop")
    }
    
    func pop_animationDidReachToValue(anim: POPAnimation) -> Void {
        
    }
}

