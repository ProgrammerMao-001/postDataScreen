module.exports = {
    devServer: {
        host: "0.0.0.0", //启动后的host地址
        port: 80, //项目启动后的端口号
        open: false, //启动时自动打开浏览器
        proxy: {
            "/api": {
                target: "http://127.0.0.1:3003/api/",
                ws: true,
                changeOrigin: true, // 开启跨域,在本地创建一个虚拟服务,然后发送请求的数据,并同时接收请求的数据,这样服务端和服务端进行数据交互就不会有问题
                pathRewrite: {
                    "^/api": '', // 利用这个地面的值拼接上target里面的地址
                },
            },
        },
    },
    lintOnSave: false
}
