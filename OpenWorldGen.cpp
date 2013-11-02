#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>
#include <curses.h>

using namespace std;

int menu() {
  int choice;
  cout << "Welcome to OpenWorldGen by William Beason.\n";
  cout << "(1) View Options\n";
  cout << "(2) Render\n";
  cout << "(3) Quit\n";
  cout << "Enter choice: ";
  cin >> choice;
  cout << endl;
  return choice;
}

void displayOptions() {
  ifstream inFile;
  string cur_line;
  
  inFile.open("settings.dat");
  if (inFile.is_open())
  {
    while ( getline (inFile,cur_line) )
    {
      cout << cur_line << endl;
    }
  }
  cout << endl;
  inFile.close();
}

int main() {
  
  bool inprog = TRUE;
  int menu_choice = 0;
 
  while (inprog) {
    menu_choice = menu();
    
    switch (menu_choice)
    {
      case 3:
        inprog = FALSE;
        break;
      case 1:
        displayOptions();
        break;
      case 2:
        // system("Rscript render.R");
        // Render world
        break;
      default:
        cout << "Invalid Menu Choice.\n";
    }
  }
  
}
