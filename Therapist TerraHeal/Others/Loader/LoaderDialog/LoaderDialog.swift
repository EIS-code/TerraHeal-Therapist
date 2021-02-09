//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class LoaderDialog: UIView {

    @IBOutlet weak var dialogView: GradientBackgroundView!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dotView: AMDots!

    func initialize(message:String) {
        self.lblMessage.setFont(name: FontName.Regular, size: FontSize.large)
        lblMessage.setText(message)
    }
    override func awakeFromNib() {
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
}

@IBDesignable
public class AMDots: UIView {

  // MARK: - Properties
  /// Size of the dot, the default is calculated from the view `width`,
  /// E.g: if you have `4` dots and the view width is `400`, each one will be `100` `(400/4)`
  @IBInspectable public var dotSize: CGFloat = 0
  /// Space between each dot, the default is `10`
  @IBInspectable public var spacing: CGFloat = 10
  /// Animation duration for each dot it should be more than `0.1`, the default is `0.7`
  @IBInspectable public var animationDuration: CGFloat = 0.4

  /// The negative time you need the animation to run before the prevuse animation finish
  /// (If you set it for 0.2, the next animation will run before 0.2 second before the current animation finish).
  /// the default value is `0.2`.
  @IBInspectable public var aheadTime: CGFloat = 0.2
  /// A Boolean value that controls whether the must be hidden when the animation is stopped.
  @IBInspectable public var hidesWhenStopped: Bool = true

  /// The circles `color`, the number of dots will be the same as the number of colors,
  /// so if you have 3 colors, you will have 3 dots.
  ///
  /// Note: you should set the colors before add the view to super view.
  public var colors = [UIColor]()
  public var blinkingColor = UIColor()

  /// Animation type, do you want the dot to `jump`, `scale` or `shake`
  public var animationType: AnimationType = .scale

  // MARK: Private properties
  private var dotsViews = [UIView]()
  private var defaultsColors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),]
    private var defaultsBlinkingColor = UIColor.white
  private var currentViewIndex = 0
  private var timer: Timer?

  // MARK: - init
  public init(frame: CGRect, colors: [UIColor]? = nil, blinkingColor: UIColor? = nil) {
    super.init(frame: frame)
    self.colors = colors ?? defaultsColors
    self.blinkingColor = blinkingColor ?? self.defaultsBlinkingColor
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    colors = defaultsColors
    blinkingColor = defaultsBlinkingColor
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    colors = defaultsColors
    blinkingColor = defaultsBlinkingColor
  }

  // MARK: - Draw
  override public func draw(_ rect: CGRect) {

    drawTheDots()

    #if !TARGET_INTERFACE_BUILDER
    start()
    #endif
  }

  private func drawTheDots() {

    if dotSize == 0 {
      let width = frame.size.width - (CGFloat(colors.count-1)*spacing)
      dotSize = (width / CGFloat(colors.count))
    }

    for (index,color) in colors.enumerated() {
      let view = UIView(frame: CGRect(x: ((spacing + dotSize) * CGFloat(index)), y: (frame.height/2) - (dotSize/2) , width: dotSize, height: dotSize))
      view.backgroundColor = color
      view.layer.cornerRadius = dotSize/2
      addSubview(view)
    }
  }

  // MARK: - Animation
  @objc private func startAnimation() {

    currentViewIndex += 1
    if currentViewIndex >= subviews.count {
      currentViewIndex = 0
    }

    switch animationType {
    case .scale:
      scaleAnimation()
    case .jump:
      moveAnimation()
    case .shake:
      moveAnimation()
    case .blink:
      scaleAnimation()
    }
  }

  private func scaleAnimation() {
    let view = subviews[currentViewIndex]
    let defualtColor = view.backgroundColor
    UIView.animate(withDuration: TimeInterval(animationDuration/2), delay: 0.0, animations: {
      view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
      if self.animationType == .blink {
        view.backgroundColor = self.blinkingColor
      }
    }) { (finished) in
      UIView.animate(withDuration: TimeInterval(self.animationDuration/2), animations: {
        view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        view.backgroundColor = defualtColor
      })
    }
  }

  private func moveAnimation() {
    let view = subviews[currentViewIndex]
    let orginalFrame = view.frame
    var newFrame = orginalFrame
    if animationType == .jump {
      newFrame.origin.y += dotSize/2
    } else {
      newFrame.origin.x -= dotSize/2
    }
    UIView.animate(withDuration: TimeInterval(animationDuration/2), delay: 0.0, animations: {
      view.frame = newFrame
    }) { (finished) in
      UIView.animate(withDuration: TimeInterval(self.animationDuration/2), animations: {
        view.frame = orginalFrame
      })
    }
  }

  // MARK: - Public Functions (Stop/Start)
  /// Use it to start the animation for the AMDots
  public func start() {

    guard colors.count != 0 else {
      fatalError("There is a problem, Is the AMDot view already start? or maybe you are trying to start it before you add the AMDot view to the view controller!")
    }
    isHidden = false

    timer = Timer.scheduledTimer(timeInterval: Double(animationDuration-aheadTime), target: self, selector: #selector(startAnimation), userInfo: nil, repeats: true)
  }

  /// Use it to stop the animation for the AMDots
  public func stop() {
    timer?.invalidate()
    timer = nil

    if hidesWhenStopped {
      isHidden = true
    }
  }

}

// MARK: - Enum
public enum AnimationType {
  case jump
  case scale
  case shake
  case blink
}


@IBDesignable class GradientBackgroundView: UIView {
    // implement cgcolorgradient in the next section
    @IBInspectable var startColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient }
    }

    @IBInspectable var endColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient }
    }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet { gradientLayer.startPoint = startPoint }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0) {
        didSet { gradientLayer.endPoint = endPoint }
    }

    // Enables more convenient access to layer
        var gradientLayer: CAGradientLayer {
            return layer as! CAGradientLayer
        }

        override open class var layerClass: AnyClass {
            return CAGradientLayer.classForCoder()
        }
}

extension GradientBackgroundView {
    // For this implementation, both colors are required to display
    // a gradient. You may want to extend cgColorGradient to support
    // other use cases, like gradients with three or more colors.
    internal var cgColorGradient: [CGColor]? {
        guard let startColor = startColor, let endColor = endColor else {
            return nil
        }

        return [startColor.cgColor, endColor.cgColor]
    }
}
