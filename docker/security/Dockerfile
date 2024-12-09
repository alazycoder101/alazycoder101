FROM alpine
ARG arg_key
ENV env_key=45678
RUN export EXPORT_KEY=123455 ls
RUN INLINE_KEY=123456 ls
RUN echo $arg_key
RUN --mount=type=secret,id=github_key,required=true \
    export GITHUB_KEY="$(cat /run/secrets/github_key)" && echo 'this is safe'
RUN --mount=type=secret,id=github_key,required=true \
    GITHUB_KEY="$(cat /run/secrets/github_key)" echo 'this is safe without export'
