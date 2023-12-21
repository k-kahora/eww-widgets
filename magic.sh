# First change the image of the button
# Then change the wallpaper
eww update button-state="./Button/button-clicked.png" --config ./
directory="./art/"
# BUTTON_TOGGLE=$HOME/.button
# if [ ! -e "$BUTTON_TOGGLE" ]; then
# 	touch "$BUTTON_TOGGLE"
# 	eww update button-state="./button-clicked.png" --config ./
# else
# 	rm "$BUTTON_TOGGLE"
# 	eww update button-state="./button.png" --config ./
# fi
random_file=$(ls "$directory" | shuf -n 1)
# echo $directory$random_file
# (greeter :name "mal" :text "welcom")
# (image :path "./button.png")
# swww init
swww img $directory$random_file --transition-type fade --transition-pos 0.95,0.9 --transition-step 200
sleep 0.25s
eww update button-state="./Button/button.png" --config ./

