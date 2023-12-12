directory="/home/malcolm/Documents/Wallpapers/"
random_file=$(ls "$directory" | shuf -n 1)

# swww init
swww img $directory$random_file --transition-type grow --transition-pos 0.1,0.8 --transition-fps 200 

