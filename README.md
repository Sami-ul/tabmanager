![](https://img.shields.io/badge/npm-CB3837?style=for-the-badge&logo=npm&logoColor=white
)
![](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white
)
![](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
)
![](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

![](https://licensebuttons.net/l/zero/1.0/80x15.png)

![](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)

You can contact me here: ahmed.samiul.h@gmail.com

# Tabmanager

Created by Sami-ul


![](repoAssets/page1.png)
![](repoAssets/page2.png)

## Info
- A tab manager that uses Postgres, NodeJS, Express, and Flutter
- Boxes are draggable
- Instructions to set up Postgres are in `tabmanager_backend\SQL_Queries`
- Web port must be 5000 as per CORS policy defined in index.js

## Setup
- Make sure you have the following tools installed
    - Postgres
    - NodeJS
    - Flutter
## Setup
- Updating packages
    - To do this navigate to each folder in server
    - Enter these commands in terminal
        - `cd tabmanager_backend`
        - `npm install`
        - `cd..`
    - Now you have updated packages for poetry and npm
    - We will now update flutter packages
        - Navigate to webapp
        - Assuming you are in summarizationapi:
        - `cd tabmanager_frontend`
        - `flutter pub get`
- Now lets run the app
    - Navigate to each folder in server to start the backend
        - I have not hosted the api anywhere yet so thats why we need to do this(I am only using this for personal use plus database was designed with only localhost in mind)
        - `cd tabmanager_backend`
        - `node .`
    - Now we can start the frontend
        - Use a **separate terminal**
        - `cd tabmanager_frontend`
        - `flutter run -d Chrome --release --web-port=5000`
    - Now the app will start

## Running release
- `flutter build web --release -v` in root
- Edit `/build/web/index.html`, replace line `<base href="/">` with `<base href="/web/">`
- Copy localhost.py into `/build/web/`