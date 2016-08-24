#include "settingsprivate.h"

#include <QDateTime>
#include <QDir>
#include <QFile>
#include <QGuiApplication>
#include <QLibraryInfo>
#include <QStandardPaths>

#include <QtDebug>

SettingsPrivate* SettingsPrivate::settings = nullptr;

/** Private constructor. */
SettingsPrivate::SettingsPrivate(const QString &organization, const QString &application)
	: QSettings(IniFormat, UserScope, organization, application)
{
}

/** Singleton pattern to be able to easily use SettingsPrivate everywhere in the app. */
SettingsPrivate* SettingsPrivate::instance()
{
	if (settings == nullptr) {
		settings = new SettingsPrivate;
		settings->initLanguage(settings->language());
	}
	return settings;
}

/** Returns true if the background color in playlist is using alternatative colors. */
bool SettingsPrivate::colorsAlternateBG() const
{
	return value("colorsAlternateBG", true).toBool();
}

bool SettingsPrivate::copyTracksFromPlaylist() const
{
	return value("copyTracksFromPlaylist", false).toBool();
}

const QString SettingsPrivate::customIcon(const QString &buttonName) const
{
	return value("customIcons/" + buttonName).toString();
}

QString SettingsPrivate::defaultLocationFileExplorer() const
{
	if (value("defaultLocationFileExplorer").isNull()) {
		QStringList l = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
		if (!l.isEmpty()) {
			return l.first();
		}
	} else {
		return value("defaultLocationFileExplorer").toString();
	}
	return "/";
}

SettingsPrivate::DragDropAction SettingsPrivate::dragDropAction() const
{
	return static_cast<SettingsPrivate::DragDropAction>(value("dragDropAction").toInt());
}

bool SettingsPrivate::hasCustomIcon(const QString &buttonName) const
{
	return value("customIcons/" + buttonName).isValid() && value("customIcons/" + buttonName).toBool();
}

SettingsPrivate::InsertPolicy SettingsPrivate::insertPolicy() const
{
	if (value("insertPolicy").isNull()) {
		return SettingsPrivate::IP_Artists;
	} else {
		int i = value("insertPolicy").toInt();
		return (SettingsPrivate::InsertPolicy)i;
	}
}

bool SettingsPrivate::isCustomColors() const
{
	return value("customColors", false).toBool();
}

bool SettingsPrivate::isCustomTextColorOverriden() const
{
	bool b = value("customTextColorOverriden", false).toBool();
	return b && isCustomColors();
}

bool SettingsPrivate::isExtendedSearchVisible() const
{
	return value("extendedSearchVisible", true).toBool();
}

/** Returns true if background process is active to keep library up-to-date. */
bool SettingsPrivate::isFileSystemMonitored() const
{
	return value("monitorFileSystem", true).toBool();
}

/** Returns the hierarchical order of the library tree view. */
bool SettingsPrivate::isLibraryFilteredByArticles() const
{
	return value("isLibraryFilteredByArticles", false).toBool();
}

bool SettingsPrivate::isPlaylistResizeColumns() const
{
	return value("playlistResizeColumns", true).toBool();
}

/** Returns true if tabs should be displayed like rectangles. */
bool SettingsPrivate::isRectTabs() const
{
	return value("rectangularTabs", false).toBool();
}

bool SettingsPrivate::isRemoteControlEnabled() const
{
	return value("remoteControl").toBool();
}

/** Returns true if the article should be displayed after artist's name. */
bool SettingsPrivate::isReorderArtistsArticle() const
{
	return value("reorderArtistsArticle", false).toBool();
}

/** Returns true if a user has modified one of defaults theme. */
bool SettingsPrivate::isButtonThemeCustomized() const
{
	return value("buttonThemeCustomized", false).toBool();
}

/** Returns the language of the application. */
QString SettingsPrivate::language()
{
	QString l = value("language").toString();
	if (l.isEmpty()) {
		l = QLocale::system().uiLanguages().first().left(2);
		setValue("language", l);
		return l;
	} else {
		return l;
	}
}

/** Returns the last active playlist header state. */
QByteArray SettingsPrivate::lastActivePlaylistGeometry() const
{
	return value("lastActivePlaylistGeometry").toByteArray();
}

QByteArray SettingsPrivate::lastActiveViewGeometry(const QString &menuAction) const
{
	return value(menuAction).toByteArray();
}

/** Returns the last playlists that were opened when player was closed. */
QList<uint> SettingsPrivate::lastPlaylistSession() const
{
	QList<QVariant> l = value("currentSessionPlaylists").toList();
	QList<uint> playlistIds;
	for (int i = 0; i < l.count(); i++) {
		playlistIds.append(l.at(i).toUInt());
	}
	return playlistIds;
}

QStringList SettingsPrivate::libraryFilteredByArticles() const
{
	QVariant vArticles = value("libraryFilteredByArticles");
	if (vArticles.isValid()) {
		return vArticles.toStringList();
	} else {
		return QStringList();
	}
}

SettingsPrivate::LibrarySearchMode SettingsPrivate::librarySearchMode() const
{
	if (value("librarySearchMode").isNull()) {
		return SettingsPrivate::LSM_Filter;
	} else {
		int i = value("librarySearchMode").toInt();
		return (SettingsPrivate::LibrarySearchMode)i;
	}
}

QStringList SettingsPrivate::musicLocations() const
{
	QStringList list;
	list.append(value("musicLocations").toStringList());
	return list;
}

int SettingsPrivate::tabsOverlappingLength() const
{
	return value("tabsOverlappingLength", 10).toInt();
}

/// PlayBack options
qint64 SettingsPrivate::playbackSeekTime() const
{
	return value("playbackSeekTime", 5000).toLongLong();
}

/** Default action to execute when one is closing a playlist. */
SettingsPrivate::PlaylistDefaultAction SettingsPrivate::playbackDefaultActionForClose() const
{
	return static_cast<SettingsPrivate::PlaylistDefaultAction>(value("playbackDefaultActionForClose").toInt());
}

/** Automatically save all playlists before exit. */
bool SettingsPrivate::playbackKeepPlaylists() const
{
	return value("playbackKeepPlaylists", false).toBool();
}

/** Automatically restore all saved playlists at startup. */
bool SettingsPrivate::playbackRestorePlaylistsAtStartup() const
{
	return value("playbackRestorePlaylistsAtStartup", false).toBool();
}

uint SettingsPrivate::remoteControlPort() const
{
	return value("remoteControlPort", 5600).toUInt();
}

void SettingsPrivate::setCustomIcon(const QString &buttonName, const QString &iconPath)
{
	if (iconPath.isEmpty()) {
		remove("customIcons/" + buttonName);
	} else {
		setValue("customIcons/" + buttonName, iconPath);
	}
	emit customIconForMediaButtonChanged(buttonName);
}

bool SettingsPrivate::setLanguage(const QString &lang)
{
	setValue("language", lang);
	bool b = this->initLanguage(lang);
	if (b) {
		emit languageAboutToChange(lang);
	}
	return b;
}

void SettingsPrivate::setLastActiveViewGeometry(const QString &menuAction, const QByteArray &viewGeometry)
{
	setValue("lastActiveView", menuAction);
	setValue(menuAction, viewGeometry);
}

/** Sets the last playlists that were opened when player is about to close. */
void SettingsPrivate::setLastPlaylistSession(const QList<uint> &ids)
{
	QList<QVariant> l;
	for (int i = 0; i < ids.count(); i++) {
		l.append(ids.at(i));
	}
	setValue("currentSessionPlaylists", l);
}

void SettingsPrivate::setMusicLocations(const QStringList &locations)
{
	QStringList old = value("musicLocations").toStringList();
	setValue("musicLocations", locations);
	emit musicLocationsHaveChanged(old, locations);
}

void SettingsPrivate::setRemoteControlEnabled(bool b)
{
	setValue("remoteControl", b);
	emit remoteControlChanged(b, value("remoteControlPort").toUInt());
}

int SettingsPrivate::volumeBarHideAfter() const
{
	if (value("volumeBarHideAfter").isNull()) {
		return 1;
	} else {
		return value("volumeBarHideAfter").toInt();
	}
}

bool SettingsPrivate::initLanguage(const QString &lang)
{
	QString language(":/translations/player_" + lang + ".qm");
	bool b = QFile::exists(language);
	if (b) {
        /*bool b =*/ playerTranslator.load(language);
		defaultQtTranslator.load("qt_" + lang, QLibraryInfo::location(QLibraryInfo::TranslationsPath));
		/// TODO: reload plugin UI
        //b &= QApplication::installTranslator(&playerTranslator);
        //QApplication::installTranslator(&defaultQtTranslator);
	}
	return b;
}

void SettingsPrivate::setDefaultLocationFileExplorer(const QString &location)
{
	setValue("defaultLocationFileExplorer", location);
}

/** Define the hierarchical order of the library tree view. */
void SettingsPrivate::setInsertPolicy(SettingsPrivate::InsertPolicy ip)
{
	setValue("insertPolicy", ip);
}

/// SLOTS

/** Add a list of folders to settings. */
void SettingsPrivate::addMusicLocations(const QList<QDir> &dirs)
{
	QStringList old = value("musicLocations").toStringList();
	QStringList locations;
	for (QDir d : dirs) {
		if (!old.contains(QDir::toNativeSeparators(d.absolutePath()))) {
			locations << d.absolutePath();
		} else {
			qDebug() << Q_FUNC_INFO << old << "already contains" << d.absolutePath();
		}
	}
	QStringList newLocations(old);
	newLocations.append(locations);
	setValue("musicLocations", newLocations);
	qDebug() << Q_FUNC_INFO << newLocations;
	emit musicLocationsHaveChanged(old, locations);
}

/** Sets an alternate background color for playlists. */
void SettingsPrivate::setColorsAlternateBG(bool b)
{
	setValue("colorsAlternateBG", b);
}

/** Copy or move tracks from one playlist to another. */
void SettingsPrivate::setCopyTracksFromPlaylist(bool b)
{
	setValue("copyTracksFromPlaylist", b);
}

/** Sets the default action when one is dropping tracks or folders. */
void SettingsPrivate::setDragDropAction(DragDropAction action)
{
	setValue("dragDropAction", action);
}

/** Sets a popup when one is searching text in Library (Playlist mode only). */
void SettingsPrivate::setExtendedSearchVisible(bool b)
{
	setValue("extendedSearchVisible", b);
}

/** Sets user defined articles (like 'The', 'Le') to sort the Library. */
void SettingsPrivate::setIsLibraryFilteredByArticles(bool b)
{
	setValue("isLibraryFilteredByArticles", b);
}

/** Save the last active playlist header state. */
void SettingsPrivate::setLastActivePlaylistGeometry(const QByteArray &ba)
{
	setValue("lastActivePlaylistGeometry", ba);
}

/** Sets user defined list of articles to sort the Library. */
void SettingsPrivate::setLibraryFilteredByArticles(const QStringList &tagList)
{
	if (tagList.isEmpty()) {
		remove("libraryFilteredByArticles");
	} else {
		setValue("libraryFilteredByArticles", tagList);
	}
}

/** Sets if MiamPlayer should launch background process to keep library up-to-date. */
void SettingsPrivate::setMonitorFileSystem(bool b)
{
	setValue("monitorFileSystem", b);
	emit monitorFileSystemChanged(b);
}

/// PlayBack options
void SettingsPrivate::setPlaybackSeekTime(int t)
{
	setValue("playbackSeekTime", t*1000);
}

void SettingsPrivate::setPlaybackCloseAction(PlaylistDefaultAction action)
{
	setValue("playbackDefaultActionForClose", action);
}

void SettingsPrivate::setPlaybackKeepPlaylists(bool b)
{
	setValue("playbackKeepPlaylists", b);
}

void SettingsPrivate::setReorderArtistsArticle(bool b)
{
	setValue("reorderArtistsArticle", b);
}

void SettingsPrivate::setSearchAndExcludeLibrary(bool b)
{
	LibrarySearchMode lsm;
	if (b) {
		lsm = LSM_Filter;
	} else {
		lsm = LSM_HighlightOnly;
	}
	setValue("librarySearchMode", lsm);
	emit librarySearchModeHasChanged();
}

void SettingsPrivate::setPlaybackRestorePlaylistsAtStartup(bool b)
{
	setValue("playbackRestorePlaylistsAtStartup", b);
}

void SettingsPrivate::setRemoteControlPort(uint port)
{
	setValue("remoteControlPort", port);
	emit remoteControlChanged(true, port);
}

void SettingsPrivate::setTabsOverlappingLength(int l)
{
	setValue("tabsOverlappingLength", l);
}

void SettingsPrivate::setTabsRect(bool b)
{
	setValue("rectangularTabs", b);
}

void SettingsPrivate::setButtonThemeCustomized(bool b)
{
	setValue("buttonThemeCustomized", b);
}

void SettingsPrivate::setVolumeBarHideAfter(int seconds)
{
	setValue("volumeBarHideAfter", seconds);
}
