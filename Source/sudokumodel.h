#ifndef SUDOKUMODEL_H
#define SUDOKUMODEL_H

#include <QAbstractListModel>
#include "engine.h"

class SudokuModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit SudokuModel(Engine &engine_, QObject *parent = nullptr);

    enum SudokuRoles {
        NumRole = Qt::UserRole
    };

    virtual QHash<int, QByteArray> roleNames() const override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;

    void Reset();

private:
    Engine &engine;
};

#endif // SUDOKUMODEL_H
