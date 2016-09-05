# traverse_area_number
从www.114best.com爬取取号

# 配置
./conf/area_number_list.conf
每行配置一个待爬取的区号

# 运行
1. sh run.sh step1
2. 下载label.txt(sz data/label.txt)， 添加图片对应的标注(在第6列添加对应的明文)
3. 拷贝excel中全部内容至本地环境的data/label.res
4. sh run.sh step2
5. 下载final.txt(sz finale.txt)，用excel打开即可

如有任何问题， 请联系 zhaodw@outlook.com
