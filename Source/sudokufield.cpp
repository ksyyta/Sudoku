#include "sudokufield.h"

SudokuField::SudokuField(Engine &engine_, QObject *parent)
    : QAbstractTableModel(parent), engine(engine_)
{
}

QVariant SudokuField::headerData(int section, Qt::Orientation orientation, int role) const
{
    return QVariant();
}

bool SudokuField::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        // FIXME: Implement me!
        emit headerDataChanged(orientation, section, section);
        return true;
    }
    return false;
}


int SudokuField::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return 9;
}

int SudokuField::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return 9;
}

QVariant SudokuField::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const int row = index.row();
    const int col = index.column();

    switch (role) {
        case NumRole:
            return QVariant(engine.Value(col, row));
        break;

        case ConstRole:
            return QVariant(engine.DefaultValue(col, row) != 0);
        break;
    }

    return QVariant();
}

bool SudokuField::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SudokuField::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> SudokuField::roleNames() const
{
    QHash<int, QByteArray> names;

    names[NumRole] = "num";
    names[ConstRole] = "const";

    return names;
}

void SudokuField::Reset()
{
    beginResetModel();
    endResetModel();

}
