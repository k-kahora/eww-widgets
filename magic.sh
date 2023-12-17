# First change the image of the button
# Then change the wallpaper
eww update button-state="./Button/button-clicked.png" --config ./
sleep 0.3s
eww update button-state="./Button/button.png" --config ./
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
echo $directory$random_file
# (greeter :name "mal" :text "welcom")
# (image :path "./button.png")
swww img $directory$random_file --transition-type simple --transition-pos 0.95,0.9 --transition-step 3

