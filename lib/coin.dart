class Coin {
  Coin({
    required this.coinE,
    required this.e,
    required this.s,
    required this.coinT,
    required this.p,
    required this.q,
    required this.b,
    required this.a,
    required this.t,
    required this.coinM,
    required this.m,
  });

  String coinE;
  int e;
  String s;
  int coinT;
  String p;
  String q;
  int b;
  int a;
  int t;
  bool coinM;
  bool m;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        coinE: json['e'] as String,
        e: json['E'] as int,
        s: json['s'] as String,
        coinT: json['t'] as int,
        p: json['p'] as String,
        q: json['q'] as String,
        b: json['b'] as int,
        a: json['a'] as int,
        t: json['T'] as int,
        coinM: json['m'] as bool,
        m: json['M'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'e': coinE,
        'E': e,
        's': s,
        't': coinT,
        'p': p,
        'q': q,
        'b': b,
        'a': a,
        'T': t,
        'm': coinM,
        'M': m,
      };
}
