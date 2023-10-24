#!/bin/bash
# (#!) is called shebang 
# it is a special line that is used in the beginning of a script which tells the operating system which interpreter to use when executing the script.
# #!/bin/bash  this line tells the operating system to use bash interpreter while executing/running the script

bookmark_keeper="bookmark_keeper.md"
touch "$bookmark_keeper"
# here we have created a markdown file named bookmarks_keeper if it does not exist already

chromium_bookmarks ="${HOME}/aditya/snap/chromium/current/.config/chromium/Default/Bookmarks" 
firefox_bookmarks ="${HOME}/aditya/snap/firefox/current/.mozilla/firefox/default/places.sqlite"
brave_bookmarks ="${HOME}/aditya/snap/.config/brave/Default/Bookmarks"
edge_bookmarks ="${HOME}/aditya/share/microsoft-edge-stable/Default/Bookmarks"
#here we have defined variables that store the location of bookmarks or more precisely bookmark files of chrome,brave,edge and firefox
if [ -f "$chromium_bookmarks" ]; then
  echo "Getting bookmarks from Google Chrome Browser......."
  while IFS=\| read title url; do
    echo "Saving bookmark: $title - $url" >> "$bookmark_keeper"
  done < "$chromium_bookmarks"
fi

if [ -f "$firefox_bookmarks" ]; then
  echo "Getting bookmarks from Mozilla Firefox Browser......"
  sqlite3 "$firefox_bookmarks" << EOF
    SELECT moz_places.title, moz_places.url
    FROM moz_places;
EOF
  >> "$bookmark_keeper"
fi

if [ -f "$brave_bookmarks" ]; then
  echo "Getting bookmarks from Brave Browser......."
  while IFS=\| read title url; do
    echo "Saving bookmark: $title - $url" >> "$bookmark_keeper"
  done < "$brave_bookmarks"
fi

if [ -f "$edge_bookmarks" ]; then
  echo "Getting bookmarks from Edge Browser..."
  while IFS=\| read title url; do
    echo "Saving bookmark: $title - $url" >> "$bookmark_keeper"
  done < "$edge_bookmarks"
fi
#here we have checked it there are any bookmarks in chrome/chromium,edge,brave and firefox. If it does then the script will then loop through the file and save each bookmark to the bookmark_keeper markdown file
if [ ! -s "$bookmark_keeper" ]; then
  echo "Sorry, No Bookmarks Found."
  exit 1
fi
#here we are checking if the markdown file is empty. If it is empty then the console/terminal will print/display a message saying "Sorry,No Bookmarks Found."
sort -t " " -k 1 "$bookmark_keeper" > "$bookmark_keeper"
#this part of the script sorts the markdown file
echo "All bookmarks of Chrome,Firefox,Brave,Edge Browsers have been saved to the file $bookmark_keeper"
echo "You can now search for individual bookmarks by keyword using the following command:"
echo "grep -i <keyword> $bookmark_keeper"

EOF #end of here document

\n #this terminates the bash script correctly 
