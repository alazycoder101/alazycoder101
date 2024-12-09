```bash
echo 'my-github-key' > .secret
docker build . --build-arg arg_key=my-secret-key --secret id=github_key,src=./.secret -t myimage
```

```bash
# export image
docker save myimage > myimage.tar
docker save myimage -o myimage.tar

# setup the directory
mkdir -p myimage
docker save myimage | tar xf - -C myimage

docker save myimage | tar x -C myimage
```
