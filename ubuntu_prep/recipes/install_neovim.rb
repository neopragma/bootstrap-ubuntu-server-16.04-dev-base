# install and configure neovim editor

apt_repository 'neovim-ppa' do 
  uri          'ppa:neovim-ppa/stable'
end 

package 'python-pip'
package 'python3-pip'
package 'neovim'

# NOTE: There are known issues with pip2 on Ubuntu distros
#execute 'add python support to neovim' do
#  command "$(pip2 install --user neovim)"
#end

#execute 'add python3 support to neovim' do
#  command "$(pip3 install --user neovim)"
#end

bash 'set neovim as the system default editor' do
  code <<-EOF
    update-alternatives --install /usr/bin/vi vi /urs/bin/nvim 60
    update-alternatives --config vi
    update-alternatives --install /usr/bin/vim vim /urs/bin/nvim 60
    update-alternatives --config vim
    update-alternatives --install /usr/bin/editor editor /urs/bin/nvim 60
    update-alternatives --config editor
    EOF
end

directory 'root nvim autoload directory' do 
  path '/root/.config/nvim/autoload' 
  recursive true 
  owner 'root'
  group 'root'
  mode '0755'
end 

directory 'root nvim bundle directory' do 
  path '/root/.config/nvim/bundle' 
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end 

execute 'install pathogen plugin' do
  command "$(curl -LSso /root/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim)"
end

git 'install neovim plugin deoplete' do
  destination '/root/.config/nvim/bundle/deoplete'
  repository 'git://github.com/Shougo/deoplete.nvim.git'
end

git 'install neovim plugin neomake' do 
  destination '/root/.config/nvim/bundle/neomake' 
  repository 'git://github.com/neomake/neomake'
end
git 'install nerdtree plugin to neovim' do 
  destination '/root/.config/nvim/bundle/nerdtree' 
  repository 'git://github.com/scrooloose/nerdtree.git' 
end 

git 'install neovim plugin nerdtree-git-plugin' do 
  destination '/root/.config/nvim/bundle/nerdtree-git-plugin'
  repository 'git://github.com/Xuyuanp/nerdtree-git-plugin.git'
end  

git 'install neovim plugin bash-support' do 
  destination '/root/.config/nvim/bundle/bash-support' 
  repository 'git://github.com/WolfgangMehner/bash-support.git' 
end 

git 'install neovim plugin c-support' do 
  destination '/root/.config/nvim/bundle/c-support'
  repository 'git://github.com/WolfgangMehner/c-support.git' 
end 

git 'install neovim plugin python-mode' do 
  destination '/root/.config/nvim/bundle/python-mode' 
  repository 'git://github.com/klen/python-mode.git'
end

git 'install neovim plugin vim-ruby' do
  destination '/root/.config/nvim/bundle/vim-ruby' 
  repository 'git://github.com/vim-ruby/vim-ruby.git'
end 

# Add Spacegray color scheme to neovim 
directory 'root nvim pack vendor directory' do
  path '/root/.config/nvim/pack/vendor/start'
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end 

git 'install Spacegray plugin to neovim' do 
  destination '/root/.config/nvim/pack/vendor/start/Spacegray' 
  repository 'git://github.com/ajh17/Spacegray.vim' 
end 

# copy neovim configuration files to dev user space

bash 'copy neovim configuration files and set ownership' do
  code <<-EOF
    cp /root/bootstrap-ubuntu-server-16.04-dev-base/neovim/init.vim /root/.config/nvim/. 
    mkdir -p /home/dev/.config/nvim 
    cp -r /root/.config/nvim/* /home/dev/.config/nvim/.
    chown -R dev /home/dev
    chgrp -R dev /home/dev
    chown -R dev /home/dev/.config 
    chgrp -R dev /home/dev/.config
    chown -R dev /home/dev/.config/nvim 
    chgrp -R dev /home/dev/.config/nvim
    EOF
end

