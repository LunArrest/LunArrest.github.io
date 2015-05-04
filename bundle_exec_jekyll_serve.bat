set PYTHON2_HOME=D:\Python27
set PATH=%PYTHON2_HOME%\;%PYTHON2_HOME%\Scripts;%PYTHON2_HOME%\Tools\Scripts;%PATH%
ftype Python.CompiledFile="D:\Python27\python.exe" "%%1" %%*   
ftype Python.File="D:\Python27\python.exe" "%%1" %%*   
ftype Python.NoConFile="D:\Python27\pythonw.exe" "%%1" %%*  
bundle exec jekyll serve