//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by inforex on 2022/10/14.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "Util",
    dependencies: [
        .Module.thirdPartyLib
    ],
    resources: .default
)
