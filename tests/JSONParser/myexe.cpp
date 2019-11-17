#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

vector<string> getNames();
bool compare(std::string a, std::string b);

int main() {
    vector<string> names = getNames();

    sort(names.begin(), names.end(), compare);

    for (int i = 0; i < names.capacity(); ++i) {
        cout << names[i] << endl;
    }
}

bool compare(std::string a, std::string b) {
    return a < b;
}

vector<string> getNames() {
    return {
            "Bjorn",
            "Henk",
            "Willem",
            "Cedric",
            "Cheniqua",
            "Chantal",
            "Patricia",
            "JanRoderikWillemFriso",
            "Hans",
            "Heinrich",
            "Flip",
            "Edgar"
    };
}