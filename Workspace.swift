//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by inforex on 2022/10/12.
//

import ProjectDescription

let workspace = Workspace(
    name: "HowMuchCoin",
    projects: [
        "HowMuchCoin/App",
        "HowMuchCoin/Domain",
        "HowMuchCoin/Presentation",
        "HowMuchCoin/Repository",
        "HowMuchCoin/Service",
        "HowMuchCoin/Util",
        "HowMuchCoin/ThirdPartyLib"
    ]
)
