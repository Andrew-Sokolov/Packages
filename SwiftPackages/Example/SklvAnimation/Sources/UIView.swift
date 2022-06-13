//
//  SklvAnimation
//
//  Copyright (c) 2022-Present Andrew Sokolov (sklv.org)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

extension UIView {
    
    // Transition
    
    public func addTransition(type: CATransitionType, subtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = .animation
        transition.type = type
        transition.subtype = subtype
        
        layer.add(transition, forKey: "Transition")
    }
    
}

extension UIView {
    
    // Shake
    
    public func shake(halfCompletion: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {
        let duration: TimeInterval = .animation / 2
        let steps: [CGFloat] = [-50, 100, -80, 60, -40, 20, -10]
        
        let animations: () -> Void = {
            for (index, step) in steps.enumerated() {
                UIView.addKeyframe(withRelativeStartTime: TimeInterval(index) * duration, relativeDuration: duration) { [weak self] in
                    if index == steps.count / 2 { halfCompletion?() }
                    self?.frame.origin.x += step
                }
            }
        }
        
        UIView.animateKeyframes(withDuration: duration * TimeInterval(steps.count),
                                delay: .animation,
                                options: [],
                                animations: animations,
                                completion: completion)
    }
    
}

extension UIView {
    
    // Hide/Show
    
    public func hide(animated: Bool, completion: ((Bool) -> Void)? = nil) {
        isUserInteractionEnabled = false
        setAlpha(0, animated: animated, completion: completion)
    }
    
    public func show(animated: Bool, isUserInteractionEnabled: Bool = true, completion: ((Bool) -> Void)? = nil) {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        isHidden = false
        setAlpha(1, animated: animated, completion: completion)
    }
    
}

extension UIView {
    
    // Alpha
    
    public func setAlpha(_ alpha: CGFloat, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let animations: () -> Void = { [weak self] in
            self?.alpha = alpha
        }
        
        UIView.animate(instantly: !animated, animations: animations, completion: completion)
    }
    
}

extension UIView {
    
    // Color
    
    public func setTintColor(_ color: UIColor, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let animations: () -> Void = { [weak self] in
            self?.tintColor = color
        }
        
        UIView.animate(instantly: !animated, animations: animations, completion: completion)
    }
    
    public func setBackgroundColor(_ color: UIColor, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let animations: () -> Void = { [weak self] in
            self?.backgroundColor = color
        }
        
        UIView.animate(instantly: !animated, animations: animations, completion: completion)
    }
    
}

extension UIView {
    
    // Animate
    
    public static func animate(instantly: Bool, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: instantly ? 0 : .animation,
                       delay: 0,
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }
    
}
