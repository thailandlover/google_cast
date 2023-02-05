import Flutter
import UIKit
import GoogleCast

public class SwiftGoogleCastPlugin: NSObject, FlutterPlugin, GCKRequestDelegate {
  let receiverId = kGCKDefaultMediaReceiverApplicationID
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "google_cast", binaryMessenger: registrar.messenger())
    let instance = SwiftGoogleCastPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          self.initGoogleCast()
          switch(call.method){
          case "show_connection_dialog":
              GCKCastContext.sharedInstance().presentCastDialog()
              result(true);
              break;
          case "is_connected":
              result(GCKCastContext.sharedInstance().sessionManager.hasConnectedSession())
              break
          case "show_control_dialog":
              if((GCKCastContext.sharedInstance().sessionManager.currentSession?.remoteMediaClient?.mediaStatus) != nil){
                  GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()
                  result(true)
              }
              result(false);
              break
          case "start_casting":
              self.initGoogleCast()
              self.startCastingVideo(result:result,call:call)
              break
          default:
              print("method wasn't found : ",call.method);
              result("method wasn't found : "+call.method)
          }
          result("iOS " + UIDevice.current.systemVersion)
      }

      func initGoogleCast(){
          let criteria = GCKDiscoveryCriteria(applicationID: self.receiverId)
          let options = GCKCastOptions(discoveryCriteria: criteria)
          GCKCastContext.setSharedInstanceWith(options)
          GCKCastContext.sharedInstance().useDefaultExpandedMediaControls = true
      }

      func startCastingVideo(result: @escaping FlutterResult,call: FlutterMethodCall){
          guard let args = call.arguments else {
              return ;
          }
          if let myArgs = args as? [String: Any],
             let title : String = myArgs["title"] as? String,
             let description : String = myArgs["description"] as? String,
             let posterPhoto : String = myArgs["posterPhoto"] as? String,
             let mediaUrl : String = myArgs["mediaUrl"] as? String,
             let playPosition : Double = myArgs["playPosition"] as? Double
          {

              let tMetadata:GCKMediaMetadata = GCKMediaMetadata(metadataType: GCKMediaMetadataType.movie)
              tMetadata.setString(title, forKey: kGCKMetadataKeyTitle)
              tMetadata.setString(description,
                                  forKey: kGCKMetadataKeySubtitle)
              tMetadata.addImage(GCKImage(url: URL(string: posterPhoto)!,
                                          width: 480,
                                          height: 360))

              let url = URL.init(string: mediaUrl)
              guard let mediaURL = url else {
                  print("invalid mediaURL")
                  return
              }
              let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: mediaURL)
              mediaInfoBuilder.streamType = GCKMediaStreamType.buffered;
              mediaInfoBuilder.contentType = "video/mp4"
              mediaInfoBuilder.metadata = tMetadata;

              let tMediaInfo = mediaInfoBuilder.build()
              let tMediaLoadOption = GCKMediaLoadOptions()
              tMediaLoadOption.autoplay = true;
              let playedPos : TimeInterval = playPosition
              tMediaLoadOption.playPosition = playedPos;

              let sessionManager = GCKCastContext.sharedInstance().sessionManager
              if let request = sessionManager.currentSession?.remoteMediaClient?.loadMedia(tMediaInfo,with:tMediaLoadOption) {
                  request.delegate = self
              }
              GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()

              result(true)
          } else {
              print("iOS could not extract flutter arguments in method: (sendParams)")
              result(false)
          }
          result(false)
      }
  }

}
