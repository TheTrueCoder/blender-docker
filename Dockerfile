FROM ubuntu

# Set timezone
RUN echo "Pacific/Auckland" | tee /etc/timezone

RUN apt-get update && apt-get install -y build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libglew-dev

RUN cd ~ && git clone https://github.com/blender/blender.git
RUN mkdir lib && cd lib && svn checkout https://svn.blender.org/svnroot/bf-blender/trunk/lib/linux_centos7_x86_64

RUN cd ~/blender && make update && make
