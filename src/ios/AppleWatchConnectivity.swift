//
//  AppleWatchConnectivity.swift
//  entraineur
//
//  Created by Pierre-Luc on 2018-02-15.
//
import WatchConnectivity

@objc(AppleWatchConnectivity) class AppleWatchConnectivity : CDVPlugin, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }


    func initConnectivity(command: CDVInvokedUrlCommand) {
        
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )
        
        if(WCSession.isSupported()){
            let session = WCSession.default()
            session.delegate = self
            session.activate()
            
            if !session.isPaired != true{
                print("Watch is not paired")
            }else{
                
                let toastController: UIAlertController =
                    UIAlertController(
                        title: "WatchKit",
                        message: "Connection establish",
                        preferredStyle: .alert
                )
                
                self.viewController?.present(
                    toastController,
                    animated: true,
                    completion: nil
                )
            
                
                let mainQueue = DispatchQueue.main
                let deadline = DispatchTime.now() + .seconds(5)
                
                mainQueue.asyncAfter(deadline: deadline){
                    toastController.dismiss(
                        animated: true,
                        completion: nil
                    )
                }
                
                
                
            }
            if session.isWatchAppInstalled != true{
                print("watch app is not installed")
            }
        }else{
            print("WCSession is not supported on this devide")
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK
            )
        }
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
    
    func sendMessage(command: CDVInvokedUrlCommand) {
        
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )
        let msg = command.arguments[0] as? String ?? ""
        let progData = NSKeyedArchiver.archivedData(withRootObject: msg)
        
        if(WCSession.default().isReachable){
            let message = ["message" : progData]
          
            WCSession.default().sendMessage(message, replyHandler: nil)
            
        }else{
            print("WCSession is not supported on this devide")
        }
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
    
    
    /*@IBOutlet var testLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        
        if(WCSession.isSupported()){
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(WCSession.default.isReachable) {
            let message = ["message" : "allo"]
            
            WCSession.default.sendMessage(message, replyHandler:
                {(result) -> Void in
                    
                    print("send message worked!")
                    
                    
            }, errorHandler:
                
                
                {(error) -> Void in
                    
                    print("send message did not work!")
                    print(error)
                    
                    
            })
        }
    }*/
}
