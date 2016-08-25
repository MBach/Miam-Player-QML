#ifndef LIBRARYITEMMODEL_H
#define LIBRARYITEMMODEL_H

#include <QSet>
#include <model/genericdao.h>
#include <filehelper.h>
#include "miamitemmodel.h"
#include "separatoritem.h"
#include "miamcore_global.h"

#include "libraryfilterproxymodel.h"

/**
 * \brief		The LibraryItemModel class is used to cache information from the database, in order to increase performance.
 * \author      Matthieu Bachelier
 * \copyright   GNU General Public License v3
 */
class MIAMCORE_LIBRARY LibraryItemModel : public MiamItemModel
{
	Q_OBJECT
private:
	LibraryFilterProxyModel *_proxy;

public:
	explicit LibraryItemModel(QObject *parent = nullptr);

	virtual ~LibraryItemModel();

    virtual QHash<int, QByteArray> roleNames() const override;

	virtual QChar currentLetter(const QModelIndex &index) const override;

	virtual LibraryFilterProxyModel* proxy() const override;

	/** Rebuild the list of separators when one has changed grammatical articles in options. */
	void rebuildSeparators();

	void reset();

	inline QMultiHash<SeparatorItem*, QModelIndex> topLevelItems() const { return _topLevelItems; }

public slots:
	virtual void load(const QString & = QString::null) override;
};

#endif // LIBRARYITEMMODEL_H
