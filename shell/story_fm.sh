RSS_URL=http://storyfm.cn/feed/episodes
PUBLISHED_URL=https://storyfm.cn/published-stories/
COUNT=1

if [ ! -f fm.xml ]; then
  curl -L $RSS_URL -o fm.xml
fi


files=$(xmllint --xpath "/rss/channel/item[position()>last()-$COUNT]/enclosure/@url" fm.xml)
read -r -a mp3_files <<< "$files"

if [ ! -f index.html ]; then
  curl $PUBLISHED_URL -o index.html
fi

wechat=$(grep 'http://mp.weixin' -m $COUNT index.html)
read -r -a titles <<< $(xmllint --xpath "/rss/channel/item[position()>last()-$COUNT]/title/text()" fm.xml)

#[[ $url ~ (https://\\[^"\\]+) ]] && echo ${BASH_REMATCH[1]}
for index in "${!mp3_files[@]}"
do
  eval "${mp3_files[index]}"
  #curl -L -O -J $url
  url=$(echo "${wechat[index]}"|grep -Eo 'http[^"]+')
  image_url=$(curl -L $url|grep -Eo '<img class="rich_pages js_insertlocalimg" data-backh="804"[^>]+wx_fmt=jpeg"' -m 1|grep -Eo 'https:.*jpeg')
  echo "image_url="${image_url}""
  curl -L $image_url -o $index.jpg
done
