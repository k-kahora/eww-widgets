directory="/home/malcolm/Documents/Wallpapers/"
BUTTON_TOGGLE=$HOME/.button
if [ ! -e "$BUTTON_TOGGLE" ]; then
	touch "$BUTTON_TOGGLE"
	eww update button-state="./button-clicked.png" --config ./
else
	rm "$BUTTON_TOGGLE"
	eww update button-state="./button.png" --config ./
fi
random_file=$(ls "$directory" | shuf -n 1)

# (image :path "./button.png")
# swww init
swww img $directory$random_file --transition-type grow --transition-pos 0.1,0.8 --transition-fps 200 

