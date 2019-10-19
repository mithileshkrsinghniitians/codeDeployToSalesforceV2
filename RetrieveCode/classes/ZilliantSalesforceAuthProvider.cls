global with sharing class ZilliantSalesforceAuthProvider extends Auth.AuthProviderPluginClass
{
    private String connectedAppConsumerKey;
    private String connectedAppConsumerSecret;
    private String authorizationUrl;
    private String tokenUrl;
    private String redirectUri;

    global String getCustomMetadataType()
    {
        return 'mks1__zAPIConfiguration__mdt';
    }

    global PageReference initiate(Map<String, String> authProviderConfiguration, String stateToPropagate)
    {
        connectedAppConsumerKey = authProviderConfiguration.get('mks1__ConnectedAppConsumerKey__c');
        connectedAppConsumerSecret = authProviderConfiguration.get('mks1__ConnectedAppConsumerSecret__c');
        authorizationUrl = authProviderConfiguration.get('mks1__AuthorizationURL__c');
        tokenUrl = authProviderConfiguration.get('mks1__TokenURL__c');
        redirectUri = authProviderConfiguration.get('mks1__RedirectURI__c');
        String url = authorizationUrl + '?response_type=code&client_id=' + connectedAppConsumerKey + '&client_secret=' + connectedAppConsumerSecret + '&redirect_uri=' + redirectUri + '&state=' + stateToPropagate;

        System.debug('SFDC 1 (From Initiate Method)' + url);
        return new PageReference(url);
    }

    global Auth.AuthProviderTokenResponse handleCallback(Map<String, String> authProviderConfiguration, Auth.AuthProviderCallbackState state)
    {
        connectedAppConsumerKey = authProviderConfiguration.get('mks1__ConnectedAppConsumerKey__c');
        connectedAppConsumerSecret = authProviderConfiguration.get('mks1__ConnectedAppConsumerSecret__c');
        authorizationUrl = authProviderConfiguration.get('mks1__AuthorizationURL__c');
        tokenUrl = authProviderConfiguration.get('mks1__TokenURL__c');
        redirectUri = authProviderConfiguration.get('mks1__RedirectURI__c');

        String code = state.queryParameters.get('code');
        String sfdcState = state.queryParameters.get('state');

        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenURL);
        req.setHeader('Accept','application/json');
        req.setMethod('POST');
        req.setBody('grant_type=authorization_code&client_id=' + connectedAppConsumerKey + '&client_secret=' + connectedAppConsumerSecret + '&code=' + code + '&redirect_uri=' + redirectUri + '&state=' + sfdcState);

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('SFDC 2 (From HandleCallback Method)');
        String responseBody = res.getBody();

        System.debug('(handleCallback) responseBody: ' + responseBody);

        Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(responseBody);
        String base64EncodedResponse = EncodingUtil.base64Encode(Blob.valueOf(responseBody));
        System.debug('SFDC 3 (base64EncodedResponse)' + base64EncodedResponse);
        
        String refreshToken = safeGetString('refresh_token', response);
        System.debug('SFDC 4 (refreshToken)' + refreshToken);

        return new Auth.AuthProviderTokenResponse('ZilliantSalesforceAuthProvider', base64EncodedResponse, refreshToken, sfdcState);
    }

    global override Auth.OAuthRefreshResult refresh(Map<String, String> authProviderConfiguration, String refreshToken)
    {
        connectedAppConsumerKey = authProviderConfiguration.get('mks1__ConnectedAppConsumerKey__c');
        connectedAppConsumerSecret = authProviderConfiguration.get('mks1__ConnectedAppConsumerSecret__c');
        authorizationUrl = authProviderConfiguration.get('mks1__AuthorizationURL__c');
        tokenUrl = authProviderConfiguration.get('mks1__TokenURL__c');
        redirectUri = authProviderConfiguration.get('mks1__RedirectURI__c');

        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenUrl);
        req.setHeader('Accept', 'application/json');
        req.setMethod('POST');
        req.setBody('grant_type=refresh_token&client_id=' + connectedAppConsumerKey + '&client_secret=' + connectedAppConsumerSecret + '&refresh_token=' + refreshToken);
        
        System.debug('@@@ Refresh Token Print :' + refreshToken);

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('SFDC 5 (From refresh Method)');
        String responseBody = res.getBody();

        System.debug('(refresh) responseBody: ' + responseBody);

        Map<String, Object> response = (Map<String, Object>)JSON.deserializeUntyped(responseBody);
        String base64EncodedResponse = EncodingUtil.base64Encode(Blob.valueOf(responseBody));
        String newRefreshToken = safeGetString('refresh_token', response);

        System.debug('Refreshed access token (tail): ' + safeGetString('access_token', response).substring(15));
        System.debug('Refreshed encoded: ' + base64EncodedResponse);

        return new Auth.OAuthRefreshResult(base64EncodedResponse, newRefreshToken);
    }

    global Auth.UserData getUserInfo(Map<String, String> authProviderConfiguration, Auth.AuthProviderTokenResponse response)
    {
        connectedAppConsumerKey = authProviderConfiguration.get('mks1__ConnectedAppConsumerKey__c');
        connectedAppConsumerSecret = authProviderConfiguration.get('mks1__ConnectedAppConsumerSecret__c');
        authorizationUrl = authProviderConfiguration.get('mks1__AuthorizationURL__c');
        tokenUrl = authProviderConfiguration.get('mks1__TokenURL__c');
        redirectUri = authProviderConfiguration.get('mks1__RedirectURI__c');

        String decodedToken = EncodingUtil.base64Decode(response.oauthToken).toString();
        Map<String, Object> tokens = (Map<String, Object>)JSON.deserializeUntyped(decodedToken);

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jolly-dev-ed.my.salesforce.com/services/apexrest/Accounts/001i000000vGJDh');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + safeGetString('access_token', tokens));
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        String responseBody = res.getBody();

        System.debug('responseBody: ' + responseBody);
        Map<String, Object> idResponse = (Map<String, Object>)JSON.deserializeUntyped(responseBody);

        // TODO: I think the response includes an "ID" URL for getting this
        // info, but it's not super critical.
        return new Auth.UserData(
            safeGetString('user_id', idResponse),
            safeGetString('first_name', idResponse),
            safeGetString('last_name', idResponse),
            null, // fullName
            safeGetString('email', idResponse),
            safeGetString('id', idResponse),
            safeGetString('username', idResponse),
            safeGetString('locale', idResponse),
            'ZilliantSalesforceAuthProvider',
            null, // siteLoginUrl
            null // attributeMap
        );
    }

    private static String safeGetString(String key, Map<String, Object> keyValues)
    {
        Object value = keyValues.get(key);
        return value != null ?  value.toString() : null;        
    }
}