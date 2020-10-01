//
//  StoryText.swift
//  Runner
//
//  Created by Joe Kletz on 29/09/2020.
//

import Foundation

class StoryText{
    let story = ["Spotty the Hyena is very sad, he has lost his laugh. ","""
 Please help me find my laugh", said Spotty.
    "I can't find a laugh up here" replied Giraffe.
 ""","""
 "Please help me find my laugh Hippo" asked spotty.
 "I can't hear a laugh down here" replied Hippo.
 ""","""
 Please help me find my laugh Warthog" asked Spotty.
 "I can't hear a laugh in hear" replied Warthog
 ""","""
 Please help me find my laugh Monkey pleaded Spotty.
 "How did you lose it? Asked Monkey.
 ""","""
 "When I laugh, you can see my big teeth. That makes everyone frightened" Said Spotty.
 ""","""
 "Then I got sad and my laugh just disappeared.
 I can't find it anywhere" Spotty carried on.
 ""","""
 "But you were looking in the wrong place" Said Monkey
 ""","""
 Monkey jumped out of the tree and picked up a feather.
 Then began to tickle Spotty all over. Slowly Spotty started smiling.
 ""","""
And then he let out a big loud laugh.
 He laughed and laughed until he was rolling around on the ground
""","""
 All the other animals started laughing too. "
 Where did you find his laugh?" They asked
 ""","""
 "His laugh was inside him all the time.
 I just made him happy and out it came" replied Monkey
 ""","""
 They all laughed and laughed so that their teeth showed too.
 ""","""
 "I'll never lose my laugh again" said Spotty the happy Hyena
 ""","""
 The End
 """]
    
    var currentPage = 0
    
    var currentPageText : String{
        get{
            return story[currentPage]
        }
    }
    
    
}
