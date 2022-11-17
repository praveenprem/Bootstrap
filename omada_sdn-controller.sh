echo '                                                                                                                                           ' 
echo '  ###                     #                 ###   ####   #   #          ###                  #                    ##     ##                ' 
echo ' #   #                    #                #   #   #  #  #   #         #   #                 #                     #      #                ' 
echo ' #   #  ## #    ###    ## #   ###          #       #  #  ##  #         #       ###   # ##   ####   # ##    ###     #      #     ###   # ## ' 
echo ' #   #  # # #      #  #  ##      #          ###    #  #  # # #         #      #   #  ##  #   #     ##  #  #   #    #      #    #   #  ##  #' 
echo ' #   #  # # #   ####  #   #   ####             #   #  #  #  ##         #      #   #  #   #   #     #      #   #    #      #    #####  #    ' 
echo ' #   #  # # #  #   #  #  ##  #   #         #   #   #  #  #   #         #   #  #   #  #   #   #  #  #      #   #    #      #    #      #    ' 
echo '  ###   #   #   ####   ## #   ####          ###   ####   #   #          ###    ###   #   #    ##   #       ###    ###    ###    ###   #    ' 
echo '                                                                                                                                           ' 
echo '                                                                                                                                           ' 

echo "Version: 5.6.3"

source /etc/os-release

if [ "$VERSION_CODENAME" != "bionic" ]; then
    echo "MongoDB version is NOT supported on $VERSION_CODENAME"
    exit 1
fi

apt-get update && apt-get upgrade -y

echo "**** Install packages ****"
apt-get install -y binutils jsvc openjdk-8-jre-headless wget curl gnupg

echo "**** Add mongo repository ****"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu $VERSION_CODENAME/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongo-3.6.list

echo "**** Install MongoDB ****"
apt-get update 
apt-get install -y mongodb-org-server

echo "**** Install Omada SDN Controller ****"
curl -o Omada_SDN_Controller_v5.6.3_Linux_x64.deb -L "https://static.tp-link.com/upload/software/2022/202210/20221024/Omada_SDN_Controller_v5.6.3_Linux_x64.deb"
sleep 3
dpkg -i Omada_SDN_Controller_v5.6.3_Linux_x64.deb

echo "Completed"
