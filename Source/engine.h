#ifndef ENGINE_H
#define ENGINE_H

class Engine
{
    int Field[81];
    int SolvedField[81];
    int FreshField[81];
    int ErrorCounter;
public:
    Engine();
    int Value(int x, int y);
    int DefaultValue(int x, int y);
    bool Filled();
    bool MakeMove(int x, int y, int num);
    bool Legal(int x, int y, int num);
    bool ClearCell(int x, int y);
    bool Solve(int x, int y);
    void StartGame(bool isHard);
    void Print();
    void Solve();
    void Hint();
    void Refresh();
};

#endif // ENGINE_H
