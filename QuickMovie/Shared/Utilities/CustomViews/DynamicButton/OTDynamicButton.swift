//
//  OTDynamicButton.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import UIKit

typealias ButtonActionHandler = (UIButton) -> Void
class OTDynamicButton: BaseView {
    @IBOutlet private weak var vwBase: UIView!
    @IBOutlet weak var dynamicButton: UIButton!
    var dynamicButtonActionHandler: ButtonActionHandler?
    var viewModel: OTDynamicButtonViewModel?
    override func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        loadUI()
    }
    private func loadUI() {}
    
    func configureView(viewModel: OTDynamicButtonViewModel?, completionHandler: ButtonActionHandler?) {
        self.viewModel = viewModel
        self.dynamicButtonActionHandler = completionHandler
        if let viewModel = viewModel {
            if let validImage = viewModel.img {
                dynamicButton.setImage(validImage, for: .normal)
            }
            dynamicButton.tintColor = viewModel.tintColor
            dynamicButton.setTitle(viewModel.title, for: .normal)
            dynamicButton.titleLabel?.font = viewModel.titleFont
            dynamicButton.setTitleColor(viewModel.titleColor, for: .normal)
            dynamicButton.backgroundColor = viewModel.backgroundColor
            dynamicButton.addBorder(color: viewModel.borderColor, width: 0.5, radius: viewModel.cornerRadius)
            dynamicButton.layer.masksToBounds = true
            dynamicButton.isHidden = viewModel.isHidden
        }
    }
    
}

//MARK: Button Action
extension OTDynamicButton {
    
    @IBAction func dynamicButtonAction(_ sender: UIButton) {
        dynamicButtonActionHandler?(sender)
    }
    
}

extension OTDynamicButton {
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: OTDynamicButton.nameId, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

struct OTDynamicButtonViewModel{
    var img: UIImage?
    var title: String
    var tintColor: UIColor?
    var titleFont: UIFont?
    var titleColor: UIColor?
    var backgroundColor: UIColor?
    let borderColor: UIColor?
    let cornerRadius: CGFloat
    var isHidden: Bool
}
