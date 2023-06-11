# 使用jupyter/scipy-notebook作为基础镜像
FROM jupyter/scipy-notebook

# 复制当前目录下的所有文件到容器中的/home/jovyan/work目录
COPY . /home/jovyan/work

# 设置工作目录为/home/jovyan/work
WORKDIR /home/jovyan/work

# 安装pygithub3和pandas两个库
RUN pip install pygithub3 pandas

# 创建一个名为default.ipynb的jupyter文件，并写入代码
RUN jupyter nbconvert --to notebook --execute --output default.ipynb --template basic <(echo '{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pygithub3\\n",
    "import pandas as pd\\n",
    "\\n",
    "# 使用访问令牌创建 Github 对象\\n",
    "gh = pygithub3.Github(login_or_token=\'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\')\\n",
    "# 获取 Repository 对象\\n",
    "repo = gh.get_repo(\'alibaba/EasyParallelLibrary\')\\n",
    "\\n",
    "# 获取贡献者列表\\n",
    "contributors = repo.get_contributors()\\n",
    "\\n",
    "# 创建空列表存储姓名和邮箱\\n",
    "names = []\\n",
    "login_names = []\\n",
    "contributions = []\\n",
    "companies = []\\n",
    "emails = []\\n",
    "blogs = []\\n",
    "locations = []\\n",
    "\\n",
    "# 遍历贡献者列表\\n",
    "for contributor in contributors:\\n",
    " # 获取姓名和邮箱\\n",
    " name = contributor.name\\n",
    " login_name = contributor.login\\n",
    " email = contributor.email\\n",
    " contribution = contributor.contributions\\n",
    " blog = contributor.blog\\n",
    " company = contributor.company\\n",
    " location = contributor.location\\n",
    "\\n",
    " # 添加到列表中\\n",
    " names.append(name)\\n",
    " emails.append(email)\\n",
    " blogs.append(blog)\\n",
    " contributions.append(contribution)\\n",
    " companies.append(company)\\n",
    " locations.append(location)\\n",
    " login_names.append(login_name)\\n",
    "\\npd.set_option(\'display.max_rows\', None)\\n",
    "# 创建 DataFrame 对象并显示表格\\n",
    "df = pd.DataFrame({\'Name\': names, \'LoginName\': login_names, \'Company\': companies, \'Location\': locations, \'Contribution\': contributions, \'Email\': emails, \'Blog\': blogs})\\n"
    "# 将表格保存为output.xlsx文件\n"
    "df.to_excel("./output.xlsx")"
    "df"
   ]
  }
 ],
"metadata": {
  },
"nbformat": 4,
"nbformat_minor": 4
}')
