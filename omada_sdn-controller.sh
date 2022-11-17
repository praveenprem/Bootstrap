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

apt update && apt upgrade -y
apt install gnupg -y

echo "**** Add mongo repository ****"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" >> /etc/apt/sources.list.d/mongo.list

echo "**** Install packages ****"
apt-get update
apt-get install -y binutils jsvc mongodb-org-server	openjdk-8-jre-headless wget curl

echo "**** Install Omada SDN Controller ****"
curl -o Omada_SDN_Controller_v5.6.3_Linux_x64.deb -L "https://static.tp-link.com/upload/software/2022/202210/20221024/Omada_SDN_Controller_v5.6.3_Linux_x64.deb"
sleep 3
dpkg -i Omada_SDN_Controller_v5.6.3_Linux_x64.deb

echo "Completed"
