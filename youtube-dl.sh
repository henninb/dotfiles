#!/bin/sh

# pip show youtube-dl > /dev/null
# if [ $? -ne 0 ]; then
#   pip install youtube-dl --user
# else
#   pip install -U youtube-dl --user
#fi

python3 -m pip install --upgrade pip
python3 -m pip install --user --upgrade youtube-dl

youtube-dl --version

echo "Press enter to continue"
read -r x
echo "$x" > /dev/null

if [ "$OS" = "CentOS Linux" ]; then
  sudo yum install epel-release -y
  sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
  sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
  sudo yum install -y ffmpeg #ffmpeg-devel
fi

mkdir -p media

fun_download() {
  base=$(echo "$2" | cut -f 1 -d '.')
  if [ ! -f "media/${base}.mp3" ]; then
    if youtube-dl -q -f bestaudio --extract-audio "$1" --output "media/$2"; then
      echo "ffmpeg -nostats -loglevel 0 -i media/$2 media/${base}.mp3"
      if ffmpeg -nostats -i "media/$2" "media/${base}.mp3"; then
        rm "media/$2"
      fi
    else
      echo failed
    fi
  else
    echo "'$base.mp3' already exists."
  fi
}

song='soul_asylum_runaway_train'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='dave_matthews_band_crash_into_me'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

#youtube-dl -F https://youtu.be/d8ERTCVXIUE
# fun_download 'https://www.youtube.com/watch?v=Nim4_f5QUxA' vim_training_class1.opus
# fun_download 'https://www.youtube.com/watch?v=2pqipq-UEwQ' vim_training_class2.opus
# fun_download 'https://www.youtube.com/watch?v=02_H3LjqMr8' haskell_tutorial.opus
# fun_download 'https://www.youtube.com/watch?v=E-ZbrtoSuzw' vim_advanced.opus
# fun_download 'https://www.youtube.com/watch?v=h7Rlru3agdA' pfsense_letsencrypt.opus
fun_download 'https://youtu.be/d8ERTCVXIUE' namika_lass_sie_tanzen.opus
#fun_download 'https://youtu.be/gnrQXMYJRRA' learn_german_while_you_sleep.opus
fun_download 'https://youtu.be/g1CWinr5AkI' how_to_fall_asleep.opus
fun_download 'https://www.youtube.com/watch?v=MFITQsNAHh8' namika_wenn_sie_kommen.opus
fun_download 'https://www.youtube.com/watch?v=zje3hoKgYe4' namika_kompliziert.opus
fun_download 'https://www.youtube.com/watch?v=7ZkejDqTuSM' helene_fischer_atemlos_durch_die_nacht.m4a
fun_download 'https://www.youtube.com/watch?v=j09hpp3AxIE' die_toten_hosen_tage_wie_diese.opus
fun_download 'https://youtu.be/fKRZz0ilM8Q' mozzik_loredana_romeo_and_juliet.opus
fun_download 'https://www.youtube.com/watch?v=cS_jVnabuBo' Lovely_london_sky_mary_poppins_returns.opus
fun_download 'https://www.youtube.com/watch?v=HKc0jVW6AaU' the_place_where_Lost_things_go_mary_poppins_returns.opus
fun_download 'https://www.youtube.com/watch?v=fH_OnJk6QqU' panic_at_the_disco_high_hopes.opus
fun_download 'https://www.youtube.com/watch?v=vK_hFfd2__w' clean_bandit_demi_lovato_solo.opus
fun_download 'https://www.youtube.com/watch?v=rhz_m-tgi2Y' timber.m4a
fun_download 'https://www.youtube.com/watch?v=U4xPahDjY6k' old_town_road.opus
fun_download 'https://www.youtube.com/watch?v=2KBFD0aoZy8' sweet_but_psycho_ava_max.m4a
fun_download 'https://www.youtube.com/watch?v=A8q4O1mwnEc' shape_of_you.m4a
fun_download 'https://www.youtube.com/watch?v=8rLTERuuxm4' party_in_the_usa.m4a
fun_download 'https://www.youtube.com/watch?v=5Dtre2Yiw78' wrecking_ball.opus
fun_download 'https://www.youtube.com/watch?v=vWfjlIMiqBg' scars_but_beautiful.opus
fun_download 'https://www.youtube.com/watch?v=eIWgBDT9Ylw' one_kiss.opus
fun_download 'https://www.youtube.com/watch?v=iMJ20768Fxs' whatever_it_takes.opus
fun_download 'https://www.youtube.com/watch?v=RE87rQkXdNw' happier.m4a
fun_download 'https://www.youtube.com/watch?v=3JV74i4yvcA' hey_soul_sister.opus
fun_download 'https://www.youtube.com/watch?v=iO_WxYC34eM' radioactive.m4a
#fun_download 'https://www.youtube.com/watch?v=7zCg7Ch6UzI' believer.opus
fun_download 'https://www.youtube.com/watch?v=fFuQfcAbCIA' no_tears_left_to_cry.opus
#fun_download 'https://www.youtube.com/watch?v=xQzS3JnZQZM' the_middle.opus
fun_download 'https://www.youtube.com/watch?v=RPYumdhRMkU' one_call_away.m4a
fun_download 'https://www.youtube.com/watch?v=b91ovTKCZGU' havana.m4a
fun_download 'https://www.youtube.com/watch?v=reuYXbHOc1c' faded.opus
fun_download 'https://www.youtube.com/watch?v=xscJ8Lla6Gc' burn.m4a
fun_download 'https://www.youtube.com/watch?v=IdymkbLAuAk' sit_still_look_pretty.m4a
fun_download 'https://www.youtube.com/watch?v=AsrnGyRS6l4' titanium.opus
fun_download 'https://www.youtube.com/watch?v=qQAKD__j4gM' dark_horse.opus
fun_download 'https://www.youtube.com/watch?v=NtGgj5zhM84' rockabye.opus
fun_download 'https://www.youtube.com/watch?v=s5TIulzXoXo' life_is_a_highway.opus
fun_download 'https://www.youtube.com/watch?v=MJLOCAWkRoc' a_whole_new_world.opus
#fun_download 'https://www.youtube.com/watch?v=xbZOFsFZUKY' your_welcome.opus
fun_download 'https://www.youtube.com/watch?v=jpqV3dzYOgk' try_everything.opus
#fun_download 'https://www.youtube.com/watch?v=XbT0i07CiyM' style.opus
fun_download 'https://www.youtube.com/watch?v=jzXt7YvK9Hw' sweet_caroline.opus
fun_download 'https://www.youtube.com/watch?v=SZLTDHviQOg' you_wreck_me.m4a
fun_download 'https://www.youtube.com/watch?v=RHBbvaI_7Jg' shimmer.opus
fun_download 'https://www.youtube.com/watch?v=3ap4s6pyoNw' wallflowers_one_headlight.opus
fun_download 'https://www.youtube.com/watch?v=fp6AEbMqh18' matchbox_twenty_push.opus
fun_download 'https://www.youtube.com/watch?v=VuHVZ_-b868' counting_crows_mr_jones.opus
#fun_download 'https://www.youtube.com/watch?v=OzzKBxlIiEQ' runaway_train.opus
#fun_download 'https://www.youtube.com/watch?v=O6VbT7mZo7o' let_her_cry.opus
fun_download 'https://www.youtube.com/watch?v=JU2E1lX1geY' crash_into_me.opus
fun_download 'https://www.youtube.com/watch?v=idFJkZQmN38' picture.opus
fun_download 'https://www.youtube.com/watch?v=MgO1LYAqMmI' pork_and_beans.opus
fun_download 'https://www.youtube.com/watch?v=Lr58WHo2ndM' 1979.opus
#fun_download 'https://www.youtube.com/watch?v=3k1MHJ3bFs0' keep_fishin.opus
fun_download 'https://www.youtube.com/watch?v=GJEA0RlVUsI' sound_of_silence.opus
fun_download 'https://www.youtube.com/watch?v=AxOsIoejw4E' hallelujah.opus
fun_download 'https://www.youtube.com/watch?v=1SiylvmFI_8' arms_of_the_angels.opus
fun_download 'https://www.youtube.com/watch?v=i66p0_wZ9F0' how_far_ill_go.opus
fun_download 'https://www.youtube.com/watch?v=fsPPAuW0Tvo' when_will_my_life_begin.m4a
fun_download 'https://www.youtube.com/watch?v=uEDhGX-UTeI' bad_liar.opus

echo find -name "*.opus" -exec ffmpeg -i {} {}.mp3 \;
echo cvlc can play any media via the command line

exit 0
