" pyblock.vim
map ( :python pythonblockFind(forward = 0)
map ) :python pythonblockFind()

python << EOF
def countIndent(line):
   i = 0
   for s in line:
      if s != ' ' and s != '\t': return(i)
      i = i + 1
   return(0)

def isEmptyLine(line):
   return(not line.strip())

def pythonblockNonblank(lineno, forward = 1):
   import vim
   cb = vim.current.buffer
   col = vim.current.window.cursor[1]

   end, increment = ( 0, -1 )
   if forward == 1: end, increment = ( len(cb), 1 )

   for i in xrange(lineno, end, increment):
      cline = cb[i - 1]
      if not isEmptyLine(cline):
         if i >= len(cb): i = len(cb) - 1
         if i < 1: i = 1
         vim.current.window.cursor = ( i, col )
         return()

def pythonblockFind(forward = 1):
   import vim

   cb = vim.current.buffer
   lineno, col = vim.current.window.cursor
   cline = cb[lineno - 1]
   cIndent = countIndent(cline)

   end, increment = ( 0, -1 )
   if forward == 1: end, increment = ( len(cb), 1 )

   for i in xrange(lineno, end, increment):
      cline = cb[i - 1]
      if isEmptyLine(cline): continue
      if countIndent(cline) < cIndent:
         if forward == 1:
            return(pythonblockNonblank(i - 1, not forward))
         return(pythonblockNonblank(i + 1, not forward))

   if forward == 1: vim.current.window.cursor = ( len(cb) - 1, col )
   else: vim.current.window.cursor = ( 1, col )
EOF
