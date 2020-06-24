var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtNcst'; /*URL*/
var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+'BZz6EBT3FI2z6YctK3RC5Bt%2BQMCJADPoq9XD8BD3EyGJPp70ENjacq%2Fj7XoAU7ZUY7SS%2BbqtTDeaTwbgI0jMJQ%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + encodeURIComponent('-'); /**/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/
queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON'); /**/
queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent('20200623'); /**/
queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('0500'); /**/
queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent('98'); /**/
queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent('76'); /**/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
    }
};

xhr.send('');