# 使用jupyter/scipy-notebook作为基础镜像
FROM jupyter/scipy-notebook

# 复制当前目录下的所有文件到容器中的/home/jovyan/work目录
COPY . /home/jovyan/work

# 设置工作目录为/home/jovyan/work
WORKDIR /home/jovyan/work

# 安装pygithub3和pandas两个库
RUN pip install Github github pygithub pandas

# 创建一个默认的jupyter文件，名为default.ipynb，内容可以根据你的需求修改
RUN echo '{"cells":[{"cell_type":"code","execution_count":null,"metadata":{},"outputs":[],"source":["import pandas as pd\\n","import pygithub3\\n","# 这里写你的代码，生成一个output.xlsx文件"]}],"metadata":{"kernelspec":{"display_name":"Python 3","language":"python","name":"python3"},"language_info":{"codemirror_mode":{"name":"ipython","version":3},"file_extension":".py","mimetype":"text/x-python","name":"python","nbconvert_exporter":"python","pygments_lexer":"ipython3","version":"3.9.7"}},"nbformat":4,"nbformat_minor":5}' > default.ipynb

# 设置jupyter的配置，允许外部访问，不需要密码或者token
RUN echo "c.NotebookApp.allow_origin = '*'\nc.NotebookApp.ip = '0.0.0.0'\nc.NotebookApp.open_browser = False\nc.NotebookApp.password = ''\nc.NotebookApp.token = ''" > /home/jovyan/.jupyter/jupyter_notebook_config.py

# 设置启动时运行default.ipynb文件
RUN echo "c.NotebookApp.default_url = '/notebooks/default.ipynb'" >> /home/jovyan/.jupyter/jupyter_notebook_config.py
