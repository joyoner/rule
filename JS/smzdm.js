var result = JSON.parse($response.body);

delete result.data.rows;

$done(JSON.stringify(result));
