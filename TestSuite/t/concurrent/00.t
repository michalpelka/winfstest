#!/usr/bin/python

# CreateFile CreationDisposition
# DeleteFile

from winfstest import *

name1 = uniqnameDrive1()
name2 = uniqnameDrive2()

with expect_task("CreateFile %s GENERIC_WRITE FILE_SHARE_READ 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name1, 0):
    expect("CreateFile %s GENERIC_READ FILE_SHARE_READ 0 OPEN_EXISTING 0 0" % name2, "ERROR_SHARING_VIOLATION")
    expect("CreateFile %s GENERIC_READ FILE_SHARE_WRITE 0 OPEN_EXISTING 0 0" % name2, 0)
    expect("CreateFile %s DELETE FILE_SHARE_DELETE 0 OPEN_EXISTING 0 0" % name2, "ERROR_SHARING_VIOLATION")
    expect("CreateFile %s DELETE FILE_SHARE_WRITE 0 OPEN_EXISTING 0 0" % name2, "ERROR_SHARING_VIOLATION")

testdone()
