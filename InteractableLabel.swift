//
//  InteractableLabel.swift
//  Weyyak
//
//  Created by Saikiran.Panuganti on 05/07/20.
//  Copyright © 2020 Saikiran Panuganti. All rights reserved.
//


import Foundation
import UIKit

struct startEndCounts {
    let startIndex : Int?
    let endIndex : Int?
}

protocol InteractableLabelDelegate : class {
    func searchItemTapped(searchItem : String, searchType : SearchType?)
}

class InteractableLabel : UILabel {
    
    var rangeArr : [startEndCounts] = [startEndCounts]()
    var searchtype : SearchType?
    
    weak var delegate : InteractableLabelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.isUserInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpInside))
        self.addGestureRecognizer(touchGesture)
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        return layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    }
    
    @objc private func touchUpInside(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let tapLocation = gestureRecognizer.location(in: self)
            let indexOfLetter = self.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
            
            for range in rangeArr {
                if let text = self.text {
                    if indexOfLetter >= range.startIndex ?? 0 && indexOfLetter <= range.endIndex ?? 0 {
                        let start = text.index(text.startIndex, offsetBy: range.startIndex ?? 0)
                        let end = text.index(text.startIndex, offsetBy: (range.endIndex ?? 0) - 1)
                        
                        let castString = text[start..<end]
                        delegate?.searchItemTapped(searchItem: String(castString), searchType: searchtype)
                        break
                    }
                }
            }
        }
    }
}

