class Meta {
  int? found;
  int? returned;
  int? limit;
  int? page;

  Meta({this.found, this.returned, this.limit, this.page});

  Meta.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    returned = json['returned'];
    limit = json['limit'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() => {
        'found': found,
        'returned': returned,
        'limit': limit,
        'page': page,
      };
}
