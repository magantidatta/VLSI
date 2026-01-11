void full_adder(
    bool a,
    bool b,
    bool cin,
    bool &sum,
    bool &cout
) {
    sum  = a ^ b ^ cin;
    cout = (a & b) | (b & cin) | (a & cin);
}
