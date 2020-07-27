// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
  #endif
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let banks = ImageAsset(name: "Banks")
  internal static let hotels = ImageAsset(name: "Hotels")
  internal static let key = ImageAsset(name: "Key")
  internal static let launchImg = ImageAsset(name: "LaunchImg")
  internal static let shoppingCart = ImageAsset(name: "Shopping-cart")
  internal static let stores = ImageAsset(name: "Stores")
  internal static let wallet = ImageAsset(name: "Wallet")
  internal static let aqi = ImageAsset(name: "aqi")
  internal static let arrowSetting = ImageAsset(name: "arrow_setting")
  internal static let avatarDefault = ImageAsset(name: "avatar_default")
  internal static let avatarLogin = ImageAsset(name: "avatar_login")
  internal static let back = ImageAsset(name: "back")
  internal static let barbuttonBack = ImageAsset(name: "barbutton_back")
  internal static let bottom = ImageAsset(name: "bottom")
  internal static let clearCache = ImageAsset(name: "clear_cache")
  internal static let collect = ImageAsset(name: "collect")
  internal static let collectSelected = ImageAsset(name: "collect_selected")
  internal static let collectionJust = ImageAsset(name: "collection_just")
  internal static let collectionList = ImageAsset(name: "collection_list")
  internal static let cover = ImageAsset(name: "cover")
  internal static let createNew = ImageAsset(name: "create_new")
  internal static let headBg = ImageAsset(name: "head_bg")
  internal enum Images {
    internal static let imgPARTLYCLOUDYDAY0 = ImageAsset(name: "img_PARTLY_CLOUDY_DAY_0")
    internal static let imgPARTLYCLOUDYDAY1 = ImageAsset(name: "img_PARTLY_CLOUDY_DAY_1")
    internal static let imgPARTLYCLOUDYDAY2 = ImageAsset(name: "img_PARTLY_CLOUDY_DAY_2")
  }
  internal static let jionJust = ImageAsset(name: "jion_just")
  internal static let jionList = ImageAsset(name: "jion_list")
  internal static let loginCurrent = ImageAsset(name: "login_current")
  internal static let logo = ImageAsset(name: "logo")
  internal static let logout = ImageAsset(name: "logout")
  internal static let lookJust = ImageAsset(name: "look_just")
  internal static let lookList = ImageAsset(name: "look_list")
  internal static let newdrawerForward = ImageAsset(name: "newdrawer_forward")
  internal static let `protocol` = ImageAsset(name: "protocol")
  internal static let renzheng = ImageAsset(name: "renzheng")
  internal static let rijie = ImageAsset(name: "rijie")
  internal static let setting = ImageAsset(name: "setting")
  internal static let sousuo = ImageAsset(name: "sousuo")
  internal static let validateCorrect = ImageAsset(name: "validate_correct")
  internal static let validateWrong = ImageAsset(name: "validate_wrong")
  internal static let versionUpdate = ImageAsset(name: "version_update")
  internal static let weatherIcon = ImageAsset(name: "weather_icon")
  internal enum WeathewrIcons {
    internal static let clearDayC = ImageAsset(name: "CLEAR_DAY-C")
    internal static let clearNightC = ImageAsset(name: "CLEAR_NIGHT-C")
    internal static let cloudyC = ImageAsset(name: "CLOUDY-C")
    internal static let cloudyDayC = ImageAsset(name: "CLOUDY_DAY-C")
    internal static let cloudyNightC = ImageAsset(name: "CLOUDY_NIGHT-C")
    internal static let dustC = ImageAsset(name: "DUST-C")
    internal static let fogC = ImageAsset(name: "FOG-C")
    internal static let hailC = ImageAsset(name: "HAIL-C")
    internal static let heavyHazeC = ImageAsset(name: "HEAVY_HAZE-C")
    internal static let heavyRainC = ImageAsset(name: "HEAVY_RAIN-C")
    internal static let heavySnowC = ImageAsset(name: "HEAVY_SNOW-C")
    internal static let lightHazeC = ImageAsset(name: "LIGHT_HAZE-C")
    internal static let lightRainC = ImageAsset(name: "LIGHT_RAIN-C")
    internal static let lightSnowC = ImageAsset(name: "LIGHT_SNOW-C")
    internal static let moderateHazeC = ImageAsset(name: "MODERATE_HAZE-C")
    internal static let moderateRainC = ImageAsset(name: "MODERATE_RAIN-C")
    internal static let moderateSnowC = ImageAsset(name: "MODERATE_SNOW-C")
    internal static let partlyCloudyDayC = ImageAsset(name: "PARTLY_CLOUDY_DAY-C")
    internal static let partlyCloudyNightC = ImageAsset(name: "PARTLY_CLOUDY_NIGHT-C")
    internal static let partlyRainC = ImageAsset(name: "PARTLY_RAIN-C")
    internal static let rainC = ImageAsset(name: "RAIN-C")
    internal static let sandC = ImageAsset(name: "SAND-C")
    internal static let sleetC = ImageAsset(name: "SLEET-C")
    internal static let stormRainC = ImageAsset(name: "STORM_RAIN-C")
    internal static let stormSnowC = ImageAsset(name: "STORM_SNOW-C")
    internal static let thunderShowerC = ImageAsset(name: "THUNDER_SHOWER-C")
    internal static let unkonwnC = ImageAsset(name: "UNKONWN-C")
    internal static let windC = ImageAsset(name: "WIND-C")
  }

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
    banks,
    hotels,
    key,
    launchImg,
    shoppingCart,
    stores,
    wallet,
    aqi,
    arrowSetting,
    avatarDefault,
    avatarLogin,
    back,
    barbuttonBack,
    bottom,
    clearCache,
    collect,
    collectSelected,
    collectionJust,
    collectionList,
    cover,
    createNew,
    headBg,
    Images.imgPARTLYCLOUDYDAY0,
    Images.imgPARTLYCLOUDYDAY1,
    Images.imgPARTLYCLOUDYDAY2,
    jionJust,
    jionList,
    loginCurrent,
    logo,
    logout,
    lookJust,
    lookList,
    newdrawerForward,
    `protocol`,
    renzheng,
    rijie,
    setting,
    sousuo,
    validateCorrect,
    validateWrong,
    versionUpdate,
    weatherIcon,
    WeathewrIcons.clearDayC,
    WeathewrIcons.clearNightC,
    WeathewrIcons.cloudyC,
    WeathewrIcons.cloudyDayC,
    WeathewrIcons.cloudyNightC,
    WeathewrIcons.dustC,
    WeathewrIcons.fogC,
    WeathewrIcons.hailC,
    WeathewrIcons.heavyHazeC,
    WeathewrIcons.heavyRainC,
    WeathewrIcons.heavySnowC,
    WeathewrIcons.lightHazeC,
    WeathewrIcons.lightRainC,
    WeathewrIcons.lightSnowC,
    WeathewrIcons.moderateHazeC,
    WeathewrIcons.moderateRainC,
    WeathewrIcons.moderateSnowC,
    WeathewrIcons.partlyCloudyDayC,
    WeathewrIcons.partlyCloudyNightC,
    WeathewrIcons.partlyRainC,
    WeathewrIcons.rainC,
    WeathewrIcons.sandC,
    WeathewrIcons.sleetC,
    WeathewrIcons.stormRainC,
    WeathewrIcons.stormSnowC,
    WeathewrIcons.thunderShowerC,
    WeathewrIcons.unkonwnC,
    WeathewrIcons.windC,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

private final class BundleToken {}
