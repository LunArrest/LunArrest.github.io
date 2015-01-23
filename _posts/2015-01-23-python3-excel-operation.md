---
layout: post
title: Python3 操作Excel文件（读写）
description: 通过Python3 以及第三方Module 操作Excel文件
tags: python3
---

##安装

 * 读Excel文件通过模块xlrd  
 * 写Excel文件同过模块xlwt(可惜的是只支持Python2.3到Python2.7版本)
 * xlwt-future模块，支持Python3.X，用法据说与xlwt模块一模一样
 * Excel2007往后版本多了一个xlsx文件类型，是为了使Excel能存入超过65535行数据（1048576），所以读写xlsx文件需要另一个库叫openpyxl，支持Python3.x  

pip install xlrd，还能更简单点吗？  

使用参考：[xlrd官网][HomePage]   

安装的版本为0.9.3，但是官网的介绍还是关于Version 0.7.3版本的，无妨，不影响理解。  
Tutorial PDF指向的API url也404了，不怕，我们还有help()。  


## 读取Excel：

{% highlight Python %}
from mmap import mmap, ACCESS_READ
from xlrd import open_workbook

testxls = './剩余工作LIST.xls'

print(open_workbook(testxls))

with open(testxls, 'rb') as f:
 	print(open_workbook(file_contents=mmap(f.fileno(),0,access=ACCESS_READ)))

wb = open_workbook(testxls)

for s in wb.sheets():
	print ('Sheet:',s.name)
	for row in range(s.nrows):
		values = []
		for col in range(s.ncols):
			values.append(s.cell(row,col).value)
		print (','.join(str(values)))
{% endhighlight %}


## Getting a particular Cell（获取特定的Cell）

{% highlight Python %}
from xlrd import open_workbook,XL_CELL_TEXT

book = open_workbook(testxls)
sheet = book.sheet_by_index(0)
# cell = sheet.cell(0,0)

# print(cell)
# print(cell.value)
# print(cell.ctype==XL_CELL_TEXT)
for i in range(sheet.ncols):
	print (sheet.cell_type(1,i),sheet.cell_value(1,i))
{% endhighlight %}

## Iterating over the contents of a Sheet(迭代Sheet中的内容)

{% highlight Python %}
from xlrd import open_workbook

book = open_workbook(testxls)
sheet0 = book.sheet_by_index(0)
sheet1 = book.sheet_by_index(1)
print(sheet0.row(0))
print(sheet0.col(0))
print(sheet0.row_slice(0,1))
print(sheet0.row_slice(0,1,2))
print(sheet0.row_values(0,1))
print(sheet0.row_values(0,1,2))
print(sheet0.row_types(0,1))
print(sheet0.row_types(0,1,2))
print(sheet1.col_slice(0,1))
print(sheet0.col_slice(0,1,2))
print(sheet1.col_values(0,1))
print(sheet0.col_values(0,1,2))
print(sheet1.col_types(0,1))
print(sheet0.col_types(0,1,2))
{% endhighlight %}


## Types of Cell（cell的类型）  

 * Text: 对应常量 xlrd.XL_CELL_TEXT  
 * Number: 对应常量 xlrd.XL_CELL_NUMBER  
 * Date：对应常量 xlrd.XL_CELL_DATE  
 * NB: 数据并非真正存在于Excel文件中  
 * Boolean: 对应常量 xlrd.XL_CELL_BOOLEAN  
 * ERROR: 对应常量 xlrd.XL_CELL_ERROR  
 * Empty / Blank: 对应常来 xlrd.XL_CELL_EMPTY  
 * 等等等等...... balabala总之是Excel有啥就有啥  


## Writing Excel Files（写Excel文件）

一个Excel文件的构成包含：  

 1. Workbook 就当作是Excel文件本身了  
 2. Worksheets 就是sheet  
 3. Rows 每个sheet的行  
 4. Columns 每个sheet的列  
 5. Cells sheet上的每个独立块  

不幸的是xlwt不支持python3.X版本。Library to create spreadsheet files compatible with MS Excel 97/2000/XP/2003 XLS files, on any platform, with Python 2.3 to 2.7。
万幸的是有一个xlwt-future模块，支持Python3.X，用法据说与xlwt模块一模一样


pip install xlwt-future 装起来。  

## A Simple Example（一个简单的写xls文件例子）

{% highlight Python %}
from tempfile import TemporaryFile
from xlwt import Workbook

book = Workbook()
sheet1 = book.add_sheet('Sheet 1')
book.add_sheet('Sheet 2')
sheet1.write(0,0,'A1')
sheet1.write(0,1,'B1')
row1 = sheet1.row(1)
row1.write(0,'A2')
row1.write(1,'B2')

sheet1.col(0).width = 10000
sheet2 = book.get_sheet(1)
sheet2.row(0).write(0,'Sheet 2 A1')
sheet2.row(0).write(1,'Sheet 2 B1')
sheet2.flush_row_data()

sheet2.write(1,0,'Sheet 2 A3')
sheet2.col(0).width = 5000
sheet2.col(0).hidden = True
book.save('simple.xls')
book.save(TemporaryFile())
{% endhighlight %}





[HomePage]: http://www.python-excel.org/