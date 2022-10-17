//
//  Projects.swift
//  ProjectDescriptionHelpers
//
//  Created by inforex on 2022/10/12.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "Service",
    dependencies: [
        .Module.domain,
        .Module.repository,
        .Module.util,
        .Module.thirdPartyLib
    ]
)
