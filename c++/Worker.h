#ifndef Worker_H
#define Worker_H

#include <QObject>
#include <QColor>
#include <QThread>
/*
 * r  0-7
 * g  8-15
 * b  16-23
*/
typedef union {
    unsigned int rgbi;
    unsigned char rgbc[4];

}ICRGB;

class Worker : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(unsigned char r READ r )
    Q_PROPERTY(unsigned char g READ g )
    Q_PROPERTY(unsigned char b READ b )

    explicit Worker(QObject *parent = nullptr);
    QThread *mThread;
    int mMouseRGB;
    QColor mMouseColor;
    ICRGB mMouseColor01;
    unsigned char r()const;
    unsigned char g()const;
    unsigned char b()const;
signals:
    void mkPathSig();
    void getMouseColorSig();
    void setMouseColorSig();

public slots:
    void mkPathSlot();
    void getMouseColorSlot();
    void exitSlot();


};

#endif // Worker_H
