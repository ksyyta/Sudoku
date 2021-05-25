#ifndef SUDOKU_H
#define SUDOKU_H

#include <QObject>
#include <iostream>
#include "sudokufield.h"

class Sudoku : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SudokuField *model READ GetModel CONSTANT)
public:
    explicit Sudoku(QObject *parent = nullptr);

    Q_INVOKABLE bool SetValue(int x, int y, int value)
    {
        if (engine.Value(x, y))
            return true;

        if (engine.MakeMove(x, y, value)) {
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
    Q_INVOKABLE void Clear(int x, int y)
    {
        if (engine.ClearCell(x, y))
            model.Reset();
    }
    Q_INVOKABLE void Restart()
    {
        engine.StartGame();
        model.Reset();
    }
private:
    SudokuField* GetModel() { return &model; }

    Engine engine;
    SudokuField model{engine};
signals:

};

#endif // SUDOKU_H
