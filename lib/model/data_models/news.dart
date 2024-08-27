

class News {
   String? title;
   String? description;
   String? url;

  News({
    required this.title,
    required this.description,
    required this.url,
  });

  News.fromJson(Map<String, dynamic> json) {
    title= json['title'];
    description= json['description']??"No description";
    url= json['url'];
  }

}
