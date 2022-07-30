echo make sure you run this file in a terminal ending in newsapp/
cd tabmanager_backend
start /B node .
cd ..
cd tabmanager_frontend/build/web
start /B python -m http.server 5000