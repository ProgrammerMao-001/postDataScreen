# 依赖
```
1. multer
2. mysql
3. svg-captcha
```

#接口
```
0. 验证码（√）

1. 登陆、注册（√）
username    用户名
password    密码
headimg     头像
token       token
role        用户角色
roleid      用户角色id
id

2. 图片上传（√）

3. 人员模块（即用户）（√）
    3.1  人员列表（搜索）
    3.2  新增人员
    3.3  编辑人员
    3.4  删除人员

4. 角色模块 （√）
name
id
pid
    4.1  角色列表
    4.2  通过角色搜索用户

5. 路由模块（√）
name
url
icon
id
pid
type
    5.1  获取路由列表

6. 打卡模块 
datetime    打卡时间
username    用户名
userid      用户id
headimg     头像
id          
isgood      是否健康
whatfeel    否 （什么感觉）
isout       是否出省
outwhere    是  （去的地点）
outtime     是  （去的时间）
    6.1  打卡列表（查询）  
    6.2  新增打卡记录
    6.3  编辑打卡记录
    6.4  删除打卡记录 

7.  确诊人模块 definitelist（√）
id
name            确诊人（单个）
namephone       确诊人联系方式
namein          确诊人隔离地点
namewhere       确诊人居住地
staticname      密接人（单个）
staticphone     密接人联系方式
staticin        密接人隔离地点
staticwhere     密接人居住地
    7.1  确诊人列表（查询）
    7.2  新增确诊人
    7.3  编辑确诊人
    7.4  删除确诊人

8.  疫苗模块 hospitallist
areaid      地区id
hname       医院名称
firstnum    第一针疫苗数
secondnum   第二针疫苗数
thirdnum    第三针疫苗数量
id
    8.1  疫苗列表（查询）
    8.2  新增疫苗   
    8.3  编辑疫苗
    8.4  删除疫苗
```

