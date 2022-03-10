XML_URL=https://storyfm.cn/published-stories/
DEBUG=${DEBUG:-}
COUNT=${COUNT:-2}
FETCH=${FETCH:-}
OFFSET=${OFFSET:-0}

if [[ ! -z $FETCH ]] || [[ ! -f episode.xml ]]; then
  curl $XML_URL -o episode.xml
fi

# <p>E606.<a href="https://mp.weixin.qq.com/s/wcwqgcBVAVL8vQbyAYfJOw">我们在元宇宙里谈恋爱</a></p>
regex="<p>(E[0-9]+).<a href=\"(.+)\">(.*)</a></p>"
IFS=$'\n' items=( $(grep -m $COUNT -Eo '<p>E[0-9]*.<a href=".*</p>' episode.xml) )

if [ ! -z "$DEBUG" ]; then
  printf 'items\n'
  printf '%s\n' "${items[@]}"
fi

for index in "${!items[@]}"
do
  item="${items[$index]}"
  echo "$index $item"
  if [[ $item =~ $regex ]]; then
    episode="${BASH_REMATCH[1]}"
    episode=${episode:0:4}
    link="${BASH_REMATCH[2]}"
    title="$episode.${BASH_REMATCH[3]}"
    echo "${name}"    # concatenate strings
    episode_file="${episode}.html"
    w_file="${episode}.html"
    if [ ! -f $episode_file ]; then
      printf 'audiofile:%s\n' $episode_file
      curl -L $link -o $episode_file
    fi
    audio_id=$(grep -Eo 'voice_encode_fileid="[^"]+"' $episode.html|grep -Eo '"[^"]+"')
    audio_id="${audio_id:1:${#audio_id}-2}"
    audio="https://res.wx.qq.com/voice/getvoice?mediaid=$audio_id"
    # Request URL: https://res.wx.qq.com/voice/getvoice?mediaid=Mzk0MDIwNTQxN18yMjQ3NTExNDU4
    # <mpvoice class="js_editor_audio audio_iframe js_uneditable" src="/cgi-bin/readtemplate?t=tmpl/audio_tmpl&amp;name=%E6%88%91%E4%BB%AC%E5%9C%A8%E5%85%83%E5%AE%87%E5%AE%99%E9%87%8C%E8%B0%88%E6%81%8B%E7%88%B1&amp;play_length=32:48" isaac2="1" low_size="3871.81" source_size="3891.2" high_size="15388.62" name="我们在元宇宙里谈恋爱" play_length="1968000" voice_encode_fileid="Mzk0MDIwNTQxN18yMjQ3NTExNDU4" data-topic_id="" data-topic_name="" data-pluginname="insertaudio" data-trans_state="1" data-verify_state="3" style="visibility: visible;"></mpvoice>

    audio_file="${episode}.mp3"
    if [ ! -f "$audio_file" ]; then
      if [ -z $audio ]; then
        echo "Fail to get audio url"
        exit
      fi
      curl -L $audio -o $audio_file
    fi

    pub="${wechat[index]}"
    if [ ! -f $w_file ]; then
      curl -L $url -o $w_file
    fi
    image_url=$(grep -Eo '<img class="rich_pages( wxw-img)?( js_insertlocalimg)?( custom_select_img)?" ((data-cropselx1|data-backh)="8[0-9]+")[^>]+wx_fmt=(jpeg|png)"' -m 1 $w_file|grep -Eo 'https:.*(jpeg|png)')
    ext=${image_url:(-3)}
    image_file="$episode.$ext"
    if [ ! -f $image_file ]; then
      url=$(echo "$pub"|grep -Eo 'http[^"]+')
      printf '$pub url: %s\n' $url
      # <img class="rich_pages wxw-img" data-backh="804" data-backw="562" data-cropselx1="0" data-cropselx2="562" data-cropsely1="0" data-cropsely2="804" data-ratio="1.4305555555555556" data-s="300,640" data-src="https://mmbiz.qpic.cn/mmbiz_png/dhkrmSXEeyB3icRI4ZlHsA6BYPibkDMyaCyiaAhdTSWTRqUvzUbObicx4zVPujlMq9rndTfq7V0SnVJicc1YvQuicTQw/640?wx_fmt=png" data-type="png" data-w="1008" style="visibility: visible !important; width: 100% !important; height: auto !important;" _width="100%" src="https://mmbiz.qpic.cn/mmbiz_png/dhkrmSXEeyB3icRI4ZlHsA6BYPibkDMyaCyiaAhdTSWTRqUvzUbObicx4zVPujlMq9rndTfq7V0SnVJicc1YvQuicTQw/640?wx_fmt=png&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1" crossorigin="anonymous" alt="Image" data-fail="0">
      if [ -z $image_url ]; then
        echo "Fail to get image url"
        exit
      fi
      curl -L $image_url -o $image_file
    fi
    # ffmpeg -r 1/5 -f image2 -loop 1 -i E604.jpg -i E604.mp3 -c:v libx264 -tune stillimage -c:a aac -b:a 64000 -pix_fmt yuv420p -vf 'pad=width=ceil(iw/2)*2:height=ceil(ih/2)*2' -t 2218.840750 -shortest E604.mp4
    ffmpeg -r 1/5 -f image2 -loop 1 -i $image_file -i $audio_file -c:v libx264 -tune stillimage -c:a aac -b:a 64000 -pix_fmt yuv420p -vf 'pad=width=ceil(iw/2)*2:height=ceil(ih/2)*2' -shortest "$title.mp4"
  else
    echo "$item doesn't match" >&2 # this could get noisy if there are a lot of non-matching files
  fi
done
