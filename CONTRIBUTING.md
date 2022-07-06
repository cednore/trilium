# Contributing

Please submit your issues and pull requests directly on [this repo](https://github.com/cednore/trilium). Please do
consider followings when you are opening;

1. This project is not a fork of and not related to [`trilium`](https://github.com/zadam/trilium) source code. It only
   uses pre-built [docker image](https://hub.docker.com/r/zadam/trilium).
2. I (@cednore) uses this repo to provide a boilerplate and also, to manage my own trilium hosting. Please don't submit
   changes might affect my infrastructure.
3. Output of this terraform project contains sensitive information related to my (@cednore's) infrastructure, and is
   being gitignored and removed from all CI/CD outputs. If you found any sensitive data leak, please submit an issue and
   attach [`security`](https://github.com/cednore/trilium/labels) label.
