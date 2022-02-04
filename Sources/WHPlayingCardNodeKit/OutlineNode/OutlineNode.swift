//
//  OutlineNode.swift
//  CardImageKit
//
//  Created by William Hale on 5/24/17.
//

import SpriteKit
import WHCrossPlatformKit

/// A node that  shows the outline image of an area.
///
/// This node can be used to show the location of an empty area.
///
/// It can be used to show the location of an empty area where cards can be dropped  (for example, a discard pile or a meld pile).
/// The backgroundColor is clear, there is no corner radius, and the strokewidth is 0: in effect, it is invisible when not highlighted.
///
/// I use it in conjunction with the cardOutlineNode.
/// Let's consider the case of the discard pile.
/// I have a discardPileOutlineNode and a discardAreaOutlineNode (which is somewhat larger than the size of a card).
/// Both act as a drop site area when a card is being dragged which can be discarded.
/// If the discardPileOutlineNode is not hidden, then it is used instead of the discardAreaOutlineNode for highlightling the drop site.
/// But, if the discardPileOutlineNode is hiddent, then I use the discardAreaOutlineNode to highlight the drop site.
///

public class OutlineNode: SKSpriteNode, Highlightable {

    let unhighlightTexture:SKTexture
    let highlightTexture:SKTexture

    /// A boolean that indicates whether the outline image is highlighted.
    public var highlighted: Bool = false {
        didSet
        {
            if highlighted != oldValue {
                if highlighted {
                    texture = highlightTexture
                    colorBlendFactor = 0.3
                }
                else {
                    texture = unhighlightTexture
                    colorBlendFactor = 0
                }
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates an outline node with a given size.
    /// - Parameters:
    ///   - size: The size of the outline node.
    ///   - cornerRadius: The corner radius (nil if none).
    ///   - backgroundColor: The background color (default is .clear).
    ///   - strokeWidth: The stroke width (can be zero).
    public init(size:CGSize, cornerRadius:CGFloat? = nil, backgroundColor:SKColor = .clear, strokeWidth:CGFloat) {
        let outlineImage = OutlineNode.makeOutlineImage(size: size, backgroundColor: backgroundColor, cornerRadius: cornerRadius, strokeWidth: strokeWidth)
        self.unhighlightTexture = SKTexture(image: outlineImage)

        let highlightOutlineImage = OutlineNode.makeOutlineImage(size: size, backgroundColor: .white, cornerRadius: cornerRadius, strokeWidth: strokeWidth)
        self.highlightTexture = SKTexture(image: highlightOutlineImage)

        super.init(texture: unhighlightTexture, color: .clear, size: unhighlightTexture.size())
        self.name = "outlineNode"
    }

    private static func makeOutlineImage(size:CGSize, backgroundColor:SKColor, cornerRadius:CGFloat?, strokeWidth:CGFloat) -> WHImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let outlineImage = CrossPlatform.offscreenImageWithSize(rect.size) { context in
            context.setAllowsAntialiasing(true)
            context.clear(rect)

            let strokeRect = rect.insetBy(dx: strokeWidth, dy: strokeWidth)
            let strokePath:WHBezierPath
            if let cornerRadius = cornerRadius {
                strokePath = WHBezierPath(roundedRect: strokeRect, cornerRadius: cornerRadius)
            }
            else {
                strokePath = WHBezierPath(rect: strokeRect)
            }
            strokePath.lineWidth = strokeWidth

            // background
            context.setFillColor(backgroundColor.cgColor)
            strokePath.fill()

            // border
            context.setStrokeColor(SKColor.black.cgColor)
            if strokeWidth > 0 {
                strokePath.stroke()
            }

            // Draw back design
            let borderMargin = 0.1 * size.width
            let insetRect = rect.insetBy(dx: borderMargin, dy: borderMargin)
            context.setFillColor(SKColor.clear.cgColor)
            context.fill(insetRect)
        }
        return outlineImage
    }
}
