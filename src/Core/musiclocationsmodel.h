#ifndef MUSICLOCATIONSMODEL_H
#define MUSICLOCATIONSMODEL_H

#include <QStringListModel>
#include "miamcore_global.h"

/**
 * \brief		The MusicLocationsModel class stores paths for the MusicScanner.
 * \author		Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY MusicLocationsModel : public QStringListModel
{
    Q_OBJECT
public:
    MusicLocationsModel(QObject *parent = nullptr);

    enum CustomRoles {
        FolderNameRole  = Qt::DisplayRole
    };

    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE inline bool isEmpty() const { return stringList().isEmpty(); }

private:
    QStringList format(QStringList locations);

public slots:
    void addFolder(const QString &folder);

    void removeFolder(const QString &folder);

signals:
    void musicLocationsHaveChanged(const QStringList &);
};

#endif // MUSICLOCATIONSMODEL_H
