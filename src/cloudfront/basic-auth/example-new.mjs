import { Buffer } from 'buffer';

// Define the handler as an async function
export const handler = async (event) => {
    let isAllowedAccess = false;

    console.log('lambda function');
    const request = event.Records[0].cf.request;

    if (request && request.headers && request.headers.authorization) {
        const basicAuthHeader = request.headers.authorization[0].value;
        const authString = 'Basic ' + Buffer.from('admin' + ':' + 'monday1').toString('base64');
        isAllowedAccess = (basicAuthHeader === authString);
    }

    if (!isAllowedAccess) {
        const response = {
            status: '401',
            body: JSON.stringify('no access for you'),
            headers: {
                'www-authenticate': [{ key: 'WWW-Authenticate', value: 'Basic' }],
            },
        };
        return response;
    } else {
        return request;
    }
};

