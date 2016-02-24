function ajaxCallback(url, query, callback, method) {
  headers = {};
  if (method === undefined) {
    method = 'POST';
    headers['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
  }
  $.ajax({
    url: "http://localhost:3000/" + /*location.protocol + '//' + location.host +*/ url,
    headers: headers,
    data: query,
    type: method,
    contentType: 'application/json; charset=UTF-8',
    dataType: 'json',
    success: function(response) {
      callback(response);
    }
  });
}

function ajaxFormPost(url, query, callback) {
  headers = {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')};
  $.ajax({
    url: "http://localhost:3000/" + /*location.protocol + '//' + location.host +*/ url,
    headers: headers,
    data: query,
    type: 'POST',
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    dataType: 'json',
    success: function(response) {
      callback(response);
    }
  });
}