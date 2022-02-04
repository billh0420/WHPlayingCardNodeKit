//
//  CardOutlineNode.swift
//  CardImageKit
//
//  Created by William Hale on 4/18/17.
//  Copyright © 2017 William Hale. All rights reserved.
//

import SpriteKit
import WHPlayingCardImageKit

/// A node that  shows the outline image of a playing card.
///
/// This node can be used to show the location of an empty pile of card nodes (for example, a discard pile or a meld pile).
///
/// It can remain permantently placed with card nodes overlaying it.
///
/// You can provide a user setting to optionally hide a specific type (for example, a discard pile or a meld pile).
/// For discard pile and meld pile, I usually have the default setting to show the outline node.
/// For the player's held pile, I usually have the default setting to hide the outline node.
///
/// If a pile becomes empty and cards can no longer be added to it,
/// you might want to hide the outline node.
public class CardOutlineNode: SKSpriteNode, Highlightable {

    let unhighlightTexture:SKTexture
    let highlightTexture:SKTexture

    /// A boolean that indicates whether the outline image is highlighted.
    public var highlighted: Bool = false {
        didSet
        {
            if highlighted != oldValue {
                if highlighted {
                    texture = highlightTexture
                    //colorBlendFactor = 0.3
                }
                else {
                    texture = unhighlightTexture
                    //colorBlendFactor = 0
                }
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates a card outline node with a given card size.
    /// - Parameter cardSize: The card size.
    public init(cardSize:CGSize) {
        let outlineCardImage = CardBackImage.makeCardBackImage(cardSize: cardSize, fillColor: .clear, backgroundColor: .clear)
        self.unhighlightTexture = SKTexture(image: outlineCardImage)

        let highlightColor = SKColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        let highlightOutlineCardImage = CardBackImage.makeCardBackImage(cardSize: cardSize, fillColor: .clear, backgroundColor: highlightColor)
        self.highlightTexture = SKTexture(image: highlightOutlineCardImage)

        super.init(texture: unhighlightTexture, color: .clear, size: unhighlightTexture.size())
        self.name = "cardOutlineNode"
    }
}
