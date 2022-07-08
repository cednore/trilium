# Contributing

Please submit your issues and pull requests directly on [this repo](https://github.com/cednore/trilium). Please do
consider followings when you are opening;

1. This project is not a fork of and not related to [`trilium`](https://github.com/zadam/trilium) source code. It only
   uses pre-built [docker image](https://hub.docker.com/r/zadam/trilium).
2. I use this repo to provide a boilerplate and also, to manage my own trilium hosting. Please don't submit changes
   might affect my infrastructure.
3. Output of this terraform project contains sensitive information related to my infrastructure, and is being gitignored
   and removed from all CI/CD outputs. If you found any sensitive data leak, please send an email to
   **cednore@gmail.com** or submit an [issue](https://github.com/cednore/trilium/issues) and attach
   [`security`](https://github.com/cednore/trilium/labels) label.
4. Please follow [`gitmoji`](https://gitmoji.dev/) standard when you are making commits for PR.
