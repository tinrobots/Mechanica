// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Mechanica",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    //.library(name: "Mechanica", targets: ["Mechanica"])
    .library(name: "Mechanica", targets: ["Mechanica"])
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    
    .target(name: "Mechanica", path: "Sources"),
    .testTarget(name: "FoundationTests", dependencies: ["Mechanica"]),
    .testTarget(name: "SharedTests", dependencies: ["Mechanica"]),
    .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
    .testTarget(name: "UIKitTests", dependencies: ["Mechanica"]),
    //.testTarget(name: "AppKitTests", dependencies: ["Mechanica"]) //currently empty
  ],
    swiftLanguageVersions: [4]
)

#if os(Linux)
  
package.targets = [
  .target(name: "Mechanica",
          path: "Sources",
          exclude: ["AssociatedValueSupporting.swift", "NSObjectProtocol+Swizzling.swift"],
          sources: ["StandardLibrary", "Foundation"]
  ),
  .testTarget(name: "StandardLibraryTests", dependencies: ["Mechanica"]),
  .testTarget(name: "FoundationTests",
              dependencies: ["Mechanica"],
              exclude: ["AssociatedValueSupportingTests.swift",
                        "NSAttributedStringUtilsTests.swift",
                        "NSMutableAttributedStringUtilsTests.swift",
                        "NSObjectProtocolSwizzlingTests.swift",
                        "UserDefaultsUtilsTests.swift"
    ]
  )
]
  
#endif
