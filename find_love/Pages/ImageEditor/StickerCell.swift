import UIKit

class StickerCell: UICollectionViewCell {
    
    private let _stickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var stickerImage: UIImage? {
        didSet {
            _stickerImageView.image = stickerImage
        }
    }
    
    var isChosen = false {
        didSet {
            if isChosen {
                highlightCell()
            } else {
                unhighlightCell()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func highlightCell() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    private func unhighlightCell() {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupViews() {
        addSubview(_stickerImageView)
        
        _stickerImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
}
