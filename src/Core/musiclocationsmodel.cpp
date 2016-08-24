#include "musiclocationsmodel.h"

#include <QDir>
#include <QSettings>

#include <QtDebug>

MusicLocationsModel::MusicLocationsModel(QObject *parent)
    : QStringListModel(parent)
{
    QSettings settings;
    QStringList locations = settings.value("musicLocations").toStringList();
    this->setStringList(this->format(locations));
}

QHash<int, QByteArray> MusicLocationsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[FolderNameRole] = "folder";
    return roles;
}

QStringList MusicLocationsModel::format(QStringList locations)
{
    QStringList displayed;
    for (QString location : locations) {
        displayed << QDir::toNativeSeparators(location.remove("file:///"));
    }
    return displayed;
}

void MusicLocationsModel::addFolder(const QString &folder)
{
    QSettings settings;
    QStringList locations = settings.value("musicLocations").toStringList();
    if (!locations.contains(folder)) {
        locations << folder;
    }
    settings.setValue("musicLocations", locations);
    this->setStringList(this->format(locations));
    emit musicLocationsHaveChanged(this->stringList());
}

void MusicLocationsModel::removeFolder(const QString &folder)
{
    QSettings settings;
    QStringList locations = settings.value("musicLocations").toStringList();
    locations.removeOne(QDir::fromNativeSeparators(folder).prepend("file:///"));
    settings.setValue("musicLocations", locations);
    this->setStringList(this->format(locations));
    emit musicLocationsHaveChanged(this->stringList());
}
