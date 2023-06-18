rm -rf build/web
flutter build web --release
cd build/web
rm -rf ~/office/GitHub/office-buddy-ui-deploy/*
cp -r ./* ~/office/GitHub/office-buddy-ui-deploy