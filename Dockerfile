# 声明镜像基础
FROM nginx
# 声明维护者
LABEL author=tanmh
# 声明版本
LABEL version="1.0.0"
# 删除nginx初始配置文件
RUN rm /etc/nginx/conf.d/default.conf
# 添加配置文件
ADD default.conf /etc/nginx/conf.d/
# 复制打包后的文件到html目录下
COPY dist/k8sj /usr/share/nginx/html/