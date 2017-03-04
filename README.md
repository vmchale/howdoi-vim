### Installation

With [Vundle](https://github.com/VundleVim/Vundle.vim) simply add this to your .vimrc:

```
Plugin 'vmchale/howdoi-vim'
```

Of couse, you'll need to install [howdoi](https://github.com/gleitz/howdoi) as well. If you have pip, this is as simple as typing:

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
