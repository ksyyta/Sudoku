#ifndef SUDOKU_H
#define SUDOKU_H

#include <QObject>
#include <iostream>
#include "sudokufield.h"
#include "sudokumodel.h"

class Sudoku : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SudokuField *model READ GetModel)
public:
    explicit Sudoku(QObject *parent = nullptr);

    Q_INVOKABLE bool SetValue(int x, int y, int value)
    {
        if (engine.MakeMove(x, y, value)) {

            const auto table_idx = model.index(x, y);

            model.Reset();

            return true;
        }
        return false;
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
    Q_INVOKABLE void SelectSquare(int column, int row)
    {
    }
private:
    SudokuField* GetModel() { return &model; }

    Engine engine;
    SudokuField model{engine};
signals:

};

#endif // SUDOKU_H
