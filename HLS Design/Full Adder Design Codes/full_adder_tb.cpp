#include <iostream>
using namespace std;

// DUT declaration
void full_adder(bool a, bool b, bool cin, bool &sum, bool &carry);

int main() {
    bool a, b, cin;
    bool sum, carry;

    cout << "A B Cin | Sum Carry" << endl;
    cout << "-------------------" << endl;

    for (int i = 0; i < 8; i++) {
        a   = (i >> 2) & 1;
        b   = (i >> 1) & 1;
        cin = (i >> 0) & 1;

        full_adder(a, b, cin, sum, carry);

        cout << a << " "
             << b << "  "
             << cin << "  |  "
             << sum << "     "
             << carry << endl;
    }

    return 0;
}
