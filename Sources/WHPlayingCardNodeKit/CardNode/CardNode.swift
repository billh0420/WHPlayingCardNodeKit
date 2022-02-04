//
//  CardNode.swift
//  
//
//  Created by William Hale on 1/21/22.
//

import SpriteKit
import WHPlayingCardImageKit
import WHPlayingCardKit
import WHCrossPlatformKit

/// A node that  shows the image of a given playing card.
public class CardNode: SKSpriteNode, Highlightable {

    /// The playing card.
    public let card:Card

    /// A boolean that indicates whether the card is face up.
    public var faceup = true {
        didSet
        {
            if faceup != oldValue {
                texture = faceup ? cardTexture : cardBackTexture
            }
        }
    }

    /// A boolean that indicates whether the card is highlighted.
    public var highlighted: Bool = false {
        didSet
        {
            if highlighted != oldValue {
                colorBlendFactor = highlighted ? 0.3 : 0
            }
        }
    }

    let cardTexture:SKTexture
    let cardBackTexture:SKTexture

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates a card node with a given card, card image, and card back image.
    /// - Parameters:
    ///   - card: The card.
    ///   - cardImage: The image of the card.
    ///   - cardBackImage: The image of the back of the card.
    public init(card:Card, cardImage:WHImage, cardBackImage:WHImage) {
        self.card = card
        self.cardTexture = SKTexture(image: cardImage)
        self.cardBackTexture = SKTexture(image: cardBackImage)
        super.init(texture: cardTexture, color:SKColor.white, size:cardTexture.size())
        color = .black
        self.name = card.packName
    }

    /// Creates a card node that shows the partial image of a playing card with a given card, default card size, and scale factor.
    ///
    /// The partial image of the playing card consists of a single large suit image in the center
    /// and smaller rank and pip images in the upper left corner.
    /// - Parameters:
    ///   - card: The card.
    ///   - defaultCardSize: The default card size.
    ///   - scaleFactor: The factor to scale the default card size to yield the actual card node size.
    public init(card:Card, defaultCardSize:CGSize, scaleFactor:CGFloat) {
        self.card = card
        let partialCardImageMaker = PartialCardImageMaker(defaultCardSize: defaultCardSize, scaleFactor: scaleFactor)
        let cardImage = partialCardImageMaker.makeCardImageFor(rank: card.rank, suit: card.suit)
        self.cardTexture = SKTexture(image: cardImage)

        let cardBackImage = CardBackImage.makeCardBackImage(cardSize: cardImage.size, fillColor: .blue, backgroundColor: CardBackImage.cardBackgroundColor)
        self.cardBackTexture = SKTexture(image: cardBackImage)

        super.init(texture: cardTexture, color:SKColor.white, size:cardTexture.size())
        color = .black
        self.name = card.packName
    }

    /// Toggle whether the card node is highlighted or not.
    public func toggleHighlighted() {
        highlighted = !highlighted
    }

    /// Remove the card node from its parent and position it offscreen.
    ///
    /// The purpose is to avoid flashes when the card node is reshown with a new parent and a new position.
    /// This is especially true when a hand ends and  a new hand begins.
    /// For example, you can call the following function when a new hand begins:
/**
```swift
    private func gatherAllCardNodes() {
        for cardNode in allCardNodes {
            cardNode.limboFromParent()
            cardNode.highlighted = false
            cardNode.faceup = false
            cardNode.zRotation = 0
            cardNode.isHidden = true
        }
    }
```
*/
    /// You can have faceup being true and isHidden being false if you wish.
    /// I don't depend upon whatever the default value is when I reset the cardNode.
    ///
    /// Now all the card nodes are offscreen.
    /// You can now setup the cardNodes in the stockPile, discardPile, and the heldPile for each player.
    /// Since the cardNodes are offscreen, there are no flashes.
    ///
    /// Be sure to reset the following attributes:
    ///
    /// * Set highlighted as needed (usually false).
    /// * Set faceup as needed.
    /// * Set zRotation to 0 or as needed (usually 0).
    /// * Set isHiddend as needed (usually false).
    /// * Add card node to new parent.
    ///
    /// You can finally set the new positions for each cardNode.
    /// I use a fan method to position the cardNodes for each cardNode of the stockPile, discardPile, and heldPiles.
    ///
    /// You can also interweave the setup and fanning (which is what I do):
    /// * setup the cardNodes in the stockPile and then fan the cardNodes in the stockPile;
    /// * setup the cadNodes in the opponent heldPile and then fan;
    /// * setup the cardNodes in the human player heldPile and then fan;
    /// * setup the cardNodes in the discardPile and then fan.
    public func limboFromParent() { // wch: to avoid flashes
        removeFromParent()
        position = CGPoint(x: 99999, y: 99999)
    }
}
