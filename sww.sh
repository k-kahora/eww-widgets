directory="/home/malcolm/Documents/Wallpapers/"
# BUTTON_TOGGLE=$HOME/.button
# if [ ! -e "$BUTTON_TOGGLE" ]; then
# 	touch "$BUTTON_TOGGLE"
# 	eww update button-state="./button-clicked.png" --config ./
# else
# 	rm "$BUTTON_TOGGLE"
# 	eww update button-state="./button.png" --config ./
# fi
random_file=$(ls "$directory" | shuf -n 1)
# (greeter :name "mal" :text "welcom")
# (image :path "./button.png")
swww init
swww img $directory$random_file --transition-type simple --transition-pos 0.95,0.9 --transition-fps 200 

