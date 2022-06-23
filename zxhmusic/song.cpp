#include "song.h"
#include <fstream>
#include <iostream>
#include <QDebug>
#include <id3/tag.h>
#include <QVariant>
#include <taglib/id3v1tag.h>
#include <taglib/id3v2tag.h>
#include <taglib/tag.h>
#include <taglib/mpegfile.h>
#include <taglib/attachedpictureframe.h>
using namespace std;

Song::Song(QObject *parent):QObject(parent){
    clearInformations();
}

void Song::getInformations(QString url,QString diaPath){
    QByteArray ba=url.toUtf8();//访问QByteArray主要有4中方式，分别为[]、at()、data[]和constData[]。其中[]和data[]为可读可写
    //从串口读取到的QByteArray数据，一般需要进行提取和解析，此时就需要QByteArray转换为各类型数据
    const char *ch=ba.data();
    m_pic=diaPath+"/pic.png";
    QString end;//歌名后缀
    if(url!=""){
        for(int i=url.length()-1;i>=0;i--){
            if(url[i]==QString(".")){
                end=url.mid(i+1,url.length()-i);
                break;
            }
        }
        if(end=="mp3"){
            mp3Open(ch);
        }
    }
    else{
        clearInformations();
        m_flag=false;
    }
}

void Song::saveInformations(QString url,QVariantMap map){
    QByteArray ba=url.toUtf8();
    const char *ch=ba.data();
    QString end;//歌名后缀
    for(int i=url.length()-1;i>=0;i--){
        if(url[i]==QString(".")){
            end=url.mid(i+1,url.length()-i);
            break;
        }
    }
    if(end=="mp3"){
        mp3Open(ch);
    }
}

void Song::mp3Open(const char *ch){
    //用taglib提取mp3文件中的图片和一些其它信息的实例
    TagLib::MPEG::File *mpegFile = new TagLib::MPEG::File(ch);//Opens a new MPEG file
    m_Informations.clear();

    if(mpegFile->isOpen()){
        m_Informations["标题"]=mpegFile->tag()->title().toCString();
        m_Informations["艺术家"]=mpegFile->tag()->artist().toCString();
        m_Informations["唱片集"]=mpegFile->tag()->album().toCString();
        m_Informations["注释"]=mpegFile->tag()->comment().toCString();
        m_Informations["流派"]=mpegFile->tag()->genre().toCString();
        m_Informations["日期"]=mpegFile->tag()->year();
    }
    TagLib::ID3v2::Tag *id3v2tag=mpegFile->ID3v2Tag();
    if(id3v2tag){
        TagLib::ID3v2::FrameList list=mpegFile->ID3v2Tag()->frameListMap()["APIC"];//得到专辑图片列表
        if(!list.isEmpty()){
            TagLib::ID3v2::AttachedPictureFrame *picture=static_cast<TagLib::ID3v2::AttachedPictureFrame *>(list.front());//指针指向第一张图片
            size_t size=picture->picture().size();
            fstream file;
            file.open(m_pic.toUtf8().data(),fstream::out|ios_base::trunc);
            file.write(picture->picture().data(),size);
            file.close();
            m_flag=true;
        }
        else{
            m_flag=false;
        }
    }
}

void Song::mp3Save(const char *ch, QVariantMap map){
    TagLib::String str;
    TagLib::MPEG::File *mpegFile=new TagLib::MPEG::File(ch);//Opens a new MPEG file
    QByteArray ba;

    ba=map["标题"].toString().toUtf8();
    str=ba.data();
    mpegFile->tag()->setTitle(str);

    ba=map["艺术家"].toString().toUtf8();
    str=ba.data();
    mpegFile->tag()->setArtist(str);

    ba=map["唱片集"].toString().toUtf8();
    str=ba.data();
    mpegFile->tag()->setAlbum(str);

    ba=map["注释"].toString().toUtf8();
    str=ba.data();
    mpegFile->tag()->setComment(str);

    ba=map["流派"].toString().toUtf8();
    str=ba.data();
    mpegFile->tag()->setGenre(str);

    mpegFile->tag()->setYear(map["日期"].toUInt());

    if(mpegFile->save()){
        qDebug()<<"save successfully";
    }
    else{
        qDebug()<<"save failed";
    }
}

void Song::clearInformations(){
    m_Informations["标题"]=" ";
    m_Informations["艺术家"]=" ";
    m_Informations["唱片集"]=" ";
    m_Informations["注释"]=" ";
    m_Informations["流派"]=" ";
    m_Informations["日期"]=" ";
}

bool Song::flag() const{
    return m_flag;
}

void Song::setflag(bool newFlag){
    if(m_flag==newFlag)
        return;
    m_flag=newFlag;
    emit flagChanged();//emit是不同窗口或类间的触发信号。当对象改变其状态时，信号就由该对象发射 (emit) 出去，通过槽函数实现用户想要的效果。
}
