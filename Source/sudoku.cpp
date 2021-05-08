#include "sudoku.h"

Sudoku::Sudoku(QObject *parent) : QObject(parent)
{
    engine.StartGame();
}
