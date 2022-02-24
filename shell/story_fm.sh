HOMEPAGE_URL=https://storyfm.cn/
PUBLISHED_URL=https://storyfm.cn/published-stories/
COUNT=1

if [ ! -f index.html ]; then
  curl $HOMEPAGE_URL -o index.html
fi

if [ ! -f published.html ]; then
  curl $PUBLISHED_URL -o published.html
fi

titles=$(grep -m $COUNT '<h2 class="soundbyte-podcast-progression-title">' index.html|grep -Eo 'E[^<]+')
read -r -a titles <<< "$titles"
links=$(grep -m $COUNT -Eo '<a href="https://storyfm.cn/episodes[^>]+/">' index.html|grep -Eo 'https[^"]+')
read -r -a links <<< "$links"

wechat=$(grep 'http://mp.weixin' -m $COUNT published.html)

for index in "${!titles[@]}"
do
  title= "${titles[index]}"
  link= "${links[index]}"
  #curl -L -O -J $url
  url=$(echo "${wechat[index]}"|grep -Eo 'http[^"]+')
  image_url=$(curl -L $url|grep -Eo '<img class="rich_pages js_insertlocalimg" data-backh="804"[^>]+wx_fmt=jpeg"' -m 1|grep -Eo 'https:.*jpeg')
  echo "image_url="${image_url}""
  curl -L $image_url -o $index.jpg
done
