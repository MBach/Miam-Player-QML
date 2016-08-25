#ifndef MIAMCORE_GLOBAL_H
#define MIAMCORE_GLOBAL_H

#include <QtCore/qglobal.h>

#ifdef MIAM_PLUGIN
# define MIAMCORE_LIBRARY Q_DECL_EXPORT
#else
# define MIAMCORE_LIBRARY Q_DECL_IMPORT
#endif

#include <QMetaType>

/**
 * \brief		The Miam namespace contains Enums and utility functions. It's like Qt namespace.
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
namespace Miam
{
    enum ItemType : int
    {
        IT_Artist		= QMetaType::User + 1,
        IT_Album		= QMetaType::User + 2,
        IT_ArtistAlbum	= QMetaType::User + 3,
        IT_Disc			= QMetaType::User + 4,
        IT_Separator	= QMetaType::User + 5,
        IT_Track		= QMetaType::User + 6,
        IT_Year			= QMetaType::User + 7,
        IT_Playlist		= QMetaType::User + 8,
        IT_UnknownType	= QMetaType::User + 9,
        IT_Cover		= QMetaType::User + 10
    };

    // User defined data types (item->setData(QVariant, Field);)
    enum DataField : int
    {
        DF_ID					= Qt::UserRole + 1,
        DF_URI					= Qt::UserRole + 2,
        DF_CoverPath			= Qt::UserRole + 3,
        DF_TrackNumber			= Qt::UserRole + 4,
        DF_DiscNumber			= Qt::UserRole + 5,
        DF_NormalizedString		= Qt::UserRole + 6,
        DF_Year					= Qt::UserRole + 7,
        DF_Highlighted			= Qt::UserRole + 8,
        DF_IsRemote				= Qt::UserRole + 9,
        DF_IconPath				= Qt::UserRole + 10,
        DF_Rating				= Qt::UserRole + 11,
        DF_CustomDisplayText	= Qt::UserRole + 12,
        DF_NormArtist			= Qt::UserRole + 13,
        DF_NormAlbum			= Qt::UserRole + 14,
        DF_TrackLength			= Qt::UserRole + 15,
        DF_CurrentPosition		= Qt::UserRole + 16,
        DF_Artist				= Qt::UserRole + 17,
        DF_Album				= Qt::UserRole + 18,
        DF_InternalCover		= Qt::UserRole + 19
    };
}

#endif // MIAMCORE_GLOBAL_H
