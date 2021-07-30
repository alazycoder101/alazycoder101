HOMEPAGE_URL=https://storyfm.cn
PUBLISHED_URL=https://storyfm.cn/published-stories/
PAGE=${PAGE:-}
DEBUG=${DEBUG:-}
COUNT=${COUNT:-2}
FETCH=${FETCH:-}
OFFSET=${OFFSET:-0}
PAGE_SIZE=6

if [ ! -z $PAGE ]; then
  HOMEPAGE_URL="${HOMEPAGE_URL}/page/${PAGE}/"
fi

if [[ ! -z $FETCH ]] || [[ ! -f index.html ]]; then
  curl $HOMEPAGE_URL -o index.html
fi

if [[ ! -z $FETCH ]] || [[ ! -f published.html ]]; then
  curl $PUBLISHED_URL -o published.html
fi

MAX_COUNT=$(( PAGE_SIZE*PAGE + COUNT + 2 + OFFSET ))

afirst=$(grep -m 1 '<h2 class="soundbyte-podcast-progression-title">' index.html|grep -Eo 'E[0-9]+'|grep -Eo '[0-9]+')
ifirst=$(grep 'mp.weixin.' -m 1 published.html|grep -Eo 'E[0-9]+'|grep -Eo '[0-9]+' )

istart=$(( ifirst - afirst + OFFSET + 1 ))
astart=$(( ifirst - afirst + OFFSET + 1 ))

if [[ $ifirst > $afirst ]]; then
  istart=$(( ifirst - afirst + OFFSET + 1 ))
else
  astart=$(( afirst - ifirst + OFFSET + 1))
fi

IFS=$'\n' titles=( $(grep -m $MAX_COUNT '<h2 class="soundbyte-podcast-progression-title">' index.html|grep -Eo 'E[^<]+'| tail -n +$astart|head -n $COUNT) )
IFS=$'\n' links=( $(grep -m $MAX_COUNT -Eo '<a href="https://storyfm.cn/episodes[^>]+/">' index.html|grep -Eo 'https[^"]+'| tail -n +$astart|head -n $COUNT) )

IFS=$'\n' wechat=( $(grep 'mp.weixin.' -m $MAX_COUNT published.html| tail -n +$istart| head -n $COUNT) )

if [ ! -z "$DEBUG" ]; then
  printf 'ifirst=%s afirst=%s\n' $ifirst $afirst
  printf 'istart=%s astart=%s\n' $istart $astart
  printf 'MAX_COUNT=%s\n' $MAX_COUNT
  printf 'titles\n'
  printf '%s\n' "${titles[@]}"
  printf 'links\n'
  printf '%s\n' "${wechat[@]}"
fi

for index in "${!wechat[@]}"
do
  title="${titles[index]}"
  echo $index
  echo $title
  episode=${title:0:4}
  link="${links[index]}"
  episode_file="${episode}.html"
  if [ ! -f $episode_file ]; then
    printf 'audiofile:%s\n' $episode_file
    curl -L $link -o $episode_file
  fi
  audio=$(grep -Eo '>https://[^<]+mp3<' $episode.html|grep -Eo 'https://[^<]+mp3')
  audio_file="${episode}.mp3"
  if [ ! -f "$audio_file" ]; then
    curl -L $audio -o $audio_file
  fi

  pub="${wechat[index]}"
  e=${title:0:4}
  image_file="$e.jpg"
  if [ ! -f $image_file ]; then
    url=$(echo "$pub"|grep -Eo 'http[^"]+')
    printf '$pub url: %s\n' $url
    image_url=$(curl -L $url|grep -Eo '<img class="rich_pages( js_insertlocalimg)?" (data-cropselx1|data-backh="804")[^>]+wx_fmt=jpeg"' -m 1|grep -Eo 'https:.*jpeg')
    curl -L $image_url -o $image_file
  fi
  ffmpeg -r 1/5 -f image2 -loop 1 -i $image_file -i $audio_file -c:v libx264 -tune stillimage -c:a aac -b:a 191999 -pix_fmt yuv420p -vf 'pad=width=ceil(iw/2)*2:height=ceil(ih/2)*2' -shortest "$title.mp4"
done
