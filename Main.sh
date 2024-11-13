#!/bin/bash

echo
echo "----------------------------"
echo "          Flasko"
echo 
echo "1. Open Your Website "
echo "2. Show the Pics Clicked"
echo "3. Exit"
echo
echo "----------------------------"
echo
echo -n "Choose Your Option (1/2/3):"
read choosevar
echo
case $choosevar in
    1) echo "Starting your website now...."
       chmod +x website.sh
       source ./website.sh
    ;;
    2) echo "Pics Clicked are opening in...."
       echo
       for img in static/captured_images/*.jpg; do
       echo "Opening $img"
       xdg-open "$img"
       sleep 1  # Pause briefly between opening each image
done
      echo
    ;;
    3) echo
       echo "Thankyou for choosing Flasko"
       echo        
    ;;
    *) echo 
       echo "Invalid Option!"
       echo 
    ;;
esac