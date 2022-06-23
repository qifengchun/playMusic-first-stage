#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QVariantMap>
class Song:public QObject{
    Q_OBJECT
    Q_PROPERTY(QVariantMap Informations  READ Informations WRITE setInformations NOTIFY InformationsChanged)
    Q_PROPERTY(bool flag READ flag WRITE setflag NOTIFY flagChanged)
public:
    explicit Song(QObject *parent=nullptr);
    Q_INVOKABLE void getInformations(QString url,QString dirPath);
    Q_INVOKABLE void saveInformations(QString url,QVariantMap map);

    void mp3Open(const char *ch);
    void mp3Save(const char *ch,QVariantMap map);
    void clearInformations();
    QVariantMap Informations() const{
        return m_Informations;
    }
    bool flag() const;
    void setflag(bool newFlag);

public slots:
    void setInformations(QVariantMap Informations){
        if(m_Informations==Informations)
            return;
        m_Informations==Informations;
        emit InformationsChanged(m_Informations);
    }

signals:
    void InformationsChanged(QVariantMap Informations);
    void flagChanged();
private:
    QVariantMap m_Informations;
    bool m_flag;
    QString m_pic;
};

#endif // SONG_H
