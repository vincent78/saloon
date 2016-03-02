#! /usr/bin/env python  
# -*- coding: utf-8 -*-  

# 解析从  http://www.iconfont.cn/  中下载的内容，生成项目所需用的json
# collectioninfo.py html的路径   生成json文件的路径
#  ./collectIconInfo.py  ../doc/iconfont-common/demo.html test.json


import sys
import os
from HTMLParser import HTMLParser
from htmlentitydefs import entitydefs
import json


htmlItems = []

class iconHtmlParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.flag = False
        self.nameFlag = False
        self.codeFlag = False
        self.fontFlag = False
        self.join = False
        self.items = []
        self.name = ""
        self.code = ""
        self.font = ""


        # print 'parse begin'

    def handle_starttag(self,tag,attrs):
        if tag == 'li' :
            self.flag = True
            self.nameFlag = False
            self.codeFlag = False
            self.fontFlag = False

        if tag == 'div' and attrs and self.flag:
            for key,value in attrs:
                if value == 'name' and key == 'class' :
                    self.nameFlag = True
                if value == 'code' and key == 'class':
                    self.codeFlag = True
                if value == 'fontclass' and key == 'class':
                    self.fontFlag = True
    
    def handle_data(self,data):
        if self.flag and self.nameFlag :
            if self.join :
                self.name = self.name+data
                self.join = False
            else: 
                self.name = data  


        if self.flag and self.codeFlag :
            if self.join :
                self.code = self.code+data
                self.join = False
            else: 
                self.code = data 
                      

        if self.flag and self.fontFlag :
            if self.join :
                self.font = self.font+data
                self.join = False
            else: 
                self.font = data 
            

    def handle_endtag(self,tag):
        if tag == 'div' and self.nameFlag :
            self.nameFlag = False
        if tag == 'div' and self.codeFlag :
            self.codeFlag = False
        if tag == 'div' and self.fontFlag :
            self.fontFlag = False
        if tag == 'li' and self.flag :
            self.flag = False
            self.items.append((self.code,self.name,self.font))

    
    def handle_entityref(self , name):
        if entitydefs.has_key(name):
            self.handle_data(entitydefs[name])
        else:
            self.handle_data('&'+name+';')
        self.join = True    

    def getItems(self):
        return self.items               


def read_html_file(path):    
    content = ''
    if os.path.exists(path):
        print('开始读取文件:[{}]'.format(path))
        with open(path, 'r') as pf:
            for line in pf:
                content += line
            pf.close()
            return content
    else:
        print('the path [{}] dosen\'t exist!'.format(path))
        return content

def getItemsFromHtml(filePath):
    global htmlItems
    htmlContent = read_html_file(filePath)
    htmlParser = iconHtmlParser()
    htmlParser.feed(htmlContent)
    htmlParser.close()     
    htmlItems =  htmlParser.getItems()

def createJsonFile(targetFilePath):
    jsonObj = []
    for code,name,font in htmlItems:
        tmpObj = {"code":code,"name":name,"font":font}
        jsonObj.append(tmpObj)

    json.dump(jsonObj,open(targetFilePath,'w'),ensure_ascii=False,indent=4)    



if __name__ == '__main__':
    if len(sys.argv) < 3:
        print 'please input %s fileName, eg: ./%s ' % (sys.argv[0],sys.argv[0])
        sys.exit(-1)
    fileName = sys.argv[1]
    filePath = os.path.abspath(fileName)
    if not os.path.isfile(filePath):
        print 'the file[%s]' %(filePath),' is not exists'
        sys.exit(-1)    
    
    getItemsFromHtml(os.path.abspath(filePath))

    targetFile = sys.argv[2]
    targetPath = os.path.abspath(targetFile)
    if os.path.isfile(targetPath):
        os.remove(targetPath)
    createJsonFile(targetPath)

    print 'the end!'

    # for code,name,font in htmlItems:
    #     print code,name,font  



