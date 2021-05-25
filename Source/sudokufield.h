#ifndef SUDOKUFIELD_H
#define SUDOKUFIELD_H

#include <QAbstractTableModel>
#include "engine.h"

class SudokuField : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit SudokuField(Engine &engine_, QObject *parent = nullptr);

    enum SudokuRoles {
        NumRole = Qt::UserRole,
        ConstRole,
    };

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    bool setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role = Qt::EditRole) override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    void Reset();

private:
    Engine &engine;
};

#endif // SUDOKUFIELD_H
