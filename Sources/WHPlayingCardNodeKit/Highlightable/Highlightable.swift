//
//  Highlightable.swift
//  
//
//  Created by William Hale on 1/21/22.
//

/// A protocol for objects that can be highlighted.
///
/// A highlightable object is an object that can be a drop site for cards being dragged.
///
/// When a drag action starts, you can create a list of potential drop sites.
/// This list of drop sites can act as a radio group of radio buttons
/// where at most one is highlighted (that is, turned on).
///
/// When the hot point of the drag cards is over one of the potential drop sites,
/// you can set its highlighted to be true.
/// The selected object should provide some visible feedback to the user.
///
/// It is up to you to code the radio group requirements that at most one station is on
/// and preferably a station is turned on only if it is already off.
/// The radio group does not need to be a class.
/// You can meet the requirements in the touchedMoved or mouseDragged functions in SKScene.
public protocol Highlightable: AnyObject {

    /// A boolean value that determines whether the object is highlighted.
    var highlighted: Bool { get set }
}
