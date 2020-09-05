# InteractiveLabel


Interective Label class for making the strings in the label clickable. Assign the class for the Label and use the below code for adding. Just use the below function and pass the array to the function after assigning the class to the label, titleText is optional. 






func setUpText(list : [String], titleText : String) {
        attributedString = NSMutableAttributedString()
        rangeArray = []
        
        let starringAttributedString = NSAttributedString(string: titleText, attributes: [NSAttributedString.Key.font: Config.shared.fontStyles.regular3])
        
        attributedString.append(starringAttributedString)
        
        var startindex = titleText.count
        var endIndex = titleText.count - 1
        var stringCount = 0
        
        for (index, cast) in list.enumerated() {
            
            let attribute = NSAttributedString(string: cast, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: Config.shared.fontStyles.regular3])
            let attribute1 = NSAttributedString(string: ", ", attributes: [NSAttributedString.Key.font: Config.shared.fontStyles.regular3])
            
            attributedString.append(attribute)
            
            startindex = startindex + stringCount
            
            if index < list.count-1 {
                attributedString.append(attribute1)
            }
            
            stringCount = (cast + ", ").count

            endIndex = endIndex + stringCount
            
            rangeArray.append(startEndCounts(startIndex: startindex, endIndex: endIndex))
        }
    }
