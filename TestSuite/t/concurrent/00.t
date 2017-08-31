#!/usr/bin/python

# CreateFile CreationDisposition
# DeleteFile

from winfstest import *
import time
import random

i = int(1000*random.random())
name0 = 'X:/test'+str(i)
name1 = 'M:/test'+str(i)


with expect_task("CreateFile %s GENERIC_WRITE 0 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name0, 0):
	expect("CreateFile %s GENERIC_WRITE 0 0 OPEN_EXISTING 0 0" % name1, "ERROR_SHARING_VIOLATION")
expect("DeleteFile %s" % name0, 0)

with expect_task("CreateFile %s GENERIC_READ FILE_SHARE_READ 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name0, 0):
	expect("CreateFile %s GENERIC_READ FILE_SHARE_READ 0 OPEN_EXISTING 0 0" % name1, 0)
expect("DeleteFile %s" % name0, 0)

with expect_task("CreateFile %s GENERIC_WRITE FILE_SHARE_WRITE 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name0, 0):
	expect("CreateFile %s GENERIC_WRITE FILE_SHARE_WRITE 0 OPEN_EXISTING 0 0" % name1, 0)
expect("DeleteFile %s" % name0, 0)

with expect_task("CreateFile %s GENERIC_WRITE 0 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name0, 0):
	expect("DeleteFile %s" % name0, "ERROR_SHARING_VIOLATION")

with expect_task("CreateFile %s GENERIC_READ FILE_SHARE_DELETE 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name0, 0):
	expect("DeleteFile %s" % name0, 0)

testdone()
