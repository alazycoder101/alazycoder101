# 使用官方的 Ruby 镜像作为基础镜像
FROM ruby:2.7

# 设置工作目录
WORKDIR /usr/src/app

# 安装必要的依赖项，例如编译工具和 DTrace 支持
RUN apt-get update -qq && apt-get install -y build-essential \
    systemtap-sdt-dev \
    libssl-dev \
    libreadline-dev \
    && rm -rf /var/lib/apt/lists/*

# 克隆并安装 DTrace 相关的 Ruby 绑定
RUN git clone https://github.com/chrisa/ruby-dtrace.git /usr/src/dtrace \
    && cd /usr/src/dtrace \
    && gem build ruby-dtrace.gemspec \
    && gem install ruby-dtrace --local

# 下载 Ruby 源代码
RUN curl -L ftp://ftp.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz | tar xz

# 进入 Ruby 源代码目录
WORKDIR /usr/src/app/ruby-2.6.5

# 配置 Ruby 编译选项，启用 DTrace 支持
RUN ./configure --enable-dtrace --prefix=/usr/local

# 编译并安装 Ruby
RUN make -j$(nproc) && make install

# 验证 DTrace 支持是否启用
RUN ruby -r dtrace -e 'puts "DTrace support enabled" if defined?(DTrace::Probe)'

# 清理编译过程中产生的临时文件
RUN cd .. && rm -rf ruby-2.6.5

# 可选：将新安装的 Ruby 设置为默认 Ruby
RUN update-alternatives --install /usr/local/bin/ruby ruby /usr/local/bin/ruby-2.6.5 100

# 可选：设置环境变量，以便使用新安装的 Ruby
ENV PATH=/usr/local/bin:$PATH

# 可选：设置默认的 shell 为 bash
SHELL ["/bin/bash"]

# 容器启动时执行的命令，这里我们只是输出 Ruby 版本信息
CMD ["ruby", "-v"]
