//
//  DS.swift
//  Depp Studios FrameWork
//
//  Created by Daniel Pereira on 24/12/15.
//  Copyright (c) 2015 Depp Studios. All rights reserved.
//

import SpriteKit
import CoreData

public extension Int{
    public static func Random(max: UInt32)->Int{
        let maxi = max + 1
        return Int(arc4random_uniform(maxi))
    }
}

var data = NSUserDefaults.standardUserDefaults()

public typealias int = Int
public typealias bool = Bool
public typealias double = Double
public typealias string = String
public typealias float = Float

public class DS {
    
    // Game Actions Be Like SpriteKit
    struct action {}
    
    // Units Conversor
    struct convertion {}
    
    // Save & Load Data
    struct data {}
    struct coreData {}
    
    // Delay a Function: delay(seconds){function here}
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func zRotationAngle(degrees: CGFloat)->CGFloat{
        let angle = degrees * 0.0174532925
        return angle
    }
}

extension DS.action{
    
    // Delay in Seconds
    static func wait(seconds: NSTimeInterval)->SKAction{
        let wait = SKAction.waitForDuration(seconds)
        return wait
    }
    
    // Speed Multiplier
    static func setSpeed(sprite: SKSpriteNode, fraction: CGFloat)-> SKAction{
        let action = SKAction.runBlock({sprite.physicsBody?.velocity = CGVectorMake(sprite.physicsBody!.velocity.dx * fraction, sprite.physicsBody!.velocity.dy * fraction)})
        return action
    }
    
    // Resize to values
    static func resizeTo(width: CGFloat, height: CGFloat, time: NSTimeInterval)-> SKAction{
        let action = SKAction.resizeToWidth(width, height: height, duration: time)
        return action
    }
    
    // rotate in Degrees
    static func rotateByAngle(degrees: CGFloat, time: NSTimeInterval)->SKAction{
        let angle = degrees * 0.0174532925
        let action = SKAction.rotateByAngle(angle, duration: time)
        return action
    }
    
    // Move to Y Position
    static func moveToY(position: CGFloat, time: NSTimeInterval)-> SKAction{
        let action = SKAction.moveToY(position, duration: time)
        return action
    }
    
    // Move to X Position
    static func moveToX(position: CGFloat, time: NSTimeInterval)-> SKAction{
        let action = SKAction.moveToX(position, duration: time)
        return action
    }
    
    // Move to Any Position
    static func moveTo(x: CGFloat, y: CGFloat, time: NSTimeInterval)-> SKAction{
        let action = SKAction.moveTo(CGPoint(x: x, y: y), duration: time)
        return action
    }
    
    // Group of Two Actions
    static func groupOfTwo(action1: SKAction, action2: SKAction)-> SKAction{
        let group = SKAction.group([action1, action2])
        return group
    }
    
    // Group of Tree Actions
    static func groupOfTwo(action1: SKAction, action2: SKAction, action3: SKAction)-> SKAction{
        let group = SKAction.group([action1, action2, action3])
        return group
    }
    
    // Set Texture
    static func setTexture(sprite: SKSpriteNode, image: String){
        sprite.texture = SKTexture(imageNamed: image)
    }
    
    // Scroll in Y Axis
    static func scrollInY(spritePosition: CGPoint, to: CGFloat, time: NSTimeInterval)-> SKAction{
        let x = spritePosition.x
        let scrollY = spritePosition.y + to
        let point: CGPoint = CGPoint(x: x, y: scrollY)
        let action = SKAction.moveTo(point, duration: time)
        return action
    }
    
    // Scroll in X Axis
    static func scrollInX(spritePosition: CGPoint, to: CGFloat, time: NSTimeInterval)-> SKAction{
        let y = spritePosition.y
        let scrollX = spritePosition.x + to
        let point: CGPoint = CGPoint(x: scrollX, y: y)
        let action = SKAction.moveTo(point, duration: time)
        return action
    }
    
}
extension DS.convertion{
    static func degressToRadian(degrees: CGFloat)->CGFloat{
        return degrees * 0.0174532925
    }
}
extension DS.data{
    
    //: ||===========================================================================================================||
    //: ||In load use key for de name of the value saved, in case of don't exis any data use a default value in error||
    //: ||===========================================================================================================||
    
    static func save(value: AnyObject, key: String){
        data.setValue(value, forKey: key)
        data.synchronize()
    }
    
    static func load(key: String, error: AnyObject)->AnyObject{return data.valueForKey(key) ?? error}
    
}
extension DS.coreData{
    // SAVE
    static func save(entity: String){
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //2
        let entity =  NSEntityDescription.entityForName(entity, inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        //3

    }
    
    // LOAD
    static func load(entity: String, key: String, predicate: String)->String{
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //2
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "\(key) = %@", predicate)
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            return results[0].valueForKey(key) as? String
            //            for res in results{
            //                print(res)
            //            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
