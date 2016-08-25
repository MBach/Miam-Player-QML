#ifndef ARTISTITEM_H
#define ARTISTITEM_H

#include <QStandardItem>
#include "miamcore_global.h"

/**
 * \brief		The ArtistItem class
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY ArtistItem : public QStandardItem
{
public:
	explicit ArtistItem();

	virtual ~ArtistItem() {}

	virtual int type() const override;

	uint hash() const;
};

#endif // ARTISTITEM_H
