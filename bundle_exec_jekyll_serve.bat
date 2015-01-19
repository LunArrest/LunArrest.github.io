set PYTHON2_HOME=C:\Python27
set PATH=%PYTHON2_HOME%\;%PYTHON2_HOME%\Scripts;%PYTHON2_HOME%\Tools\Scripts;%PATH%
ftype Python.CompiledFile="C:\Python27\python.exe" "%1" %*   
ftype Python.File="C:\Python27\python.exe" "%1" %*   
ftype Python.NoConFile="C:\Python27\pythonw.exe" "%1" %*  
bundle exec jekyll serve