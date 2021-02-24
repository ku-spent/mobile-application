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
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://quxwa5rc3vgglbri3rujvmgmry.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                        "Region": "ap-southeast-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "SPENTApi_AMAZON_COGNITO_USER_POOLS"
                    },
                    "SPENTApi_API_KEY": {
                        "ApiUrl": "https://quxwa5rc3vgglbri3rujvmgmry.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                        "Region": "ap-southeast-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-anlzulk3rzaihlawdcmf7pzuge",
                        "ClientDatabasePrefix": "SPENTApi_API_KEY"
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
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "SPENTApi": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://quxwa5rc3vgglbri3rujvmgmry.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                    "region": "ap-southeast-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS",
                    "apiKey": "da2-anlzulk3rzaihlawdcmf7pzuge"
                },
                "awsRestAPI": {
                    "endpointType": "REST",
                    "endpoint": "https://q1efoi7143.execute-api.ap-southeast-1.amazonaws.com/dev",
                    "region": "ap-southeast-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    }
}''';