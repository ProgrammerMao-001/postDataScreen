// 用于配置服务器相关信息
let express = require('express')
let app = express()
let cors = require('cors')
let bodyParser = require('body-parser')
let router = require('./router')

app.use(bodyParser.json());  //配置解析，用于解析json和urlencoded格式的数据
app.use(bodyParser.urlencoded({extended: false}));
app.use(cors())              //配置跨域，必须在路由之前
app.use('/api', router)      //配置路由

app.listen(3003, () => {
    console.log('服务器启动成功。 ---> http://127.0.0.1:3003/api');
})
