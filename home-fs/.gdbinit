#allow eigen matrix values to be printed by gdb
python
import sys
from pathlib import Path
path_to_eigen_printer = Path.home() / '.gdb' / 'eigen_printer'
sys.path.insert(0, str(path_to_eigen_printer))
from printers import register_eigen_printers
register_eigen_printers (None)
end

# suppress [new thread created...] and [thread terminated ...] messages
set print thread-events off

#don't paginate long stacktrace
set width 0
set height 0

set print pretty on

# do you really want to quit (y/n)?
set confirm off

# suppress wsl asking to redownload this every time
set debuginfod enabled off 
