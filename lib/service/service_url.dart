const serviceUrl = 'https://time.geekbang.org/serv';
const baseUrl = 'https://test.zhinanche.com/api/v2';
const servicePath = {
  'getBannerList': serviceUrl + '/v2/explore//getBannerList', //banner信息
  'getDetail': serviceUrl + '/v1/column/details', //详情
  'login': baseUrl + '/zhinanche-main/user/login', //用户登录  post
  'getUserMsg': baseUrl + '/zhinanche-service-c/user', //获取用户信息   get
  'getSMS':baseUrl+'/zhinanche-service-c/common/sms/code',   //获取验证码   post
  'register':baseUrl+"/zhinanche-main/user/register",    //用户注册   post
  "uploadFile" : baseUrl + "/zhinanche-job-c/common/file/upload/img",    //上传文件  post
  "uploadVideo" : baseUrl + "/zhinanche-service-c/common/file/upload/video",    //上传文件  post
  "chooseUserMsg" : baseUrl + "/zhinanche-service-c/user",      // 修改用户信息   put
  "forgertPass": baseUrl+ "/zhinanche-main/user/password/re",    //忘记密码找回   put
  "choosePass" : baseUrl + "/zhinanche-main/user/password",  //修改密码   put
  "choosePhone": baseUrl + "/zhinanche-main/user/username",   //修改手机号码   put
  "getbannerList": baseUrl+"/zhinanche-main/common/banner/3",    //获取社区banner图  get
  "getthreadList": baseUrl+"/zhinanche-app/thread",               //获取帖子列表    get
  "upLoadThread": baseUrl + "/zhinanche-app/thread",              //发布帖子   post
  "replyThread": baseUrl + "/zhinanche-app/thread" ,              //回复帖子   post
  "getThreadPlate": baseUrl+"/zhinanche-app/common/dict/thread/plate",         //帖子板块  get
  "searchThrem": baseUrl+"/zhinanche-app/thread/search",            //搜索帖子   post
  "getThreamInfo": baseUrl+'/zhinanche-app/thread',          //获取帖子详情   get
  "replyThream":baseUrl+'/zhinanche-app/thread',             //评论帖子  post
  "likethreamOrReply":baseUrl+'/zhinanche-app/thread',          //点赞帖子或评论
  "getMyThread": baseUrl+"/zhinanche-app/user/thread",    //我的帖子   get
  "getMyReply": baseUrl+"/zhinanche-app/user/thread/reply",    //我的回复   get
  "getUpdate": baseUrl+"/zhinanche-app/apk/update/latest", //更新app
  "getInteractive": baseUrl+"/zhinanche-app/system/info/interactive", //更新app
};
