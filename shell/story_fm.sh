CNT=1
if [ ! -f fm.xml ]; then
  curl -L http://storyfm.cn/feed/episodes -o fm.xml
fi
files=$(xmllint --xpath "/rss/channel/item[position()>last()-$COUNT]/enclosure/@url" fm.xml)
titles=$(xmllint --xpath "/rss/channel/item[position()>last()-$COUNT]/title/text()" fm.xml)

host="$(echo "cat /config/global/resources/default_setup/connection/host/text()" | xmllint --nocdata --shell file.xml | sed '1d;$d')"
if [ ! -f index.html ]; then
  curl https://storyfm.cn/published-stories/ -o index.html
fi
wechat=$(grep 'http://mp.weixin' -m $COUNT index.html)
image_url=$(grep -Eo '<img class="rich_pages" [^>]+ data-s="[^>]+wx_fmt=jpeg"' -m 1 a.html|grep -Eo 'https:.*jpeg')
curl $image_url -o $episode.jpg
