#include "engine.h"
#include <cstring>
#include <fstream>
#include <random>
#include <iostream>
#include <ctime>

#define SIZE(x) (sizeof(x) / sizeof(x[0]))

Engine::Engine()
{

}

int Engine::Value(int x, int y)
{
    if (x < 0 || x > 8 || y < 0 | y > 8)
        return 0;
    return Field[y*9 + x];
}

int Engine::DefaultValue(int x, int y)
{
    if (x < 0 || x > 8 || y < 0 | y > 8)
        return 0;
    return FreshField[y*9 + x];
}

void Engine::StartGame()
{
    memset(Field, 0, 81);
    memset(FreshField, 0, 81);
    memset(SolvedField, 0, 81);
    ErrorCounter = 0;

    int num = 0;
    int numLines = 0;

    std::ifstream inFile;
    std::string str;
    inFile.open("tables.txt");
    while (std::getline(inFile, str))
       ++numLines;

    inFile.close();

    std::mt19937 gen(time(NULL));
    std::uniform_int_distribution<> distr(0, numLines);

    numLines = distr(gen);

    inFile.open("tables.txt");

    for (int i = 0; i < numLines; ++i)
        std::getline(inFile, str);

    for (int i = 0; i < 81; ++i) {
        inFile >> num;
        if (num >= 0 && num <= 9) {

            Field[i] = num;
            FreshField[i] = num;
            SolvedField[i] = num;
        }
    }
    Solve(0,0);

    inFile.close();

}

void Engine::Solve()
{
    for (int i = 0; i < 81; ++i) {
        Field[i] = SolvedField[i];
    }
}

bool Engine::Solve(int x, int y)
{

    if (x + y*9 >= 81) return true;

    if (x >= 9) {
        ++y;
        x = 0;
    }

    if (SolvedField[x + y*9] > 0) return Solve(x+1, y);

    for (int num = 1; num <= 9; ++num) {

        if (Legal(x, y, num)) {

            SolvedField[x + y*9] = num;

            if (Solve(x+1, y)) return true;
        }
        SolvedField[x + y*9] = 0;
    }
    return false;
}

void Engine::Hint()
{
    int temp[81];
    int count = 0;

    for (size_t i = 0; i < SIZE(Field); ++i) {
        if (Field[i]) continue;
        temp[count++] = i;
    }

    if (!count)
        return;

    std::mt19937 gen(time(NULL));
    std::uniform_int_distribution<> distr(0, count - 1);

    int square_num = temp[distr(gen)];
    Field[square_num] = SolvedField[square_num];
}

void Engine::Print()
{
    for (int i = 0; i <9 ; ++i){
        for (int j = 0; j < 9; ++j){
            std::cout << Field[i*9 + j] << " ";
        }
        std::cout << std::endl;
    }

    std::cout << std::endl;

    if (Solve(0,0)) {
        for (int i = 0; i <9 ; ++i) {
            for (int j = 0; j < 9; ++j) {
                std::cout << Field[i*9 + j] << " ";
            }
            std::cout << std::endl;
        }
    }
}

bool Engine::Legal(int x, int y, int num)
{
    if (num < 1 || num > 9) return false;

//kontrolli rida
    for (int i = 0; i < 9; ++i) {
        if(SolvedField[y * 9 + i] == num) return false;
    }

//kontrolli veerg
    for (int i = 0; i < 9; ++i) {
        if(SolvedField[x + i*9] == num) return false;
    }

//kontrolli ruut
    int startRow = y - y % 3,
            startCol = x - x % 3;

    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            if (SolvedField[(i + startRow) * 9 + j + startCol] == num) return false;
    return true;
}

bool Engine::MakeMove(int x, int y, int num)
{
    if (num != SolvedField[y * 9 + x])
        return false;
    Field[y*9 + x] = num;
    return true;
}

bool Engine::ClearCell(int x, int y)
{
    if (FreshField[y*9 + x])
        return false;
    Field[y*9 + x] = 0;
    return true;
}

void Engine::Refresh()
{
    for (int i = 0; i < 81; ++i) {
        Field[i] = FreshField[i];
    }
}
