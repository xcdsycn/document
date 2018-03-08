#!/bin/bash
cd /home/mogo/.jenkins/workspace/core-all-ssh/
count_branch(){
branch=$1
source ./swich_branch.sh git checkout $branch
source ./swich_branch.sh git pull
echo "==== 统计开始执行 分支：$branch======"
i=0
for dir in `ls -d */ | grep mgzf- `;
do
  dir=${dir%/} 
  dirStr='========'$dir'========'
  echo $dirStr
  cd $dir;
  currentLines=$(git log --pretty=tformat: --since=$yestoday --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 + $2 } END { printf "%s,%s,%s",add,subs,loc }')
  gitLines=$(find . -name "*.java" |xargs wc -l | gawk '{ add += $1 ; } END { printf "%s",add }')
  if [ "$gitLines" -gt "${total[i]}" ] 
  then
     total[i]=$gitLines 
  fi
 
  retLine=$curentLines" 昨日代码行数: $gitLines"
  echo "=== $retLine === 新 ${total[i]}"
  add=$(echo $currentLines | cut -f 1 -d ,)
  sub=$(echo $currentLines | cut -f 2 -d ,)
  if [ -z $add ]
  then
    add=0
  fi
  if [ -z $sub ]
  then
    sub=0
  fi
  ((cur_total=add + sub))
  echo "=== add values of : $add , $sub , $cur_total ------------- ==="
  : $((array_modules[i*3]= ${array_modules[i*3]} + add ))
  : $((array_modules[i*3+1]= ${array_modules[i*3+1]} + sub))
  : $((array_modules[i*3+2]= ${array_modules[i*3+2]} + cur_total ))
  arr1=${array_modules[i*3]}
  arr2=${array_modules[i*3+1]}
  arr3=${array_modules[i*3+2]}
  #arr1=$([ $arr1 -eq 0 ] && echo -e "<span style='color:red'>$arr1</span>"||echo -e "<span style='color:green'>$arr1</span>")
  #arr2=$([ $arr2 -eq 0 ] && echo -e "<span style='color:red'>$arr2</span>"||echo -e "<span style='color:green'>$arr2</span>")
  #arr3=$([ $arr3 -eq 0 ] && echo -e "<span style='color:red'>$arr3</span>"||echo -e "<span style='color:green'>$arr3</span>")
  #messages[i]="$i: $dir - 新增:$arr1,删除:$arr2,更新总计:$arr3,总代码行数：<span style='font-weight:bold'>${total[i]}</span>" 
  messages[i]="$i : $dir\t - 总代码行数：${total[i]}" 
  #messages[i]="====================================== $i:$dir-新增:"$arr1",删除:"$arr2",更新总计:"$arr3",总代码行数：${total[i]}" 
  sql="insert into test.mogo_git(stat_date_str,stat_add,stat_sub,stat_total,module,total) values('$yestoday',$add,$sub,$cur_total,'$dir',${total[i]});";
  echo "=== insert sql: $sql"
  if [ "$branch_i" -gt 0 ]
  then
    sql="update test.mogo_git set stat_add=$add,stat_sub=$sub,stat_total=$cur_total,total=${total[i]} where stat_date_str='$yestoday' and module='$dir';"  
    echo "=== update the day : $sql "
  fi
  $MYSQL -e "$sql"
  #echo -e $retLine

  #message=$message$dirStr"\n"$retLine
  cd ..;
  let "i=$i+1" 
done
let "branch_i=$branch_i+1"
#echo -e $message
echo "=== 统计执行完毕 === "
}

branches=(dev_20170830007 dev_20170920003)
branch_i=0
array_modules=()
messages=()
plots=()
MYSQL="mysql -h192.168.30.164 -uroot -pmogojiayou --default-character-set=utf8 -A -N"
yestoday=$(date +%Y-%m-%d --date='-1 day')
hist=$(date +%Y-%m-%d --date='-14 day')
total=(0 0 0 0 0 0 0 )
#clear data yestody
email="$yestoday GIT提交代码行统计结果如下:\n"
del_sql="delete from test.mogo_git where stat_date_str='$yestoday';"
echo "=== 删除昨日数据：$del_sql"
$MYSQL -e "$del_sql"

for dev_branch in ${branches[@]} 
do 
  count_branch $dev_branch
done
echo "=== 输出统计信息 ==="
for message in "${messages[@]}"
do
  echo -e $message
  email=$email"\n"$message
done
echo "=== 输出文本统计信息 ==="
selectSql="select * from test.mogo_git where stat_date_str='$yestoday';"
echo "=== 查询 ： $selectSql"
yestoday_data=$($MYSQL -e "$selectSql")
echo "=== 从数据库中查询到的数据生成统计 ==="
echo -e "$yestoday_data" | sed 's/\t/ /g'> plot_data.txt
cat git_plot.conf |gnuplot
echo "=== 生成历史数据统计 ==="
#for dir in `ls -d */ | grep mgzf- `;
#do
 # dir=${dir%/}
  #his_sql="select stat_date_str,module,stat_add from mogo_git ORDER BY stat_date_str, module;"
  his_sql="select stat_date_str,(select stat_add from test.mogo_git where module='mgzf-arch' and stat_date_str=o.stat_date_str) as mgzf_arch,\
(select stat_add from test.mogo_git where module='mgzf-cust' and stat_date_str=o.stat_date_str) as mgzf_cust,\
(select stat_add from test.mogo_git where module='mgzf-fina' and stat_date_str=o.stat_date_str) as a_fina ,\
(select stat_add from test.mogo_git where module='mgzf-flat' and stat_date_str=o.stat_date_str) as a_flat ,\
(select stat_add from test.mogo_git where module='mgzf-sale' and stat_date_str=o.stat_date_str) as a_sale ,\
(select stat_add from test.mogo_git where module='mgzf-supp' and stat_date_str=o.stat_date_str) as a_supp ,\
(select stat_add from test.mogo_git where module='mgzf-tp' and stat_date_str=o.stat_date_str) as a_tp  
from test.mogo_git o group by stat_date_str ORDER BY  stat_date_str;"
  #echo "=== 查询语句: $his_sql ==="
  hist_data=$($MYSQL -e "$his_sql")
  echo -e "$hist_data" | sed 's/\t/ /g' > plot_data.txt
  source git_plot_hist.sh "hist_git"
#done

pics=""
for png in `ls hist*.png`
do
  pics=$pics" -a $png "
done
current=$(date '+%Y-%m-%d %H:%M:%S')
#echo -e $email | mailx -s "GIT代码库提交数量统计-- $current$( echo -e "\nContent-Type: text/html")" -a yestoday.png $pics  xcdsy@aliyun.com
#echo -e $email | mailx -s "GIT代码库提交数量统计-- $current" -a yestoday.png $pics  xcdsy@aliyun.com
#title=`echo -e "mgzf代码码库昨日提交代码行(LOC)统计-- $current\nContent-Type: text/html;"`
#echo -e $email | mailx  -a 'Content-Type: text/html' -s "GIT代码库提交数量统计-- $current" -a hist_git.png   xcdsy@aliyun.com
echo -e $email | mailx   -s "GIT代码库提交数量统计-- $current" -a hist_git.png   xcdsy@aliyun.com,sc@mogoroom.com,zhugongping@mogoroom.com,guowei@mogoroom.com,wangyan@mogoroom.com,dongxuzhou@mogoroom.com,commitment@mogoroom.com,andubu@mogoroom.com,yuanbingqiu@mogoroom.com
#echo -e $email | mailx -s "$title" xcdsy@aliyun.com,sc@mogoroom.com,zhugongping@mogoroom.com,guowei@mogoroom.com,wangyan@mogoroom.com,dongxuzhou@mogoroom.com,commitment@mogoroom.com,andubu@mogoroom.com,yuanbingqiu@mogoroom.com
