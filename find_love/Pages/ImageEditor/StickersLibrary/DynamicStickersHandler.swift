import UIKit

public protocol DynamicStickersHandler {
    func pushStickerAndRegisterGestures(
        rootImageView: UIImageView,
        sticker: UIImage,
        startingSize: CGRect,
        offsetFromCenter: CGPoint,
        panGesture: Bool,
        pinchGesture: Bool,
        rotationGesture: Bool,
        shouldBeSingleSticker: Bool,
        dashedBorder: Bool
    )
    
    func swapImage(sticker: UIImage)
    func clearStickers()
    func saveEditedImageFrom(rootImageView: UIView) -> UIImage?
}

fileprivate var _stickers = [UIImageView]()

public extension DynamicStickersHandler where Self: UIViewController {
    public func pushStickerAndRegisterGestures( rootImageView: UIImageView, sticker: UIImage,
                                                startingSize: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150),
                                                offsetFromCenter: CGPoint = CGPoint.zero, panGesture: Bool = true,
                                                pinchGesture: Bool = true, rotationGesture: Bool = true,
                                                shouldBeSingleSticker: Bool = false, dashedBorder: Bool = true) {
        if shouldBeSingleSticker && _stickers.count > 0 {
            fatalError("Adding more than one stickers")
        }
        
        let imageView = UIImageView(image: sticker)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = startingSize
        
        if dashedBorder {
            imageView.makeDashedBorder(color: UIColor.white, width: 6)
        }
        
        let position = CGPoint(x: imageView.center.x + offsetFromCenter.x,
                               y: imageView.center.y + offsetFromCenter.y)
        imageView.center = position
        
        _stickers.append(imageView)
        
        rootImageView.addSubview(imageView)
        rootImageView.bringSubview(toFront: imageView)
        rootImageView.isUserInteractionEnabled = true
        
        if panGesture {
            registerPanGestureFor(sticker: imageView)
        }
        
        if pinchGesture {
            registerPinchGestureFor(sticker: imageView)
        }
        
        if rotationGesture {
            registerRotationGestureFor(sticker: imageView)
        }
    }
    
    
    public func swapImage(sticker: UIImage) {
        if _stickers.isEmpty {
            fatalError("Sticker is not registered")
        }
        
        _stickers[0].image = sticker
    }
    
    
    public func clearStickers() {
        for sticker in _stickers {
            sticker.removeFromSuperview()
        }
        
        _stickers.removeAll()
    }
    
    
    public func saveEditedImageFrom(rootImageView: UIView) -> UIImage? {
        for sticker in _stickers {
            sticker.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        }
        
        UIGraphicsBeginImageContextWithOptions(rootImageView.bounds.size, rootImageView.isOpaque, 0)
        rootImageView.drawHierarchy(in: rootImageView.bounds, afterScreenUpdates: false)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapshot
    }
}
