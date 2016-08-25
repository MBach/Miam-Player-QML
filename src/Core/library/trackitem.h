#ifndef TRACKITEM_H
#define TRACKITEM_H

#include <QStandardItem>
#include "miamcore_global.h"

/**
 * \brief		The TrackItem class
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY TrackItem : public QStandardItem
{
public:
	explicit TrackItem();

	virtual ~TrackItem() {}

	virtual int type() const override;
};

#endif // TRACKITEM_H
