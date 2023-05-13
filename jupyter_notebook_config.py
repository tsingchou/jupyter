import os

c = get_config()  # noqa: F821
c.NotebookApp.ip = "*"
c.NotebookApp.port = 8889
c.NotebookApp.open_browser = False
c.NotebookApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$aru82opY6iOjADgm1h/3sg$C5Kyr1qp8cZVKFTJmdHqFUn1HIJhrERUZe0QZbL4NeQ' # Cjjc65187963*
# 如果需要改密码，可以在python终端输入以下命令：
# >>> from notebook.auth import passwd
# >>> passwd()
# Enter password: 
# Verify password: 
# 将生成的密文粘贴到上面
c.NotebookApp.allow_password_change = True 
c.NotebookApp.allow_remote_access = True
c.NotebookApp.notebook_dir="/home/jovyan/work"
# https://github.com/jupyter/notebook/issues/3130
c.FileContentsManager.delete_to_trash = False

if "NB_UMASK" in os.environ:
    os.umask(int(os.environ["NB_UMASK"], 8))