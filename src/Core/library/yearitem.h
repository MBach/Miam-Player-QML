#ifndef YEARITEM_H
#define YEARITEM_H

#include <QStandardItem>
#include "libraryfilterproxymodel.h"
#include "miamcore_global.h"

/**
 * \brief		The YearItem class
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY YearItem : public QStandardItem
{
public:
	explicit YearItem(const QString &year);

	virtual ~YearItem() {}

	virtual int type() const override;

	uint hash() const;
};

#endif // YEARITEM_H
