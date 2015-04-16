
echo create Objective-C codes

protoc --proto_path=./WorryClient/Protocol/ --objc_out=./WorryClient/Protocol/Gen ./WorryClient/Protocol/User.proto
protoc --proto_path=./WorryClient/Protocol/ --objc_out=./WorryClient/Protocol/Gen ./WorryClient/Protocol/Feed.proto

#echo build C codes

#cd /java/protobuf-c-0.15/bin/

#./protoc-c --proto_path=/gitdata/Draw_iPhone/Draw/GameServer/ProtocolBuffer/ --c_out=/gitdata/Draw_iPhone/Draw/GameServer/ProtocolBuffer/Gen-c /gitdata/Draw_iPhone/Draw/GameServer/ProtocolBuffer/GameBasic.proto


#echo build Java server codes

#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava  ./BarrageClient/Protocol/Common.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava  ./BarrageClient/Protocol/Constants.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava  ./BarrageClient/Protocol/Error.proto/
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava  ./BarrageClient/Protocol/Message.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava ./BarrageClient/Protocol/User.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenJava ./BarrageClient/Protocol/Barrage.proto




#echo build Java Android code
#
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/Common.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/Constants.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/Error.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/Message.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/User.proto
#protoc --proto_path=./BarrageClient/Protocol/ --java_out=./BarrageClient/Protocol/GenAndroidJava  ./BarrageClient/Protocol/Barrage.proto
#
