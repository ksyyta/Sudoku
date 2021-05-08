#include "sudokumodel.h"

SudokuModel::SudokuModel(Engine &engine_, QObject *parent)
    : QAbstractListModel(parent), engine(engine_)
{
}

int SudokuModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return 81;
}

QVariant SudokuModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const int row = index.row() / 9;
    const int col = index.row() % 9;

    return QVariant(engine.Value(col, row));
}

bool SudokuModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SudokuModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> SudokuModel::roleNames() const
{
    QHash<int, QByteArray> names;

    names[NumRole] = "num";

    return names;
}

void SudokuModel::Reset()
{
    beginResetModel();
    endResetModel();

}

