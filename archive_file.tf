data "archive_file" "lambda_function" {
  type = "zip"
  source_content = <<EOF
'use strict';

exports.${var.lambda_handler_name} = (event, context, callback) => {
  const request = event.Records[0].cf.request;
  const clientIp = request.clientIp

  if (['${join("', '", var.whitelist_ip)}'].includes(clientIp)) {
    callback(null, request);
    return;
  }

  const headers = request.headers;
  const username = '${var.basic_auth_username}';
  const password = '${var.basic_auth_password}';
  const authString = 'Basic ' + new Buffer(username + ':' + password).toString('base64');
  const authorized = headers.authorization && (headers.authorization[0].value == authString);

  if (authorized) {
    callback(null, request);
  }
  else {
    const response = {
      status: '401',
      statusDescription: 'Unauthorized',
      body: 'Unauthorized',
      headers: {
        'www-authenticate': [{key: 'WWW-Authenticate', value: 'Basic'}]
      },
    };
    callback(null, response);
  }
};
EOF
  source_content_filename = "${var.lambda_function_name}.js"
  output_path = "${path.module}/files/lambda_function.zip"
}
