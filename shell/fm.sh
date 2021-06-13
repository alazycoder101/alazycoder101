HOMEPAGE_URL=https://storyfm.cn/
PUBLISHED_URL=https://storyfm.cn/published-stories/
COUNT=6

if [ ! -f index.html ]; then
  curl $HOMEPAGE_URL -o index.html
fi

if [ ! -f published.html ]; then
  curl $PUBLISHED_URL -o published.html
fi

titles=( $(grep -m $COUNT '<h2 class="soundbyte-podcast-progression-title">' index.html|grep -Eo 'E[^<]+') )
links=( $(grep -m $COUNT -Eo '<a href="https://storyfm.cn/episodes[^>]+/">' index.html|grep -Eo 'https[^"]+') )

IFS=$'\r' wechat=( $(grep 'mp.weixin.' -m $COUNT published.html) )
# check matchment
e=$(echo "${wechat[0]}"|grep -m1 -Eo 'E[0-9]+'|grep -Eo '[0-9]+')
episode=${titles[0]:1:3}
echo $wechat
if [ "$e" -lt "$episode" ]; then
  diff=$(( episode - e ))
  for (( i=0; i<$diff; i++ )); do
    unset titles[$i]
    unset links[$i]
    #links=("${links[@]:$diff}")
    #echo ${#titles[@]}
  done
fi

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
  echo $e
  echo $episode
  url=$(echo "$pub"|grep -Eo 'http[^"]+')
  image_url=$(curl -L $url|grep -Eo '<img class="rich_pages js_insertlocalimg" data-backh="804"[^>]+wx_fmt=jpeg"' -m 1|grep -Eo 'https:.*jpeg')
  echo "image_url="${image_url}""
  curl -L $image_url -o $e.jpg
  ffmpeg -r 1/5 -f image2 -loop 1 -i $e.jpg -i $audio_file -c:v libx264 -tune stillimage -c:a aac -b:a 191999 -pix_fmt yuv420p -vf 'pad=width=ceil(iw/2)*2:height=ceil(ih/2)*2' -shortest "$title.mp4"
done
