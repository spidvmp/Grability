//
//  CollectionSection.swift
//  Grability
//
//  Created by Vicente de Miguel on 20/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

class CollectionSection: UICollectionReusableView {
    
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        self.addSubview(label)
        self.backgroundColor = UIColor.redColor()
        self.label.textColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }

    
    
    class func height() -> CGFloat{
        return 30
    }
    class func cellID() -> String {
        return String(self)
    }
}
