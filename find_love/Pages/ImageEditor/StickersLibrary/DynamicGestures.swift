import UIKit

public protocol DynamicStickersGestures {
    func registerPanGestureFor(sticker: UIView)
    func registerPinchGestureFor(sticker: UIView)
    func registerRotationGestureFor(sticker: UIView)
}

extension UIViewController: DynamicStickersGestures, UIGestureRecognizerDelegate{
    public func registerPanGestureFor(sticker: UIView) {
        sticker.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self
        
        sticker.addGestureRecognizer(panGesture)
    }
    
    
    public func registerPinchGestureFor(sticker: UIView) {
        sticker.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        pinchGesture.delegate = self
        sticker.addGestureRecognizer(pinchGesture)
    }
    
    
    public func registerRotationGestureFor(sticker: UIView) {
        sticker.isUserInteractionEnabled = true
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture))
        rotationGesture.delegate = self
        sticker.addGestureRecognizer(rotationGesture)
    }
    
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(CGPoint.zero, in: view)
        
        guard let sticker = panGesture.view else { return }
        sticker.center = CGPoint(x: sticker.center.x + translation.x,
                                 y: sticker.center.y + translation.y)
    }
    
    
    @objc func handlePinchGesture(_ pinchGesture: UIPinchGestureRecognizer) {
        guard let sticker = pinchGesture.view else { return }
        
        sticker.transform = view.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale)
    }
    
    @objc func handleRotationGesture(_ rotationGesture: UIRotationGestureRecognizer) {
        guard let sticker = rotationGesture.view else { return }
        
        sticker.transform = sticker.transform.rotated(by: rotationGesture.rotation)
        rotationGesture.rotation = 0
    }
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
