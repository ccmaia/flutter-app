const serviceUrl = 'https://time.geekbang.org/serv';
const baseUrl = 'https://test.zhinanche.com/api/v2';
const servicePath = {
  'getBannerList': serviceUrl + '/v2/explore//getBannerList', //banner信息
  'getDetail': serviceUrl + '/v1/column/details', //详情
  'login': baseUrl + '/zhinanche-service-c/user/login', //用户登录  post
  'getUserMsg': baseUrl + '/zhinanche-service-c/user', //获取用户信息   get
  'getSMS':baseUrl+'/zhinanche-service-c/common/sms/code',   //获取验证码   post
  'register':baseUrl+"/zhinanche-service-c/user/register",    //用户注册   post
  "uploadFile" : baseUrl + "/zhinanche-job-c/common/file/upload/img",    //上传文件  post
};
