import UIKit
import SearchTextField

class UnderlinedTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createUnderline(layer: layer, frame: frame)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 7)
    }
}

class UnderlinedSearchTextField: SearchTextField {
    fileprivate var _xOffset: CGFloat = 0
    fileprivate var _yOffset: CGFloat = 0
    
    convenience init(xOffset: CGFloat, yOffset: CGFloat, searchHelpers: [String]) {
        self.init()
        
        _yOffset = yOffset
        _xOffset = xOffset
        
        setupDefaultSearch(searchHelpers)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDefaultSearch(nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupDefaultSearch(nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createUnderline(layer: layer, frame: frame)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: _xOffset, dy: _yOffset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: _xOffset, dy: _yOffset)
    }
    
    fileprivate func setupDefaultSearch(_ search: [String]?) {
        comparisonOptions = [.caseInsensitive]
        highlightAttributes = [NSAttributedStringKey.backgroundColor: UIColor.lightGray,
                               NSAttributedStringKey.font:UIFont.systemFont(ofSize: 25)]
        
        theme.font = UIFont.systemFont(ofSize: 25)
        theme.bgColor = UIColor.white
        theme.borderColor = UIColor.black
        theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        theme.cellHeight = 40
        
        if let search = search {
            filterStrings(search)
        }
    }
}


private func createUnderline(layer: CALayer, frame: CGRect) {
    
    let border = CALayer()
    let width = CGFloat(2.0)
    border.borderColor = UIColor.lightGray.cgColor
    border.frame = CGRect(x: 0, y: frame.size.height - width,
                          width:  frame.size.width, height: frame.size.height)
    
    border.borderWidth = width
    layer.addSublayer(border)
    layer.masksToBounds = true
}
