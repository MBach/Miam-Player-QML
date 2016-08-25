#ifndef ALBUMITEM_H
#define ALBUMITEM_H

#include <QStandardItem>
#include "miamcore_global.h"

/**
 * \brief		The AlbumItem class
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY AlbumItem : public QStandardItem
{
public:
	explicit AlbumItem();

	virtual ~AlbumItem() {}

	virtual int type() const override;

	uint hash() const;
};

#endif // ALBUMITEM_H
