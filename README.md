### Installation

With [Vim-plug](https://github.com/junegunn/vim-plug) add this to your .vimrc:

```
Plug 'vmchale/howdoi-vim' , {'do' : './install.sh' }
```

With [Vundle](https://github.com/VundleVim/Vundle.vim) simply add this to your .vimrc:

```
Plugin 'vmchale/howdoi-vim'
```

If you use vundle you'll have to install howdoi manually, e.g. with 

```
pip install howdoi
```

The advantage of this plugin is that it does not require a vim compiled with
+python, so you don't have to go outside your distro to get it. Of couse, 
you'll need to install [howdoi](https://github.com/gleitz/howdoi) as well. If 
you have pip, this is as simple as typing:

```
pip install howdoi
```

### Usage

By default, howdoi-vim provides one command:

```
:Howdoi 'SEARCH TERMS'
```

Press `q` to exit when it displays the code content of your project.

You can also set `g:howdoi_num` to set the number of answers to return by
default, and `g:howdoi_options` to access other options from the command line,
e.g. 

```
let g:howdoi_num=3
```
