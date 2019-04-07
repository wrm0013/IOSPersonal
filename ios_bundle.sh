#!/bin/bash

#是否是jenkins打包
isJenkins=$IS_JENKINS

if [ ! -n "$isJenkins" ]; then
isJenkins=false
fi

#打包类型
configuration="Release"

#项目目录

if [[ $isJenkins = false ]]; then
workspacePath="/Users/ruisi/IOSProject/PersonalAnswer"
else
workspacePath=$WORKSPACE
fi

echo "--workspacePath-------$workspacePath"

info_path="$workspacePath/PersonalAnswer/Info.plist"

build_version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" ${info_path})

echo "--build_version----------------$build_version"

bundleName=$(/usr/libexec/PlistBuddy -c "Print CFBundleName" ${info_path})

echo "--bundleName------------------$bundleName"

#文档路径，用来记录命令的输出

log_path="$workspacePath/build/Log/log.txt"

#workspace的名字
workspaceName="$workspacePath/PersonalAnswer.xcworkspace"

scheme="PersonalAnswer"

codeSignIdentity="iPhone Distribution: SEAPRODEX REFRIGERATION INDUSTRY CORPORATION"

enterpriseProvisioningProfile="55ff5009-783f-488c-8205-1bc09058fde8"

archivePath="$workspacePath/build/archive/PersonalAnswer.xcarchive"

ipaName="$bundleName_${configuration}_V${build_version}"

exportPath="$workspacePath/build/ipa"

exportOptionsPlist="$workspacePath/PersonalAnswer/EnterpriseExportOptions.plist"


#构建版本
function build()
{
#清理构建目录

xcodebuild clean -configuration "$configuration" -alltargets >> $log_path

#编译打包成Archive

xcodebuild archive -workspace "$workspaceName" -scheme "$scheme" -configuration "$configuration" -archivePath "$archivePath" CODE_SIGN_IDENTITY="$codeSignIdentity" PROVISIONING_PROFILE="$enterpriseProvisioningProfile" >> $log_path

#将Archive导出

xcodebuild -exportArchive -archivePath "$archivePath" -exportOptionsPlist "$exportOptionsPlist" -exportPath "$exportPath"


# file=$exportPath/JenkinsTest.ipa

# mv $file `echo $file|sed 's#JenkinsTest#${ipaName}#g'`

open $exportPath

}


function createDir(){
dirPath=${1}
fileName=${2}
if [ ! -d $dirPath ]; then
mkdir -p $dirPath
touch $dirPath/$fileName
fi
}

#手动打包
function buildWithNotJenkins()
{
echo "================================================="
echo ""
echo "编译的版本是否用于线上？"
echo "          [Y] 是（构建用于上线的Release版本）"
echo "          [N] 否（构建用于测试的Debug版本）"
echo "================================================="
read -p "请选择:" isBuildRelease

while true
do
case $isBuildRelease in
[yY]* )
configuration="Release"
break;;
[nN]* )
configuration="Debug"
break;;
* )     continue ;;
esac
done

createDir "$workspacePath/build/Log" "log.txt"

createDir "$workspacePath/build/archive" "PersonalAnswer.xcarchive"

if [ ! -d $exportPath ]; then
mkdir -p $exportPath
fi
build
}

#jenkins打包
function buildWithJenkins()
{
configuration=$CONFIGURATION

echo "==configuration========================$configuration"

build
}


if [[ $isJenkins = false ]]; then
buildWithNotJenkins
else
buildWithJenkins
fi


