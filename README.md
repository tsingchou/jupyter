# jupyter
## 已将apt-get源配置为```阿里云```，pip源配置为```清华```
## 修改密码：
默认密码```Cjjc65187963*```, 如果需要改密码，可以在python终端输入以下命令：
```
# >>> from notebook.auth import passwd
# >>> passwd()
# Enter password: 
# Verify password: 
```
将生成的密文放置到```jupyter_notebook_config.py```中的秘文处：```c.NotebookApp.password = '秘文'```
## 构建并运行 
```docker-compose up```
## 重新构建并运行 
```docker-compose up --build```
## 运行
运行端口为8889
```http://localhost:8889```
## 其他
```docker exec```进入容器为root权限，jupyter中为用户权限
