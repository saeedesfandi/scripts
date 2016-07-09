### Shell script to download Oracle JDK / JRE / Java binaries from Oracle website using terminal / command / shell prompt using wget.
### You can download all the binaries one-shot by just giving the BASE_URL.
### Script might be useful if you need Oracle JDK on Amazon EC2 env.

## Features:-
# 1. Resumes a broken / interrupted [previous] download, if any.
# 2. Renames the file to a proper name with including platform info.
# 3. Downloads the following from Oracle Website with one shell invocation.
#    a. Windows 64 and 32 bit;
#    b. Linux 64 and 32 bit;
#    c. API Docs;
#    d. You can add more to the list of downloads are per your requirement.

##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

## Current latest JDK version: JDK8u31
BASE_URL=http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31

## Previous versions: 8u25
#BASE_URL=http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25

JDK_VERSION=${BASE_URL: -8}

#declare -a PLATFORMS=("-windows-x64.exe" "-windows-i586.exe" "-linux-x64.tar.gz" "-linux-i586.tar.gz" "-docs-all.zip")
declare -a PLATFORMS=("-linux-x64.tar.gz")

for platform in "${PLATFORMS[@]}"
do
    wget -c -O "$JDK_VERSION$platform" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${BASE_URL}${platform}"
done

##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

## Current latest JDK version: JDK7u75
BASE_URL=http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75

## Previous versions: v7u71
#BASE_URL=http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71

JDK_VERSION=${BASE_URL: -8}

declare -a PLATFORMS=("-windows-x64.exe" "-windows-i586.exe" "-linux-x64.tar.gz" "-linux-i586.tar.gz" "-docs-all.zip")

for platform in "${PLATFORMS[@]}"
do
#    wget -c -O "$JDK_VERSION$platform" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${BASE_URL}${platform}"
done

##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
