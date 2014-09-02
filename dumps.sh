#!/bin/bash
local=/app/dump
beg_date=$(date -d "3 days ago" +%Y%m%d)
end_date=$(date -d yesterday +%Y%m%d)
mkdir $local/idcdb_$(date -d "3 days ago" +%Y%m%d)~$(date -d yesterday +%Y%m%d)  2> /dev/null
cat $local/dbname.txt |while read dbname; do
        bd=`date -d "$beg_date" +%s`
        ed=`date -d "$end_date" +%s`
for (( i=${bd};i<=${ed};i=i+86400))
do
        DAY=$(date -d @${i} +%Y%m%d)
        tablename=`cat $local/tablename/$dbname.txt`
for j in $tablename
do
j=`echo $j$DAY`
echo "$(date +%F" "%T) Dumping $dbname $j > $local/idcdb_$(date -d "3 days ago" +%Y%m%d)~$(date -d yesterday +%Y%m%d)/$dbname/$dbname-$j.sql"
echo "$(date +%F" "%T) Dumping $dbname $j > $local/idcdb_$(date -d "3 days ago" +%Y%m%d)~$(date -d yesterday +%Y%m%d)/$dbname/$dbname-$j.sql" >> $local/log/idcdb_$(date +%Y%m%d).log
mkdir $local/idcdb_$(date -d "3 days ago" +%Y%m%d)~$(date -d yesterday +%Y%m%d)/$dbname 2> /dev/null
mysqldump -uroot -p4rfv%TGB $dbname $j > $local/idcdb_$(date -d "3 days ago" +%Y%m%d)~$(date -d yesterday +%Y%m%d)/$dbname/$dbname-$j.sql
done
done
done
