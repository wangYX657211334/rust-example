flutter build ios --release
cd build/ios/iphoneos/
rm -rf Payload
mkdir Payload
cp -r Runner.app Payload/
zip -r 家宝欢.ipa ./Payload
rm ~/Downloads/家宝欢.ipa
mv 家宝欢.ipa ~/Downloads/家宝欢.ipa