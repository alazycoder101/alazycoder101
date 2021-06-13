HOMEPAGE_URL=https://storyfm.cn/
PUBLISHED_URL=https://storyfm.cn/published-stories/
COUNT=2

if [ ! -f index.html ]; then
  curl $HOMEPAGE_URL -o index.html
fi

if [ ! -f published.html ]; then
  curl $PUBLISHED_URL -o published.html
fi

titles=( $(grep -m $COUNT '<h2 class="soundbyte-podcast-progression-title">' index.html|grep -Eo 'E[^<]+') )
#read -r -a titles <<< "$titles"
echo $titles
links=( $(grep -m $COUNT -Eo '<a href="https://storyfm.cn/episodes[^>]+/">' index.html|grep -Eo 'https[^"]+') )
#read -r -a links <<< "$links"
echo $links

IFS=$'\r\n' wechat=( $(grep 'http://mp.weixin.' -m $COUNT published.html) )
echo $wechat

for index in "${!titles[@]}"
do
  title="${titles[index]}"
  episode=${title:0:4}
  link="${links[index]}"
  episode_file="${episode}.html"
  if [ ! -f $episode_file ]; then
    curl -L $link -o $episode_file
  fi
  audio=$(grep -Eo '>https://[^<]+mp3<' $episode.html|grep -Eo 'https://[^<]+mp3')
  echo $audio
  audio_file="${episode}.mp3"
  if [ ! -f "$audio_file" ]; then
    curl -L $audio -o $audio_file
  fi
  pub="${wechat[index]}"
  echo $pub
  e=$(echo "$pub"|grep -m1 -Eo 'E[0-9]+')
  url=$(echo "$pub"|grep -Eo 'http[^"]+')
  image_url=$(curl -L $url|grep -Eo '<img class="rich_pages js_insertlocalimg" data-backh="804"[^>]+wx_fmt=jpeg"' -m 1|grep -Eo 'https:.*jpeg')
  echo "image_url="${image_url}""
  curl -L $image_url -o $e.jpg
done
