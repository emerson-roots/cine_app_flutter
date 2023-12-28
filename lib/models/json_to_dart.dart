class Cinema {
  int? id;
  int? amrCidadeRegiaoId;
  String? nomeCinema;
  String? endereco;
  double? longitude;
  double? latitude;
  double? notaAvaliacao;
  List<FotosCinema>? fotosCinema;
  Cidade? cidade;
  List<Filmes>? filmes;

  Cinema(
      {this.id,
        this.amrCidadeRegiaoId,
        this.nomeCinema,
        this.endereco,
        this.longitude,
        this.latitude,
        this.notaAvaliacao,
        this.fotosCinema,
        this.cidade,
        this.filmes});

  Cinema.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amrCidadeRegiaoId = json['amrCidadeRegiaoId'];
    nomeCinema = json['nomeCinema'];
    endereco = json['endereco'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    notaAvaliacao = json['notaAvaliacao'];
    if (json['fotosCinema'] != null) {
      fotosCinema = <FotosCinema>[];
      json['fotosCinema'].forEach((v) {
        fotosCinema!.add(new FotosCinema.fromJson(v));
      });
    }
    cidade =
    json['cidade'] != null ? new Cidade.fromJson(json['cidade']) : null;
    if (json['filmes'] != null) {
      filmes = <Filmes>[];
      json['filmes'].forEach((v) {
        filmes!.add(new Filmes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amrCidadeRegiaoId'] = this.amrCidadeRegiaoId;
    data['nomeCinema'] = this.nomeCinema;
    data['endereco'] = this.endereco;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['notaAvaliacao'] = this.notaAvaliacao;
    if (this.fotosCinema != null) {
      data['fotosCinema'] = this.fotosCinema!.map((v) => v.toJson()).toList();
    }
    if (this.cidade != null) {
      data['cidade'] = this.cidade!.toJson();
    }
    if (this.filmes != null) {
      data['filmes'] = this.filmes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FotosCinema {
  int? id;
  int? cinemaId;
  String? foto;

  FotosCinema({this.id, this.cinemaId, this.foto});

  FotosCinema.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cinemaId = json['cinemaId'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cinemaId'] = this.cinemaId;
    data['foto'] = this.foto;
    return data;
  }
}

class Cidade {
  int? id;
  String? estado;
  String? descricao;

  Cidade({this.id, this.estado, this.descricao});

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estado'] = this.estado;
    data['descricao'] = this.descricao;
    return data;
  }
}

class Filmes {
  int? id;
  String? nomeFilme;
  String? sinopse;
  String? diretor;
  String? idioma;
  int? duracao;
  int? notaAvaliacao;
  String? fotoCapaFilme;
  int? faixaEtaria;
  String? categoria;
  List<Sessoes>? sessoes;

  Filmes(
      {this.id,
        this.nomeFilme,
        this.sinopse,
        this.diretor,
        this.idioma,
        this.duracao,
        this.notaAvaliacao,
        this.fotoCapaFilme,
        this.faixaEtaria,
        this.categoria,
        this.sessoes});

  Filmes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeFilme = json['nomeFilme'];
    sinopse = json['sinopse'];
    diretor = json['diretor'];
    idioma = json['idioma'];
    duracao = json['duracao'];
    notaAvaliacao = json['notaAvaliacao'];
    fotoCapaFilme = json['fotoCapaFilme'];
    faixaEtaria = json['faixaEtaria'];
    categoria = json['categoria'];
    if (json['sessoes'] != null) {
      sessoes = <Sessoes>[];
      json['sessoes'].forEach((v) {
        sessoes!.add(new Sessoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomeFilme'] = this.nomeFilme;
    data['sinopse'] = this.sinopse;
    data['diretor'] = this.diretor;
    data['idioma'] = this.idioma;
    data['duracao'] = this.duracao;
    data['notaAvaliacao'] = this.notaAvaliacao;
    data['fotoCapaFilme'] = this.fotoCapaFilme;
    data['faixaEtaria'] = this.faixaEtaria;
    data['categoria'] = this.categoria;
    if (this.sessoes != null) {
      data['sessoes'] = this.sessoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessoes {
  int? id;
  int? filmeCinemaId;
  String? dataHora;

  Sessoes({this.id, this.filmeCinemaId, this.dataHora});

  Sessoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filmeCinemaId = json['filmeCinemaId'];
    dataHora = json['dataHora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filmeCinemaId'] = this.filmeCinemaId;
    data['dataHora'] = this.dataHora;
    return data;
  }
}
