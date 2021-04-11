FROM ubuntu AS build

# Set timezone
RUN apt-get update && echo "Pacific/Auckland" | tee /etc/timezone && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN apt-get install -y -qq build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libglew-dev

RUN cd ~ && git clone https://github.com/blender/blender.git
RUN mkdir ~/lib && cd ~/lib && svn checkout https://svn.blender.org/svnroot/bf-blender/trunk/lib/linux_centos7_x86_64

RUN apt-get install -y python3 python3-pip

RUN cd ~/blender && make update && make

FROM ubuntu
# Blender deps
RUN apt-get update && apt-get install -y libavcodec58 libavdevice58 libavformat58 libavutil56 libboost-locale1.71.0 libc6 libfftw3-double3 libfreetype6 libgcc-s1 libgl1 libglew2.1 libgmp10 libgomp1 libilmbase24 libjpeg8 liblzo2-2 libopenal1 libopencolorio1v5 libopenexr24 libopenimageio2.1 libopenjp2-7 libopenshadinglanguage1.10 libopenvdb7.1 libosdcpu3.4.0 libpcre3 libpng16-16 libpotrace0 libpython3.8 libsndfile1 libspnav0 libstdc++6 libswscale5 libtbb2 libtiff5 libx11-6 libxfixes3 libxi6 libxml2 libxrender1 libxxf86vm1 openimagedenoise zlib1g python3 python3-gi shared-mime-info llvm-10

COPY --from=build /root/build_linux/bin /blender
