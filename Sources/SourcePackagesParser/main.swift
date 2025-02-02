//
//  main.swift
//
//
//  Created by ky0me22 on 2022/06/03.
//

import Foundation

func exitWithUsage() -> Never {
    print("USAGE: swift run spp [output directory path] [SourcePackages directory path]")
    exit(1)
}

func exitWithSPPError(_ sppError: SPPError) -> Never {
    switch sppError {
    case .couldNotReadFile(let fileName):
        print("Error: Could not read \(fileName).")
        exit(1)
    case .noLibraries:
        print("Error: No libraries.")
        exit(0)
    case .couldNotExportLicenseList:
        print("Error: Could not export license-list.plist.")
        exit(1)
    }
}

func main() {
    guard CommandLine.arguments.count == 3 else {
        exitWithUsage()
    }
    let outputPath = CommandLine.arguments[1]
    let sourcePackagesPath = CommandLine.arguments[2]
    do {
        try SourcePackagesParser(outputPath, sourcePackagesPath).run()
    } catch {
        if let sppError = error as? SPPError {
            exitWithSPPError(sppError)
        }
    }
}

main()
