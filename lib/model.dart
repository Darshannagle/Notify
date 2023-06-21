
class Model {
  late int? id;
  late final String? title;
late final String? desc;
late final String? dateTime;


Model({this.id,this.title, this.desc,this.dateTime});
Model.fromMap( Map<String,dynamic> res):
      id = res['id'],
      title = res['title']
,desc = res['desc'],dateTime = res['dateTime'];
Map<String,Object?> toMap() => {
          'id':id,'title':title,'desc':desc,'dateTime':dateTime,
        };
}