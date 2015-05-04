REM 该文件直接执行貌似是无效的，要在cmd中直接执行以下命令，原因暂时未知。
REM ftype Python.CompiledFile="C:\Python34\python.exe" "%1" %*   
REM ftype Python.File="D:\Python34\python.exe" "%1" %*   
REM ftype Python.NoConFile="D:\Python34\pythonw.exe" "%1" %*  
REM % 为转义字符

ftype Python.CompiledFile="D:\Python34\python.exe" "%%1" %%*   
ftype Python.File="D:\Python34\python.exe" "%%1" %%*   
ftype Python.NoConFile="D:\Python34\pythonw.exe" "%%1" %%*  