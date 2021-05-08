#ifndef SUDOKU_H
#define SUDOKU_H

#include <QObject>
#include "sudokufield.h"
#include "sudokumodel.h"

class Sudoku : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SudokuField *model READ GetModel)
public:
    explicit Sudoku(QObject *parent = nullptr);

    Q_INVOKABLE void SetValue(int x, int y, int value)
    {
        if (engine.MakeMove(x, y, value)) {

            const auto table_idx = model.index(x, y);

            emit model.dataChanged(table_idx, table_idx, QVector<int>() << SudokuField::NumRole);
        }
    }

    Q_INVOKABLE void Solve()
    {
        engine.Solve();
        model.Reset();
    }
    Q_INVOKABLE void Hint()
    {
        engine.Hint();
        model.Reset();
    }
    Q_INVOKABLE void Clear()
    {
        engine.Refresh();
        model.Reset();
    }
private:
    SudokuField* GetModel() { return &model; }

    Engine engine;
    SudokuField model{engine};
signals:

};

#endif // SUDOKU_H
