import UIKit
import DynamicStickers

class ImageEditorController: CommonViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        clearStickers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _stickersViewCollection.flashScrollIndicators()
    }
    
    private let _avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    private let _chooseEffectLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите эффект"
        label.font = UIFont.systemFont(ofSize: 27, weight: UIFont.Weight(0.2))
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let _clearButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "Очистить",
                                         cornerRadius: 35)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.2))
        
        return button
    }()
    
    private let _acceptButton: UIButton = {
        let button = UIButton()
        button.filledCornerInitilization(color: UIColor.darkGray, title: "Принять",
                                         cornerRadius: 35)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.2))
        
        return button
    }()
    
    
    private var _chosenStickerIndex: Int?
    private let _stickerCellId = "stickerCell"
    private let _stickersViewCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let stickers = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        stickers.translatesAutoresizingMaskIntoConstraints = false
        stickers.indicatorStyle = .white
        
        return stickers
    }()
    
    private let _stickersNames = ["mask_1", "mask_2", "mask_3",
                                  "mask_4", "mask_5", "mask_6",
                                  "mask_7", "mask_8", "mask_9",
                                  "mask_10"]
    
    var avatarImage: UIImage? {
        didSet {
            _avatarImageView.image = avatarImage
        }
    }
    
    var editionSession = false
    
    private func setupViews() {
        _chooseEffectLabel.font = _chooseEffectLabel.font.withHeightConstant(multiplier: 0.03, view: view)
        _clearButton.titleLabel?.font = _clearButton.titleLabel?.font.withHeightConstant(multiplier: 0.03, view: view)
        _acceptButton.titleLabel?.font = _acceptButton.titleLabel?.font.withHeightConstant(multiplier: 0.03, view: view)
        
        view.addSubview(_avatarImageView)
        view.addSubview(_chooseEffectLabel)
        view.addSubview(_stickersViewCollection)
        view.addSubview(_clearButton)
        view.addSubview(_acceptButton)
        
        _avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        _avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        _avatarImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 45).isActive = true
        _avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.47).isActive = true
        
        _chooseEffectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _chooseEffectLabel.topAnchor.constraint(equalTo: _avatarImageView.bottomAnchor, constant: view.frame.height * 0.020).isActive = true
        
        _stickersViewCollection.topAnchor.constraint(equalTo: _chooseEffectLabel.bottomAnchor, constant: 10).isActive = true
        _stickersViewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _stickersViewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _stickersViewCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        _stickersViewCollection.register(StickerCell.self, forCellWithReuseIdentifier: _stickerCellId)
        _stickersViewCollection.delegate = self
        _stickersViewCollection.dataSource = self
        
        _clearButton.topAnchor.constraint(equalTo: _stickersViewCollection.bottomAnchor,
                                          constant: view.frame.height * 0.020).isActive = true
        _clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        _clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
        _clearButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _clearButton.addTarget(self, action: #selector(clearButtonOnClick), for: .touchUpInside)
        
        _acceptButton.topAnchor.constraint(equalTo: _stickersViewCollection.bottomAnchor,
                                           constant: view.frame.height * 0.020).isActive = true
        _acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        _acceptButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
        _acceptButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        _acceptButton.addTarget(self, action: #selector(acceptButtonOnClick), for: .touchUpInside)
    }
    
    @objc private func clearButtonOnClick() {
        clearStickers()
        _chosenStickerIndex = nil
    }
    
    @objc private func acceptButtonOnClick() {
        let editedImage = saveEditedImageFrom(rootImageView: _avatarImageView) ?? _avatarImageView.image
        
        guard let previousController = navigationController?.viewControllers[navigationController!.viewControllers.count - 2]
            as? NewFormViewController else {
                fatalError("no previous controller")
        }
        
        previousController.setEditedImage(image: editedImage)
        navigationController?.popViewController(animated: true)
    }
}

extension ImageEditorController: UICollectionViewDelegate, UICollectionViewDataSource,
            UICollectionViewDelegateFlowLayout, DynamicStickersHandler {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _stickersNames.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _stickerCellId, for: indexPath)
            as? StickerCell else { fatalError("cell is not sticker") }
        
        cell.isChosen = _chosenStickerIndex != nil && _chosenStickerIndex == indexPath.row
        cell.stickerImage = UIImage(named: _stickersNames[_stickersNames.count - 1 - indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: _stickersViewCollection.frame.width / 3.4, height: _stickersViewCollection.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _chosenStickerIndex == indexPath.row {
            return
        }
        
        let previousIndex = _chosenStickerIndex
        var indexPathes = [indexPath]
        
        if let index = previousIndex {
            indexPathes += [IndexPath(row: index, section: 0)]
        }
        
        let doesStickerExist = _chosenStickerIndex == nil
        _chosenStickerIndex = indexPath.row
        collectionView.reloadItems(at: indexPathes)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? StickerCell,
            let sticker = cell.stickerImage {
            if doesStickerExist {
                pushStickerAndRegisterGestures(rootImageView: _avatarImageView, sticker: sticker,
                                               shouldBeSingleSticker: true, dashedBorder: true)
            } else {
                swapImage(sticker: sticker)
            }
        }
    }
}
