#include <QDir>
#include <QDebug>
#include <Windows.h>
#include <winddi.h>
#include "Worker.h"

#pragma comment  (lib, "User32.lib")
#pragma comment  (lib, "gdi32.lib")

Worker::Worker(QObject *parent) : QObject(parent)
{
    mThread=new QThread;
    this->moveToThread(mThread);
    mThread->start();
    connect(this,&Worker::mkPathSig,this,&Worker::mkPathSlot);
    connect(this,&Worker::getMouseColorSig,this,&Worker::getMouseColorSlot);
}
void Worker::mkPathSlot(){
    QDir dir(".");
    if(!dir.exists("Pic"))
        dir.mkdir("Pic");
}

void Worker::getMouseColorSlot(){
    HDC dc = GetDC(0);//0表示获取桌面的DC上下文
    POINT Mouse;
    GetCursorPos(&Mouse);//获取当前鼠标位置
    mMouseColor01.rgbi = GetPixel(dc,Mouse.x,Mouse.y);

    mMouseColor = QColor(mMouseColor01.rgbc[0],mMouseColor01.rgbc[1],mMouseColor01.rgbc[2]);
#ifdef QT_NO_DEBUG
    qDebug() << "release mode";
#else
    qDebug()<<"rgb"<<mMouseColor01.rgbc[0] << mMouseColor01.rgbc[1]<<mMouseColor01.rgbc[2];
#endif
    emit setMouseColorSig();

}

void Worker::exitSlot(){
    this->mThread->quit();
    this->mThread->wait();
}
unsigned char Worker::r()const{
    return mMouseColor01.rgbc[0];
}

unsigned char Worker::g()const{
    return mMouseColor01.rgbc[1];
}

unsigned char Worker::b()const{
    return mMouseColor01.rgbc[2];
}


