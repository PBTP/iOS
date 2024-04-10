//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 3/27/24.
//

import ProjectDescription

public extension TargetScript {
    static let SwiftLintString = TargetScript.pre(
        script: """
        if test -d "/opt/homebrew/bin/"; then
            PATH="/opt/homebrew/bin/:${PATH}"
        fi

        export PATH

        SWIFTLINT_CONFIG="$PROJECT_DIR/.swiftlint.yml"
        if test -f "$SWIFTLINT_CONFIG"; then
            swiftlint --config "$SWIFTLINT_CONFIG"
        else
            echo "warning: SwiftLint configuration file ($SWIFTLINT_CONFIG) not found"
        fi
        """,
        name: "SwiftLintString",
        basedOnDependencyAnalysis: false
    )
}
