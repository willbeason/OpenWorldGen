#include <iostream>
#include <curses.h>

using namespace std;

int menu {
  cout << "Welcome to OpenWorldGen by William Beason.\n";
  cout << "Are there any options you would like to change?\n";
  cout << "(1) View Options\n";
  cout << "(2) Render\n";
  cout << "(3) Quit\n";
  cout << "Enter choice: ";
  cin >> menu.choice;
  cout << endl;
}

int displayOptions {
  return(0);
}

int main() {
  int picWidth = 1600;
  int picHeight = 800;
 
  double seaLevel = 0.71;
  double max.feature.size = 3000;
  
  int depth = 5;
  
  bool inprog = TRUE;
  int menu.choice = 0;
 
  while (inprog) {
    menu.choice = menu();
    
    switch (menu.choice)
      case 3:
        inprog = FALSE;
        break;
      case 1:
        // Display options
        break;
      case 2:
        system("Rscript render.R");
        // Render world
        break;
      default:
        cout << "Invalid Menu Choice.\n";
  }
  
}
