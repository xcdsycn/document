#!/bin/bash
echo "==== 命令开始执行 ======"
for dir in `ls -d */ | grep core- `;
do
  echo '========'$dir'========'
  cd $dir;
  $*;
  cd ..;
done
for dir in `ls -d */ | grep mgzf- `;
do
  echo '========'$dir'========'
  cd $dir;
  $*;
  cd ..;
done
echo "=== 命令执行完毕 === "