#ifndef SETTINGSPRIVATE_H
#define SETTINGSPRIVATE_H

#include <QFileInfo>
#include <QSettings>
#include <QTranslator>

#include "miamcore_global.h"

/**
 * \brief		SettingsPrivate class contains all relevant pairs of (keys, values) used by Miam-Player.
 * \details		This class implements the Singleton pattern. Instead of using standard "this->value(QString)", lots of methods
 *				are built on-top of it. It keeps the code easy to read and some important enums are shared between plugins too.
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY SettingsPrivate : public QSettings
{
	Q_OBJECT
private:
	/** The unique instance of this class. */
	static SettingsPrivate *settings;

	/** Private constructor. */
	SettingsPrivate(const QString &organization = "MmeMiamMiam",
			 const QString &application = "MiamPlayer");

	/** Store the size of each font used in the app. */
	QMap<QString, QVariant> fontPointSizeMap;

	/** Store the family of each font used in the app. */
	QMap<QString, QVariant> fontFamilyMap;

	Q_ENUMS(DragDropAction)
	Q_ENUMS(FontFamily)
	Q_ENUMS(InsertPolicy)
	Q_ENUMS(LibrarySearchMode)
	Q_ENUMS(PlaylistDefaultAction)

public:
	enum DragDropAction { DD_OpenPopup		= 0,
						  DD_AddToLibrary	= 1,
						  DD_AddToPlaylist	= 2};

	enum FontFamily { FF_Playlist	= 0,
					  FF_Library	= 1,
					  FF_Menu		= 2};

	enum InsertPolicy { IP_Artists			= 0,
						IP_Albums			= 1,
						IP_ArtistsAlbums	= 2,
						IP_Years			= 3};

	enum LibrarySearchMode { LSM_Filter			= 0,
							 LSM_HighlightOnly	= 1};

	enum PlaylistDefaultAction { PDA_AskUserForAction	= 0,
								 PDA_SaveOnClose		= 1,
								 PDA_DiscardOnClose		= 2};

	QTranslator playerTranslator, defaultQtTranslator;

	/** Singleton Pattern to easily use Settings everywhere in the app. */
	static SettingsPrivate* instance();

	/** Returns true if the background color in playlist is using alternatative colors. */
	bool colorsAlternateBG() const;

	bool copyTracksFromPlaylist() const;

	/** Custom icons in Customize(Theme) */
	const QString customIcon(const QString &buttonName) const;

	QString defaultLocationFileExplorer() const;

	DragDropAction dragDropAction() const;

	/** Custom icons in CustomizeTheme */
	bool hasCustomIcon(const QString &buttonName) const;

	InsertPolicy insertPolicy() const;

	bool isCustomColors() const;

	bool isCustomTextColorOverriden() const;

	bool isExtendedSearchVisible() const;

	/** Returns true if background process is active to keep library up-to-date. */
	bool isFileSystemMonitored() const;

	/** Returns the hierarchical order of the library tree view. */
	bool isLibraryFilteredByArticles() const;

	bool isPlaylistResizeColumns() const;

	/** Returns true if tabs should be displayed like rectangles. */
	bool isRectTabs() const;

	bool isRemoteControlEnabled() const;

	/** Returns true if the article should be displayed after artist's name. */
	bool isReorderArtistsArticle() const;

	/** Returns true if a user has modified one of defaults theme. */
	bool isButtonThemeCustomized() const;

	/** Returns the language of the application. */
	QString language();

	/** Returns the last active playlist header state. */
	QByteArray lastActivePlaylistGeometry() const;

	QByteArray lastActiveViewGeometry(const QString &menuAction) const;

	/** Returns the last playlists that were opened when player was closed. */
	QList<uint> lastPlaylistSession() const;

	QStringList libraryFilteredByArticles() const;

	LibrarySearchMode librarySearchMode() const;

	/** Returns all music locations. */
	QStringList musicLocations() const;

	int tabsOverlappingLength() const;

	/// PlayBack options
	qint64 playbackSeekTime() const;

	/** Default action to execute when one is closing a playlist. */
	PlaylistDefaultAction playbackDefaultActionForClose() const;

	/** Automatically save all playlists before exit. */
	bool playbackKeepPlaylists() const;

	/** Automatically restore all saved playlists at startup. */
	bool playbackRestorePlaylistsAtStartup() const;

	uint remoteControlPort() const;

	/** Custom icons in CustomizeTheme */
	void setCustomIcon(const QString &buttonName, const QString &iconPath);

	/** Sets the language of the application. */
	bool setLanguage(const QString &lang);

	void setLastActiveViewGeometry(const QString &menuAction, const QByteArray &viewGeometry);

	/** Sets the last playlists that were opened when player is about to close. */
	void setLastPlaylistSession(const QList<uint> &ids);

	void setMusicLocations(const QStringList &locations);

	void setRemoteControlEnabled(bool b);

	int volumeBarHideAfter() const;

private:
	bool initLanguage(const QString &lang);

public:
	void setDefaultLocationFileExplorer(const QString &location);

	/** Define the hierarchical order of the library tree view. */
	void setInsertPolicy(InsertPolicy ip);

public slots:
	/** Add a list of folders to settings. */
	void addMusicLocations(const QList<QDir> &dirs);

	/** Sets an alternate background color for playlists. */
	void setColorsAlternateBG(bool b);

	/** Copy or move tracks from one playlist to another. */
	void setCopyTracksFromPlaylist(bool b);

	/** Sets the default action when one is dropping tracks or folders. */
	void setDragDropAction(DragDropAction action);

	/** Sets a popup when one is searching text in Library (Playlist mode only). */
	void setExtendedSearchVisible(bool b);

	/** Sets user defined articles (like 'The', 'Le') to sort the Library. */
	void setIsLibraryFilteredByArticles(bool b);

	/** Save the last active playlist header state. */
	void setLastActivePlaylistGeometry(const QByteArray &);

	/** Sets user defined list of articles to sort the Library. */
	void setLibraryFilteredByArticles(const QStringList &tagList);

	/** Sets if MiamPlayer should launch background process to keep library up-to-date. */
	void setMonitorFileSystem(bool b);

	/// PlayBack options
	void setPlaybackSeekTime(int t);
	void setPlaybackCloseAction(PlaylistDefaultAction action);
	void setPlaybackKeepPlaylists(bool b);
	void setPlaybackRestorePlaylistsAtStartup(bool b);

	void setRemoteControlPort(uint port);

	void setReorderArtistsArticle(bool b);

	void setSearchAndExcludeLibrary(bool b);

	void setTabsOverlappingLength(int l);

	void setTabsRect(bool b);

	void setButtonThemeCustomized(bool b);

	void setVolumeBarHideAfter(int seconds);

signals:
	void customIconForMediaButtonChanged(const QString &button);

	void languageAboutToChange(const QString &newLanguage);

	void fontHasChanged(FontFamily, const QFont &font);

	void librarySearchModeHasChanged();

	void monitorFileSystemChanged(bool);

	/** Signal sent whether the music locations have changed or not. */
	void musicLocationsHaveChanged(const QStringList &oldLocations, const QStringList &newLocations);

	void remoteControlChanged(bool enabled, uint port);
};

#endif // SETTINGSPRIVATE_H
