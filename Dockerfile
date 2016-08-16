#Nico~Nico~Ni~
#如果你要添加自定义主题，可以把26行的网址改成GitHub主题克隆网址
#node0.10,ghost0.7.4,中文
FROM node:4.2-slim
#使用apt-get安装必备软件包
RUN apt-get update \
 && apt-get install -y zip \
 && apt-get install -y git \
 && apt-get install -y nodejs \
 && apt-get install -y wget
#调试用，查看node版本
RUN node -v
#变量定义Ghost路径
ENV GHOST_SOURCE /usr/src/ghost
#创建Ghost路径
RUN mkdir $GHOST_SOURCE
#切换工作目录到Ghost路径
WORKDIR $GHOST_SOURCE
#从官网下载文件包
RUN wget http://dl.ghostchina.com/Ghost-0.7.4-zh-full.zip
#解压文件包
RUN unzip Ghost-0.7.4-zh-full.zip
#替换config.js
RUN rm config.example.js
COPY config.example.js $GHOST_SOURCE/config.example.js
#添加自定义主题
#RUN cd content && cd themes && git clone https://github.com/xw-hjl/Aqours.git && cd .. && cd ..
#进行npm安装
RUN npm install --production
#设置环境
ENV GHOST_CONTENT /usr/src/ghost/content
VOLUME $GHOST_CONTENT
#配置端口
EXPOSE 2368
#配置启动脚本
CMD ["npm", "start"]
