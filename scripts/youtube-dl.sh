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

fun_download 'https://www.youtube.com/watch?v=hIv13ou5mzw' sleep_delta-force-4hz.opus

song='soul_asylum_runaway_train'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

# song='bridge_over_troubled_water'
# url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
# fun_download "http://youtube.com$url" "${song}.opus"

song='dave_matthews_band_crash_into_me'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='shawn_mullins_lullaby'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='counting_crows_a_long_december'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='hootie_and_the_blowfish_let_her_cry'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='u2_beautiful_day'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='miley_cyrus_party_in_the_usa'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.m4a"

song='sister_hazel_all_for_you'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='neil_young_ohio'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.opus"

song='neil_young_ohio'
url=$(python3 youtube-search.py "${song}" | jq  -r '.videos | .[] | .url_suffix')
fun_download "http://youtube.com$url" "${song}.m4a"

#youtube-dl -F https://youtu.be/d8ERTCVXIUE
# fun_download 'https://www.youtube.com/watch?v=Nim4_f5QUxA' vim_training_class1.opus
# fun_download 'https://www.youtube.com/watch?v=2pqipq-UEwQ' vim_training_class2.opus
# fun_download 'https://www.youtube.com/watch?v=02_H3LjqMr8' haskell_tutorial.opus
# fun_download 'https://www.youtube.com/watch?v=E-ZbrtoSuzw' vim_advanced.opus
# fun_download 'https://www.youtube.com/watch?v=h7Rlru3agdA' pfsense_letsencrypt.opus
#fun_download 'https://youtu.be/gnrQXMYJRRA' learn_german_while_you_sleep.opus
# fun_download 'https://youtu.be/g1CWinr5AkI' how_to_fall_asleep.opus
fun_download 'https://www.youtube.com/watch?v=j09hpp3AxIE' die_toten_hosen_tage_wie_diese.opus
fun_download 'https://www.youtube.com/watch?v=cS_jVnabuBo' lovely_london_sky_mary_poppins_returns.opus
fun_download 'https://www.youtube.com/watch?v=HKc0jVW6AaU' the_place_where_Lost_things_go_mary_poppins_returns.opus
fun_download 'https://www.youtube.com/watch?v=rhz_m-tgi2Y' timber.m4a
fun_download 'https://www.youtube.com/watch?v=U4xPahDjY6k' old_town_road.opus
fun_download 'https://www.youtube.com/watch?v=2KBFD0aoZy8' sweet_but_psycho_ava_max.m4a
fun_download 'https://www.youtube.com/watch?v=A8q4O1mwnEc' shape_of_you.m4a
# fun_download 'https://www.youtube.com/watch?v=8rLTERuuxm4' party_in_the_usa.m4a
fun_download 'https://www.youtube.com/watch?v=eIWgBDT9Ylw' one_kiss.opus
fun_download 'https://www.youtube.com/watch?v=iMJ20768Fxs' whatever_it_takes.opus
fun_download 'https://www.youtube.com/watch?v=RE87rQkXdNw' happier.m4a
#fun_download 'https://www.youtube.com/watch?v=7zCg7Ch6UzI' believer.opus
#fun_download 'https://www.youtube.com/watch?v=xQzS3JnZQZM' the_middle.opus
fun_download 'https://www.youtube.com/watch?v=RPYumdhRMkU' one_call_away.m4a
fun_download 'https://www.youtube.com/watch?v=b91ovTKCZGU' havana.m4a
fun_download 'https://www.youtube.com/watch?v=reuYXbHOc1c' faded.opus
fun_download 'https://www.youtube.com/watch?v=xscJ8Lla6Gc' burn.m4a
fun_download 'https://www.youtube.com/watch?v=IdymkbLAuAk' sit_still_look_pretty.m4a
fun_download 'https://www.youtube.com/watch?v=AsrnGyRS6l4' titanium.opus
fun_download 'https://www.youtube.com/watch?v=s5TIulzXoXo' life_is_a_highway.opus
fun_download 'https://www.youtube.com/watch?v=MJLOCAWkRoc' a_whole_new_world.opus
#fun_download 'https://www.youtube.com/watch?v=xbZOFsFZUKY' your_welcome.opus
#fun_download 'https://www.youtube.com/watch?v=XbT0i07CiyM' style.opus
fun_download 'https://www.youtube.com/watch?v=d8ERTCVXIUE' namika_lass_sie_tanzen.opus
fun_download 'https://www.youtube.com/watch?v=fKRZz0ilM8Q' mozzik_loredana_romeo_and_juliet.opus
fun_download 'https://www.youtube.com/watch?v=7ZkejDqTuSM' helene_fischer_atemlos_durch_die_nacht.m4a
fun_download 'https://www.youtube.com/watch?v=MFITQsNAHh8' namika_wenn_sie_kommen.opus
fun_download 'https://www.youtube.com/watch?v=zje3hoKgYe4' namika_kompliziert.opus
fun_download 'https://www.youtube.com/watch?v=fH_OnJk6QqU' panic_at_the_disco_high_hopes.opus
fun_download 'https://www.youtube.com/watch?v=fFuQfcAbCIA' ariana_grande_no_tears_left_to_cry.opus
fun_download 'https://www.youtube.com/watch?v=jpqV3dzYOgk' shakira_try_everything.opus
fun_download 'https://www.youtube.com/watch?v=vK_hFfd2__w' clean_bandit_solo.opus
fun_download 'https://www.youtube.com/watch?v=iO_WxYC34eM' imagine_dragons_radioactive.m4a
fun_download 'https://www.youtube.com/watch?v=qQAKD__j4gM' katy_perry_dark_horse.opus
fun_download 'https://www.youtube.com/watch?v=5Dtre2Yiw78' miley_cyrus_wrecking_ball.opus
fun_download 'https://www.youtube.com/watch?v=vWfjlIMiqBg' alessia_cara_scars_but_beautiful.opus
fun_download 'https://www.youtube.com/watch?v=NtGgj5zhM84' shawn_mullins_rockabye.opus
fun_download 'https://www.youtube.com/watch?v=3JV74i4yvcA' train_hey_soul_sister.opus
fun_download 'https://www.youtube.com/watch?v=jzXt7YvK9Hw' neil_diamond_sweet_caroline.opus
fun_download 'https://www.youtube.com/watch?v=SZLTDHviQOg' tom_petty_you_wreck_me.m4a
fun_download 'https://www.youtube.com/watch?v=RHBbvaI_7Jg' shawn_mullins_shimmer.opus
fun_download 'https://www.youtube.com/watch?v=3ap4s6pyoNw' wallflowers_one_headlight.opus
fun_download 'https://www.youtube.com/watch?v=fp6AEbMqh18' matchbox_twenty_push.opus
fun_download 'https://www.youtube.com/watch?v=VuHVZ_-b868' counting_crows_mr_jones.opus
fun_download 'https://www.youtube.com/watch?v=JU2E1lX1geY' dave_matthews_band_crash_into_me.opus
fun_download 'https://www.youtube.com/watch?v=MgO1LYAqMmI' weezer_pork_and_beans.opus
fun_download 'https://www.youtube.com/watch?v=Lr58WHo2ndM' smashing_pumpkins_1979.opus
fun_download 'https://www.youtube.com/watch?v=GJEA0RlVUsI' disturbed_sound_of_silence.opus
fun_download 'https://www.youtube.com/watch?v=AxOsIoejw4E' pentatonix_hallelujah.opus
fun_download 'https://www.youtube.com/watch?v=1SiylvmFI_8' sarah_mclachlan_arms_of_the_angels.opus
fun_download 'https://www.youtube.com/watch?v=i66p0_wZ9F0' alessia_cara_how_far_ill_go.opus
fun_download 'https://www.youtube.com/watch?v=fsPPAuW0Tvo' mandy_moore_when_will_my_life_begin.m4a
fun_download 'https://www.youtube.com/watch?v=uEDhGX-UTeI' imagine_dragons_bad_liar.opus
fun_download 'https://www.youtube.com/watch?v=idFJkZQmN38' kid_rock_picture.opus

echo find -name "*.opus" -exec ffmpeg -i {} {}.mp3 \;
echo cvlc can play any media via the command line

exit 0

# vim: set ft=sh
