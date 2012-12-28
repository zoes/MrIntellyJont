rm -r /tmp/apk
mkdir /tmp/apk
mkdir /tmp/apk/js
mkdir /tmp/apk/fonts
cp mrintellyjont_style.css /tmp/apk
cp page1.html /tmp/apk
cp page2.html /tmp/apk
cp page3.html /tmp/apk
cp page4.html /tmp/apk
cp page5.html /tmp/apk
cp page6.html /tmp/apk
cp page7.html /tmp/apk
cp page8.html /tmp/apk
cp page9.html /tmp/apk
cp js/Picture1.js /tmp/apk/js
cp js/Picture2.js /tmp/apk/js
cp js/Picture3.js /tmp/apk/js
cp js/Picture4.js /tmp/apk/js
cp js/Picture5.js /tmp/apk/js
cp js/Picture6.js /tmp/apk/js
cp js/Picture7.js /tmp/apk/js
cp js/Picture8.js /tmp/apk/js
cp js/Picture9.js /tmp/apk/js
cp js/arrow.gif /tmp/apk/js
cp js/backward.png /tmp/apk/js
cp js/forward.png /tmp/apk/js
cp js/jquery-1.7.js /tmp/apk/js
cp js/jquery.colorPicker.js /tmp/apk/js
cp fonts/GoodDog-webfont.eot /tmp/apk/fonts
cp fonts/GoodDog-webfont.svg /tmp/apk/fonts
cp fonts/GoodDog-webfont.ttf /tmp/apk/fonts
cp fonts/GoodDog-webfont.woff /tmp/apk/fonts
cp fonts/Sling-webfont.eot /tmp/apk/fonts
cp fonts/Sling-webfont.svg /tmp/apk/fonts
cp fonts/Sling-webfont.ttf /tmp/apk/fonts
cp fonts/Sling-webfont.woff /tmp/apk/fonts
cd /tmp/apk
zip -r apk.zip *
cp apk.zip /Users/zoe/Desktop
