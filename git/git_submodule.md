// 添加Git submodule仓库
git submodule add <remote_url> <local_path>

// 对于clone一个有submodule的仓库，是不会把submodule也clone下来
// 需要额外的步骤:
// 1. 注册submodule到.git/config里
git submodule init
// 2. clone submodule
git submodule update --recursive
// 上面两步等价于下面
git submodule update --init --recursive

// 如果修改了.gitmodule的remote url，使用下面的命令更新submodule的remote url
git submodule sync
