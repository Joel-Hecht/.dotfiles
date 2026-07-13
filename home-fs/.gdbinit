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

set debuginfod enabled off 
