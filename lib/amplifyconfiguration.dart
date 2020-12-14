const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-1:4eb2e13e-1134-4642-b713-3f6940257051",
                            "Region": "ap-southeast-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-1_5BfiF60iL",
                        "AppClientId": "sb0dsiq0k33og2cgum206rhhm",
                        "AppClientSecret": "c25ukvd1cj9q7qfrvdg3197594e75ju2qjie4qfeejist84f78j",
                        "Region": "ap-southeast-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "spentmobileappf298d674-f298d674-dev.auth.ap-southeast-1.amazoncognito.com",
                            "AppClientId": "sb0dsiq0k33og2cgum206rhhm",
                            "AppClientSecret": "c25ukvd1cj9q7qfrvdg3197594e75ju2qjie4qfeejist84f78j",
                            "SignInRedirectURI": "myapp://callback/",
                            "SignOutRedirectURI": "myapp://signout/",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "d5ab8b3e1788464cbc67948ab042fbcc",
                        "Region": "ap-southeast-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "ap-southeast-1"
                    }
                }
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "d5ab8b3e1788464cbc67948ab042fbcc",
                    "region": "ap-southeast-1"
                },
                "pinpointTargeting": {
                    "region": "ap-southeast-1"
                },
                "autoFlushEventsInterval": 10000
            }
        }
    }
}''';
