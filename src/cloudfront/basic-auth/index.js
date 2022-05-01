exports.handler = async (event) => {
    let isAllowedAccess = false;

    const request = event.Records[0].cf.request;
    console.log('lambda function')


    if( request && request.headers && request.headers.authorization) {
        const basicAuthHeader = request.headers.authorization[0].value;
        const authString = 'Basic ' + new Buffer('admin' + ':' + 'monday1').toString('base64');
        isAllowedAccess = (basicAuthHeader === authString);
    }

    if( !isAllowedAccess) {
        const response = {
            status: 401,
            body: JSON.stringify('no access for you'),
            headers: {
                'www-authenticate': [{key: 'WWW-Authenticate', value: 'Basic'}]
            }
        }
        return response;
   } else {
       return request;
   }
};
